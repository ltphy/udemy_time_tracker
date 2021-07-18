abstract class Validator {
  bool validate(String? value);
}

class EmailValidator implements Validator {
  @override
  bool validate(String? value) {
    if (value == null) return false;
    RegExp regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regExp.hasMatch(value);
  }
}

class NonEmptyFieldValidator implements Validator {
  @override
  bool validate(String? value) {
    if (value == null) return false;
    return value.isNotEmpty;
  }
}

class EmailAndPasswordValidators {
  final EmailValidator emailValidator = EmailValidator();
  final NonEmptyFieldValidator nonEmptyFieldValidator =
      NonEmptyFieldValidator();
  final String emptyEmailErrorText = 'Email can\'t be empty';
  final String emptyPasswordErrorText = 'Password can\'t be empty';
  final String invalidEmailErrorText = 'Email is invalid.';

  String? validateEmail(String? value) {
    if (!nonEmptyFieldValidator.validate(value)) {
      return this.emptyEmailErrorText;
    }
    if (!emailValidator.validate(value)) {
      return this.invalidEmailErrorText;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (!nonEmptyFieldValidator.validate(value)) {
      return this.emptyPasswordErrorText;
    }
    return null;
  }
}

class FormValidators {
  final String emptyFullNameField = 'Full name can\'t be empty';
  final NonEmptyFieldValidator nonEmptyFieldValidator =
      NonEmptyFieldValidator();

  String? validateFullName(String? value) {
    if (!nonEmptyFieldValidator.validate(value)) {
      return this.emptyFullNameField;
    }
    return null;
  }
}
