import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:vibe_coding_test/core/api/api_constants.dart';
import 'package:vibe_coding_test/core/api/auth_interceptor.dart';
import 'package:vibe_coding_test/core/exceptions/app_exception.dart';

/// Sole HTTP entry point. Repositories must not call `package:http` directly.
class ApiClient {
  ApiClient({
    http.Client? httpClient,
    AuthInterceptor? authInterceptor,
  })  : _httpClient = httpClient ?? http.Client(),
        _authInterceptor = authInterceptor;

  final http.Client _httpClient;
  AuthInterceptor? _authInterceptor;

  void attachInterceptor(AuthInterceptor interceptor) {
    _authInterceptor = interceptor;
  }

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
    bool authenticated = false,
  }) {
    return _send(
      method: 'POST',
      path: path,
      body: body,
      authenticated: authenticated,
    );
  }

  Future<Map<String, dynamic>> get(
    String path, {
    bool authenticated = true,
  }) {
    return _send(
      method: 'GET',
      path: path,
      authenticated: authenticated,
    );
  }

  Future<Map<String, dynamic>> _send({
    required String method,
    required String path,
    Map<String, dynamic>? body,
    required bool authenticated,
    int attempt = 0,
  }) async {
    try {
      final uri = Uri.parse(ApiConstants.url(path));
      var headers = <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      if (_authInterceptor != null) {
        headers = await _authInterceptor!.applyHeaders(
          headers,
          authenticated: authenticated,
        );
      }

      late http.Response response;
      final request = http.Request(method, uri)
        ..headers.addAll(headers)
        ..body = body == null ? '' : jsonEncode(body);

      final streamed = await _httpClient
          .send(request)
          .timeout(ApiConstants.timeout);
      response = await http.Response.fromStream(streamed);

      if (response.statusCode == 401 &&
          authenticated &&
          _authInterceptor != null &&
          attempt == 0) {
        final refreshed = await _authInterceptor!.tryRefresh();
        if (refreshed) {
          return _send(
            method: method,
            path: path,
            body: body,
            authenticated: authenticated,
            attempt: 1,
          );
        }
        throw const UnauthorizedException();
      }

      return _mapResponse(response);
    } on TimeoutException {
      if (attempt < ApiConstants.maxRetries) {
        return _send(
          method: method,
          path: path,
          body: body,
          authenticated: authenticated,
          attempt: attempt + 1,
        );
      }
      throw const NetworkException();
    } on SocketException {
      if (attempt < ApiConstants.maxRetries) {
        return _send(
          method: method,
          path: path,
          body: body,
          authenticated: authenticated,
          attempt: attempt + 1,
        );
      }
      throw const NetworkException();
    } on AppException {
      rethrow;
    } on http.ClientException {
      throw const NetworkException();
    } catch (_) {
      throw const UnknownException();
    }
  }

  Map<String, dynamic> _mapResponse(http.Response response) {
    Map<String, dynamic> json = {};
    if (response.body.isNotEmpty) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) {
        json = decoded;
      }
    }

    final status = response.statusCode;
    if (status >= 200 && status < 300) {
      return json;
    }

    final message = json['message'] as String?;

    if (status == 401) {
      throw UnauthorizedException(message ?? 'Invalid username or password');
    }
    if (status == 400 || status == 422) {
      final rawErrors = json['errors'];
      final fieldErrors = <String, List<String>>{};
      if (rawErrors is Map) {
        for (final entry in rawErrors.entries) {
          fieldErrors[entry.key.toString()] =
              (entry.value as List<dynamic>).map((e) => e.toString()).toList();
        }
      }
      throw ValidationException(
        message ?? 'Validation Failed',
        fieldErrors: fieldErrors,
      );
    }
    if (status >= 500) {
      throw ServerException(message ?? 'Something went wrong. Please try again later.');
    }
    throw UnknownException(message ?? 'An unexpected error occurred.');
  }
}
