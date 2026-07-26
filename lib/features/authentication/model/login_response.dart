import 'package:vibe_coding_test/features/authentication/model/auth_tokens.dart';
import 'package:vibe_coding_test/features/authentication/model/user_model.dart';

/// Login API envelope — maps success / error shapes from models.md.
class LoginResponse {
  const LoginResponse({
    required this.success,
    required this.message,
    this.user,
    this.tokens,
    this.errors,
  });

  final bool success;
  final String message;
  final UserModel? user;
  final AuthTokens? tokens;
  final Map<String, List<String>>? errors;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>?;
    final rawErrors = json['errors'];
    Map<String, List<String>>? errors;
    if (rawErrors is Map) {
      errors = rawErrors.map(
        (key, value) => MapEntry(
          key.toString(),
          (value as List<dynamic>).map((e) => e.toString()).toList(),
        ),
      );
    }

    return LoginResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      user: data == null ? null : UserModel.fromJson(data),
      tokens: data == null ? null : AuthTokens.fromJson(data),
      errors: errors,
    );
  }
}

/// Combined auth result returned by repository (no raw Map).
class AuthResult {
  const AuthResult({
    required this.user,
    required this.tokens,
  });

  final UserModel user;
  final AuthTokens tokens;
}
