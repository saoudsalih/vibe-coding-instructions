import 'package:vibe_coding_test/core/l10n/app_strings.dart';

class LoginValidationResult {
  const LoginValidationResult({
    this.emailError,
    this.passwordError,
  });

  final String? emailError;
  final String? passwordError;

  bool get isValid => emailError == null && passwordError == null;
}

/// Field validation for login — mirrors acceptance-test.md V1–V4.
class LoginValidator {
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 128;

  LoginValidationResult validate({
    required String email,
    required String password,
  }) {
    return LoginValidationResult(
      emailError: validateEmail(email),
      passwordError: validatePassword(password),
    );
  }

  String? validateEmail(String email) {
    final trimmed = email.trim();
    if (trimmed.isEmpty) return AppStrings.emailRequired;
    if (!_emailRegex.hasMatch(trimmed)) return AppStrings.emailInvalid;
    return null;
  }

  String? validatePassword(String password) {
    if (password.isEmpty) return AppStrings.passwordRequired;
    if (password.length < minPasswordLength) {
      return AppStrings.passwordTooShort;
    }
    if (password.length > maxPasswordLength) {
      return 'Password must be at most $maxPasswordLength characters';
    }
    return null;
  }
}
