import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vibe_coding_test/core/api/api_constants.dart';
import 'package:vibe_coding_test/core/storage/secure_storage_service.dart';

/// Attaches auth headers and performs single-flight token refresh.
class AuthInterceptor {
  AuthInterceptor({
    required SecureStorageService secureStorage,
    http.Client? httpClient,
    void Function()? onSessionExpired,
  })  : _secureStorage = secureStorage,
        _httpClient = httpClient ?? http.Client(),
        _onSessionExpired = onSessionExpired;

  final SecureStorageService _secureStorage;
  final http.Client _httpClient;
  final void Function()? _onSessionExpired;

  Future<bool>? _refreshInFlight;

  Future<Map<String, String>> applyHeaders(
    Map<String, String> headers, {
    required bool authenticated,
  }) async {
    if (!authenticated) return headers;
    final token = await _secureStorage.getAccessToken();
    if (token == null || token.isEmpty) return headers;
    return {
      ...headers,
      'Authorization': 'Bearer $token',
    };
  }

  /// Returns true when refresh succeeded. Prevents concurrent refresh.
  Future<bool> tryRefresh() {
    final existing = _refreshInFlight;
    if (existing != null) return existing;

    final future = _doRefresh();
    _refreshInFlight = future;
    future.whenComplete(() {
      _refreshInFlight = null;
    });
    return future;
  }

  Future<bool> _doRefresh() async {
    final refreshToken = await _secureStorage.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      await _expireSession();
      return false;
    }

    try {
      final response = await _httpClient
          .post(
            Uri.parse(ApiConstants.url(ApiConstants.refreshPath)),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode({'refreshToken': refreshToken}),
          )
          .timeout(ApiConstants.timeout);

      if (response.statusCode < 200 || response.statusCode >= 300) {
        await _expireSession();
        return false;
      }

      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final data = json['data'] as Map<String, dynamic>?;
      final access = data?['token'] as String? ?? json['token'] as String?;
      final refresh =
          data?['refreshToken'] as String? ?? json['refreshToken'] as String?;
      final expiresIn =
          data?['expiresIn'] as int? ?? json['expiresIn'] as int? ?? 3600;

      if (access == null || refresh == null) {
        await _expireSession();
        return false;
      }

      await _secureStorage.saveTokens(
        accessToken: access,
        refreshToken: refresh,
        expiresInSeconds: expiresIn,
      );
      return true;
    } catch (_) {
      await _expireSession();
      return false;
    }
  }

  Future<void> _expireSession() async {
    await _secureStorage.clear();
    _onSessionExpired?.call();
  }
}
