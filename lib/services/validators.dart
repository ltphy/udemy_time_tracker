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

class TextLimitationValidator extends NonEmptyFieldValidator {
  @override
  bool validate(String? value) {
    bool result = super.validate(value);
    if (result) {
      if (value != null) {
        return value.length > 3 && value.length < 30;
      }
    }
    return result;
  }
}

class DoubleValidator extends NonEmptyFieldValidator {
  @override
  bool validate(String? value) {
    bool result = super.validate(value);
    if (result) {
      if (value != null) {
        double? number = double.tryParse(value);
        return number != null;
      }
    }
    return result;
  }
}

class JobValidators {
  final TextLimitationValidator _textLimitationValidator =
      TextLimitationValidator();
  final DoubleValidator _doubleValidator = DoubleValidator();
  final String textLimitationText =
      'Name length must be 3 to 10 characters long';
  final String ratePerHourText = 'Rate Per Hour must be an integer';

  String? validateName(String? value) {
    if (!_textLimitationValidator.validate(value)) {
      return textLimitationText;
    }
    return null;
  }

  String? validateRatePerHour(String? value) {
    if (!_doubleValidator.validate(value)) {
      return this.ratePerHourText;
    }
    return null;
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
