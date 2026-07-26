import 'package:vibe_coding_test/core/api/api_client.dart';
import 'package:vibe_coding_test/core/api/api_constants.dart';
import 'package:vibe_coding_test/core/exceptions/app_exception.dart';
import 'package:vibe_coding_test/core/storage/secure_storage_service.dart';
import 'package:vibe_coding_test/features/authentication/model/login_request.dart';
import 'package:vibe_coding_test/features/authentication/model/login_response.dart';

class LoginRepository {
  LoginRepository({
    required ApiClient apiClient,
    required SecureStorageService secureStorage,
  })  : _apiClient = apiClient,
        _secureStorage = secureStorage;

  final ApiClient _apiClient;
  final SecureStorageService _secureStorage;

  Future<AuthResult> login(LoginRequest request) async {
    final json = await _apiClient.post(
      ApiConstants.loginPath,
      body: request.toJson(),
      authenticated: false,
    );

    final response = LoginResponse.fromJson(json);
    if (!response.success || response.user == null || response.tokens == null) {
      throw UnauthorizedException(
        response.message.isEmpty
            ? 'Invalid username or password'
            : response.message,
      );
    }

    await _secureStorage.saveTokens(
      accessToken: response.tokens!.token,
      refreshToken: response.tokens!.refreshToken,
      expiresInSeconds: response.tokens!.expiresIn,
    );

    return AuthResult(user: response.user!, tokens: response.tokens!);
  }

  Future<bool> hasValidSession() => _secureStorage.hasValidSession();

  Future<void> logout() => _secureStorage.clear();
}
