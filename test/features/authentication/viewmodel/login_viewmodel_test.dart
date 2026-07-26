import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vibe_coding_test/core/exceptions/app_exception.dart';
import 'package:vibe_coding_test/core/l10n/app_strings.dart';
import 'package:vibe_coding_test/core/navigation/navigation_service.dart';
import 'package:vibe_coding_test/core/storage/preferences_service.dart';
import 'package:vibe_coding_test/features/authentication/model/auth_tokens.dart';
import 'package:vibe_coding_test/features/authentication/model/login_request.dart';
import 'package:vibe_coding_test/features/authentication/model/login_response.dart';
import 'package:vibe_coding_test/features/authentication/model/user_model.dart';
import 'package:vibe_coding_test/features/authentication/repository/login_repository.dart';
import 'package:vibe_coding_test/features/authentication/validation/login_validator.dart';
import 'package:vibe_coding_test/features/authentication/viewmodel/login_viewmodel.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

class MockPreferencesService extends Mock implements PreferencesService {}

class MockNavigationService extends Mock implements NavigationService {}

bool _routePredicateFallback(Route<dynamic> route) => false;

void main() {
  late MockLoginRepository repository;
  late MockPreferencesService preferences;
  late MockNavigationService navigation;
  late LoginViewModel viewModel;

  setUpAll(() {
    registerFallbackValue(
      const LoginRequest(email: 'a@b.com', password: '123456'),
    );
    registerFallbackValue(_routePredicateFallback);
  });

  setUp(() {
    repository = MockLoginRepository();
    preferences = MockPreferencesService();
    navigation = MockNavigationService();
    when(() => preferences.getRememberMe()).thenReturn(false);
    when(() => preferences.getRememberedEmail()).thenReturn(null);
    when(() => preferences.setRememberMe(any())).thenAnswer((_) async {});
    when(() => preferences.setRememberedEmail(any())).thenAnswer((_) async {});
    when(
      () => navigation.pushNamedAndRemoveUntil(any(), any()),
    ).thenAnswer((_) async => null);

    viewModel = LoginViewModel(
      repository: repository,
      validator: LoginValidator(),
      preferences: preferences,
      navigation: navigation,
    );
  });

  test('invalid form does not call repository', () async {
    viewModel
      ..email = ''
      ..password = '';
    await viewModel.login();
    verifyNever(() => repository.login(any()));
    expect(viewModel.isLoading, isFalse);
    expect(viewModel.emailError, AppStrings.emailRequired);
  });

  test('success sets user, clears loading, navigates', () async {
    viewModel
      ..email = 'admin@test.com'
      ..password = '123456';

    when(() => repository.login(any())).thenAnswer(
      (_) async => const AuthResult(
        user: UserModel(
          userId: 1,
          name: 'Administrator',
          email: 'admin@test.com',
          role: 'Admin',
        ),
        tokens: AuthTokens(
          token: 't',
          refreshToken: 'r',
          expiresIn: 3600,
        ),
      ),
    );

    await viewModel.login();

    expect(viewModel.isLoading, isFalse);
    expect(viewModel.user?.email, 'admin@test.com');
    expect(viewModel.hasError, isFalse);
    verify(() => repository.login(any())).called(1);
    verify(() => navigation.pushNamedAndRemoveUntil(any(), any())).called(1);
  });

  test('failure sets error and stops loading', () async {
    viewModel
      ..email = 'admin@test.com'
      ..password = '123456';

    when(() => repository.login(any())).thenThrow(
      const UnauthorizedException(),
    );

    await viewModel.login();

    expect(viewModel.isLoading, isFalse);
    expect(viewModel.errorMessage, AppStrings.invalidCredentials);
    expect(viewModel.user, isNull);
  });

  test('duplicate submit while loading calls repository once', () async {
    viewModel
      ..email = 'admin@test.com'
      ..password = '123456';

    when(() => repository.login(any())).thenAnswer((_) async {
      await Future<void>.delayed(const Duration(milliseconds: 50));
      return const AuthResult(
        user: UserModel(
          userId: 1,
          name: 'Administrator',
          email: 'admin@test.com',
          role: 'Admin',
        ),
        tokens: AuthTokens(
          token: 't',
          refreshToken: 'r',
          expiresIn: 3600,
        ),
      );
    });

    final first = viewModel.login();
    final second = viewModel.login();
    await Future.wait([first, second]);

    verify(() => repository.login(any())).called(1);
  });
}
