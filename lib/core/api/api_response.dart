/// Generic API envelope wrapper.
class ApiResponse<T> {
  const ApiResponse({
    required this.success,
    required this.message,
    this.data,
    this.errors,
  });

  final bool success;
  final String message;
  final T? data;
  final Map<String, List<String>>? errors;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json)? fromJsonT,
  ) {
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

    return ApiResponse<T>(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      data: json['data'] == null || fromJsonT == null
          ? null
          : fromJsonT(json['data']),
      errors: errors,
    );
  }
}
