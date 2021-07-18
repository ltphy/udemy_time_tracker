import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:udemy_timer_tracker/services/sign_in_services.dart';
import 'package:udemy_timer_tracker/services/validators.dart';

class Body extends StatefulWidget {
  final Auth auth;

  const Body({
    Key? key,
    required this.auth,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

enum FormType { signIn, register }

class _BodyState extends State<Body>
    with FormValidators, EmailAndPasswordValidators {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  FormType _formType = FormType.signIn;
  final _formKey = GlobalKey<FormState>();

  void _emailEditingComplete() {
    FocusScope.of(context).requestFocus(passwordFocusNode);
  }

  Future<void> _submit() async {
// or validate here first
    if (!this._formKey.currentState!.validate()) {
      return;
    }
    if (this._formType == FormType.signIn) {
      final user = await widget.auth.signInWithEmail(
        email: _emailEditingController.text,
        password: _passwordEditingController.text,
      );
      if (user != null) {
        Navigator.of(context).pop();
      }
    } else {
      final user = await widget.auth.registerNewAccount(
        email: _emailEditingController.text,
        password: _passwordEditingController.text,
      );
      if (user != null) {
        Navigator.of(context).pop();
      }
    }
  }

  // does not validate when form open and only validate after the form is submitted failed.
  @override
  Widget build(BuildContext context) {
    return Container(
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
                      validator: validateEmail,
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
                      validator: validatePassword,
                      onEditingComplete: _submit,
                      textInputAction: TextInputAction.done,
                      focusNode: passwordFocusNode,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: _submit,
                      child: this._formType == FormType.register
                          ? Text('Register')
                          : Text('Sign in'),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      this._emailEditingController.clear();
                      this._passwordEditingController.clear();
                      this._formKey.currentState!.reset();
                      this._formType = this._formType == FormType.register
                          ? FormType.signIn
                          : FormType.register;
                      this.setState(() {});
                    },
                    child: this._formType == FormType.register
                        ? Text('Got an account, Sign in')
                        : Text('Need an account, Register?'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
