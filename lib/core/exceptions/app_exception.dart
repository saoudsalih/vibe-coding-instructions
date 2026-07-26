/// Base application exception. Throw only subclasses of this type.
sealed class AppException implements Exception {
  const AppException(this.message, {this.code});

  final String message;
  final String? code;

  @override
  String toString() => message;
}

final class NetworkException extends AppException {
  // ignore: use_super_parameters
  const NetworkException([
    String message = 'Network unavailable. Please check your connection.',
  ]) : super(message);
}

final class ValidationException extends AppException {
  const ValidationException(
    super.message, {
    this.fieldErrors = const {},
    super.code,
  });

  final Map<String, List<String>> fieldErrors;
}

final class UnauthorizedException extends AppException {
  // ignore: use_super_parameters
  const UnauthorizedException([
    String message = 'Invalid username or password',
  ]) : super(message);
}

final class ServerException extends AppException {
  // ignore: use_super_parameters
  const ServerException([
    String message = 'Something went wrong. Please try again later.',
  ]) : super(message);
}

final class UnknownException extends AppException {
  // ignore: use_super_parameters
  const UnknownException([
    String message = 'An unexpected error occurred.',
  ]) : super(message);
}
