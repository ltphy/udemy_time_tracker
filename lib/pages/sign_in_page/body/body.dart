import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:udemy_timer_tracker/BLoC/email_sign_in_bloc.dart';
import 'package:udemy_timer_tracker/model/email_sign_in_model.dart';
import 'package:udemy_timer_tracker/provider/auth_provider.dart';
import 'package:udemy_timer_tracker/services/dialog_services.dart';

class Body extends StatefulWidget {
  final EmailSignInBloc bloc;

  const Body({Key? key, required this.bloc}) : super(key: key);

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthenticateProvider>(context).auth;
    return Provider<EmailSignInBloc>(
      create: (_) => EmailSignInBloc(auth: auth),
      child: Consumer<EmailSignInBloc>(
        builder: (_, bloc, __) {
          return Body(bloc: bloc);
        },
      ),
      dispose: (_, bloc) => bloc.dispose(),
    );
  }

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  void _emailEditingComplete() {
    FocusScope.of(context).requestFocus(passwordFocusNode);
  }

  Future<void> _submit() async {
    try {
      if (!this._formKey.currentState!.validate()) {
        return;
      }
      await widget.bloc.submit(this._emailEditingController.text,
          this._passwordEditingController.text);
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (error) {
      print('error');
      await DialogService.instance.showExceptionDialog(context, error);
    }
  }

  @override
  void dispose() {
    super.dispose();
    this.passwordFocusNode.dispose();
    this.emailFocusNode.dispose();
    this._passwordEditingController.dispose();
    this._emailEditingController.dispose();
  }

  // does not validate when form open and only validate after the form is submitted failed.
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailSignInModel>(
      stream: widget.bloc.stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        final EmailSignInModel model = snapshot.data;
        bool? isLoading = model.isLoading;
        print('rerender');
        return (isLoading != null && isLoading)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: EdgeInsets.all(8),
                child: Card(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8.0, right: 8.0),
                            child: TextFormField(
                              focusNode: emailFocusNode,
                              controller: _emailEditingController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                border: UnderlineInputBorder(),
                              ),
                              validator: model.validateEmail,
                              textInputAction: TextInputAction.next,
                              onEditingComplete: _emailEditingComplete,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.0, right: 8.0),
                            child: TextFormField(
                              obscureText: true,
                              controller: _passwordEditingController,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                border: UnderlineInputBorder(),
                              ),
                              validator: model.validatePassword,
                              onEditingComplete: _submit,
                              textInputAction: TextInputAction.done,
                              focusNode: passwordFocusNode,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: _submit,
                              child: Text(model.formButtonText),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              this._emailEditingController.clear();
                              this._passwordEditingController.clear();
                              this._formKey.currentState!.reset();
                              print('toggle button');
                              widget.bloc.toggleButtonSwitch();
                            },
                            child: Text(model.switchFormText),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },
      initialData: EmailSignInModel(),
    );
  }
}
