import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibe_coding_test/core/api/api_client.dart';
import 'package:vibe_coding_test/core/api/auth_interceptor.dart';
import 'package:vibe_coding_test/core/navigation/navigation_service.dart';
import 'package:vibe_coding_test/core/storage/preferences_service.dart';
import 'package:vibe_coding_test/core/storage/secure_storage_service.dart';
import 'package:vibe_coding_test/features/authentication/repository/login_repository.dart';
import 'package:vibe_coding_test/features/authentication/validation/login_validator.dart';
import 'package:vibe_coding_test/features/authentication/viewmodel/login_viewmodel.dart';
import 'package:vibe_coding_test/app/routes.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  final prefs = await SharedPreferences.getInstance();

  getIt
    ..registerLazySingleton<NavigationService>(NavigationService.new)
    ..registerLazySingleton<SecureStorageService>(SecureStorageService.new)
    ..registerLazySingleton<PreferencesService>(
      () => PreferencesService(prefs),
    )
    ..registerLazySingleton<ApiClient>(ApiClient.new);

  final navigation = getIt<NavigationService>();
  final secureStorage = getIt<SecureStorageService>();
  final apiClient = getIt<ApiClient>();

  final interceptor = AuthInterceptor(
    secureStorage: secureStorage,
    onSessionExpired: () {
      navigation.pushNamedAndRemoveUntil(
        AppRoutes.login,
        (route) => false,
      );
    },
  );
  apiClient.attachInterceptor(interceptor);
  getIt.registerLazySingleton<AuthInterceptor>(() => interceptor);

  getIt
    ..registerLazySingleton<LoginRepository>(
      () => LoginRepository(
        apiClient: apiClient,
        secureStorage: secureStorage,
      ),
    )
    ..registerLazySingleton<LoginValidator>(LoginValidator.new)
    ..registerFactory<LoginViewModel>(
      () => LoginViewModel(
        repository: getIt<LoginRepository>(),
        validator: getIt<LoginValidator>(),
        preferences: getIt<PreferencesService>(),
        navigation: navigation,
      ),
    );
}
