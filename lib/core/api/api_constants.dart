abstract final class ApiConstants {
  static const String baseUrl = 'https://api.company.com';
  static const String apiVersion = 'v1';
  static const Duration timeout = Duration(seconds: 30);
  static const int maxRetries = 3;

  static const String loginPath = '/$apiVersion/auth/login';
  static const String refreshPath = '/$apiVersion/auth/refresh';

  static String url(String path) => '$baseUrl$path';
}
