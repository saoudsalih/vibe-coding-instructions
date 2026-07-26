import 'package:vibe_coding_test/core/exceptions/app_exception.dart';
import 'package:vibe_coding_test/core/l10n/app_strings.dart';
import 'package:vibe_coding_test/core/navigation/navigation_service.dart';
import 'package:vibe_coding_test/core/storage/preferences_service.dart';
import 'package:vibe_coding_test/core/viewmodel/base_viewmodel.dart';
import 'package:vibe_coding_test/features/authentication/model/login_request.dart';
import 'package:vibe_coding_test/features/authentication/model/user_model.dart';
import 'package:vibe_coding_test/features/authentication/repository/login_repository.dart';
import 'package:vibe_coding_test/features/authentication/validation/login_validator.dart';
import 'package:vibe_coding_test/app/routes.dart';

class LoginViewModel extends BaseViewModel {
  LoginViewModel({
    required LoginRepository repository,
    required LoginValidator validator,
    required PreferencesService preferences,
    required NavigationService navigation,
  })  : _repository = repository,
        _validator = validator,
        _preferences = preferences,
        _navigation = navigation;

  final LoginRepository _repository;
  final LoginValidator _validator;
  final PreferencesService _preferences;
  final NavigationService _navigation;

  String email = '';
  String password = '';
  bool rememberMe = false;
  bool obscurePassword = true;
  String? emailError;
  String? passwordError;
  UserModel? user;

  void init() {
    rememberMe = _preferences.getRememberMe();
    final remembered = _preferences.getRememberedEmail();
    if (rememberMe && remembered != null) {
      email = remembered;
    }
  }

  void updateEmail(String value) {
    email = value;
    emailError = null;
    clearError();
    notifyListeners();
  }

  void updatePassword(String value) {
    password = value;
    passwordError = null;
    clearError();
    notifyListeners();
  }

  void toggleRememberMe(bool? value) {
    rememberMe = value ?? false;
    notifyListeners();
  }

  void toggleObscurePassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  Future<void> login() async {
    if (isLoading) return;

    clearError();
    final validation = _validator.validate(email: email, password: password);
    emailError = validation.emailError;
    passwordError = validation.passwordError;
    notifyListeners();

    if (!validation.isValid) return;

    setLoading(true);
    try {
      final result = await _repository.login(
        LoginRequest(email: email.trim(), password: password),
      );
      user = result.user;

      await _preferences.setRememberMe(rememberMe);
      await _preferences.setRememberedEmail(
        rememberMe ? email.trim() : null,
      );

      setLoading(false);
      await _navigation.pushNamedAndRemoveUntil(
        AppRoutes.dashboard,
        (route) => false,
      );
    } on AppException catch (e) {
      setLoading(false);
      notifyError(_mapError(e));
    } catch (_) {
      setLoading(false);
      notifyError(AppStrings.serverError);
    }
  }

  String _mapError(AppException e) {
    return switch (e) {
      UnauthorizedException() =>
        e.message.isEmpty ? AppStrings.invalidCredentials : e.message,
      NetworkException() => AppStrings.networkError,
      ValidationException() =>
        e.message.isEmpty ? AppStrings.validationFailed : e.message,
      ServerException() => AppStrings.serverError,
      UnknownException() => AppStrings.serverError,
    };
  }

  Future<void> logout() async {
    await _repository.logout();
    user = null;
    password = '';
    await _navigation.pushNamedAndRemoveUntil(
      AppRoutes.login,
      (route) => false,
    );
  }
}
