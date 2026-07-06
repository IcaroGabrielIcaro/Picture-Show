enum ApiErrorType { network, server, unauthorized, unknown }

class ApiException implements Exception {
  final ApiErrorType type;

  final String message;
  final int? statusCode;
  final Map<String, List<String>>? fieldErrors;

  const ApiException({
    required this.type,
    required this.message,
    this.statusCode,
    this.fieldErrors,
  });
}
