import 'package:udemy_timer_tracker/services/validators.dart';

enum FormType { signIn, register }

class EmailSignInModel with FormValidators, EmailAndPasswordValidators {
  final FormType? formType;
  final bool? isLoading;

  EmailSignInModel({
    this.formType: FormType.signIn,
    this.isLoading: false,
  });

  EmailSignInModel copyWith({FormType? formType, bool? isLoading}) {
    return EmailSignInModel(
      formType: formType ?? this.formType,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  String get switchFormText => this.formType == FormType.register
      ? 'Got an account, Sign in'
      : 'Need an account, Register?';

  String get formButtonText =>
      this.formType == FormType.register ? 'Register' : 'Sign in';
}
