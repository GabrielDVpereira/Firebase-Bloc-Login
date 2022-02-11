import 'package:formz/formz.dart';

enum ConfirmPasswordValidationError { invalid }

class ConfirmedPassword
    extends FormzInput<String, ConfirmPasswordValidationError> {
  final String password;

  const ConfirmedPassword.pure({
    this.password = '',
  }) : super.pure('');

  const ConfirmedPassword.dirty({
    required this.password,
    String value = '',
  }) : super.dirty(value);

  static final _passwordRegExp =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  @override
  ConfirmPasswordValidationError? validator(String? value) {
    if (!isFormatValid(value) || !isPasswordMatch(value))
      return ConfirmPasswordValidationError.invalid;
  }

  bool isFormatValid(String? value) {
    return _passwordRegExp.hasMatch(value ?? '');
  }

  bool isPasswordMatch(String? value) {
    return value == password;
  }
}
