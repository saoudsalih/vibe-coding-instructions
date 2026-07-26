import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vibe_coding_test/core/api/api_client.dart';
import 'package:vibe_coding_test/core/api/api_constants.dart';
import 'package:vibe_coding_test/core/exceptions/app_exception.dart';
import 'package:vibe_coding_test/core/storage/secure_storage_service.dart';
import 'package:vibe_coding_test/features/authentication/model/login_request.dart';
import 'package:vibe_coding_test/features/authentication/repository/login_repository.dart';

class MockApiClient extends Mock implements ApiClient {}

class MockSecureStorageService extends Mock implements SecureStorageService {}

void main() {
  late MockApiClient apiClient;
  late MockSecureStorageService secureStorage;
  late LoginRepository repository;

  setUpAll(() {
    registerFallbackValue(<String, dynamic>{});
  });

  setUp(() {
    apiClient = MockApiClient();
    secureStorage = MockSecureStorageService();
    repository = LoginRepository(
      apiClient: apiClient,
      secureStorage: secureStorage,
    );
  });

  final successJson = {
    'success': true,
    'message': 'Login successful',
    'data': {
      'userId': 1,
      'name': 'Administrator',
      'email': 'admin@test.com',
      'role': 'Admin',
      'token': 'access_token',
      'refreshToken': 'refresh_token_123',
      'expiresIn': 3600,
    },
  };

  test('success maps JSON to AuthResult and stores tokens', () async {
    when(
      () => apiClient.post(
        ApiConstants.loginPath,
        body: any(named: 'body'),
        authenticated: false,
      ),
    ).thenAnswer((_) async => successJson);
    when(
      () => secureStorage.saveTokens(
        accessToken: any(named: 'accessToken'),
        refreshToken: any(named: 'refreshToken'),
        expiresInSeconds: any(named: 'expiresInSeconds'),
      ),
    ).thenAnswer((_) async {});

    final result = await repository.login(
      const LoginRequest(email: 'admin@test.com', password: '123456'),
    );

    expect(result.user.email, 'admin@test.com');
    expect(result.user.name, 'Administrator');
    expect(result.tokens.token, 'access_token');
    verify(
      () => secureStorage.saveTokens(
        accessToken: 'access_token',
        refreshToken: 'refresh_token_123',
        expiresInSeconds: 3600,
      ),
    ).called(1);
  });

  test('401 throws UnauthorizedException', () async {
    when(
      () => apiClient.post(
        ApiConstants.loginPath,
        body: any(named: 'body'),
        authenticated: false,
      ),
    ).thenThrow(const UnauthorizedException());

    expect(
      () => repository.login(
        const LoginRequest(email: 'admin@test.com', password: 'bad'),
      ),
      throwsA(isA<UnauthorizedException>()),
    );
  });

  test('network unavailable throws NetworkException', () async {
    when(
      () => apiClient.post(
        ApiConstants.loginPath,
        body: any(named: 'body'),
        authenticated: false,
      ),
    ).thenThrow(const NetworkException());

    expect(
      () => repository.login(
        const LoginRequest(email: 'admin@test.com', password: '123456'),
      ),
      throwsA(isA<NetworkException>()),
    );
  });
}
