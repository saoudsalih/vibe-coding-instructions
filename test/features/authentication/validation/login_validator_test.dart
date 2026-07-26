import 'package:flutter_test/flutter_test.dart';
import 'package:vibe_coding_test/core/l10n/app_strings.dart';
import 'package:vibe_coding_test/features/authentication/validation/login_validator.dart';

void main() {
  late LoginValidator validator;

  setUp(() {
    validator = LoginValidator();
  });

  group('LoginValidator email', () {
    test('required when empty', () {
      expect(validator.validateEmail(''), AppStrings.emailRequired);
      expect(validator.validateEmail('   '), AppStrings.emailRequired);
    });

    test('invalid format', () {
      expect(validator.validateEmail('not-an-email'), AppStrings.emailInvalid);
      expect(validator.validateEmail('a@b'), AppStrings.emailInvalid);
    });

    test('valid email', () {
      expect(validator.validateEmail('admin@test.com'), isNull);
    });
  });

  group('LoginValidator password', () {
    test('required when empty', () {
      expect(validator.validatePassword(''), AppStrings.passwordRequired);
    });

    test('min length', () {
      expect(validator.validatePassword('12345'), AppStrings.passwordTooShort);
    });

    test('valid password', () {
      expect(validator.validatePassword('123456'), isNull);
    });
  });

  group('LoginValidator combined', () {
    test('V1 empty email and password', () {
      final result = validator.validate(email: '', password: '');
      expect(result.isValid, isFalse);
      expect(result.emailError, AppStrings.emailRequired);
      expect(result.passwordError, AppStrings.passwordRequired);
    });

    test('V4 valid credentials', () {
      final result = validator.validate(
        email: 'admin@test.com',
        password: '123456',
      );
      expect(result.isValid, isTrue);
    });
  });
}
