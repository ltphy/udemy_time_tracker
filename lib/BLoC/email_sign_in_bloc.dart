import 'dart:async';

import 'package:udemy_timer_tracker/model/email_sign_in_model.dart';
import 'package:udemy_timer_tracker/services/sign_in_services.dart';

class EmailSignInBloc {
  final StreamController<EmailSignInModel> _modelController =
      StreamController<EmailSignInModel>();
  final BaseAuth auth;

  EmailSignInModel _model = EmailSignInModel();

  EmailSignInBloc({required this.auth});

  Stream<EmailSignInModel> get stream => _modelController.stream;

  void dispose() {
    _modelController.close();
  }

  void updateWith({FormType? formType, bool? isLoading}) {
     this._model =
        _model.copyWith(formType: formType, isLoading: isLoading);
    _modelController.add(this._model);
  }

  Future<void> submit(String email, String password) async {
    // this one is not very suitable to use with stream
    this.updateWith(isLoading: true);
    try {
      if (_model.formType == FormType.signIn) {
        await auth.signInWithEmail(email: email, password: password);
      } else {
        await auth.registerNewAccount(email: email, password: password);
      }
    } catch (error) {
      this.updateWith(isLoading: false);
      rethrow;
    }
  }

  void toggleButtonSwitch() {
    FormType formType = this._model.formType == FormType.signIn
        ? FormType.register
        : FormType.signIn;
    this.updateWith(formType: formType);
  }
}
