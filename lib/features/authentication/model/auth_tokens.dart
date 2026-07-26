/// Access + refresh tokens from login success `data` — see models.md.
class AuthTokens {
  const AuthTokens({
    required this.token,
    required this.refreshToken,
    required this.expiresIn,
  });

  final String token;
  final String refreshToken;
  final int expiresIn;

  factory AuthTokens.fromJson(Map<String, dynamic> json) {
    return AuthTokens(
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String,
      expiresIn: json['expiresIn'] as int? ?? 3600,
    );
  }
}
