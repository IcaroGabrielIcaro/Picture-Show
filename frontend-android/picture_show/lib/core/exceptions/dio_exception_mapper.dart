import 'package:dio/dio.dart';

import 'api_exception.dart';

class DioExceptionMapper {
  static ApiException map(DioException e) {
    final data = e.response?.data;

    if (data is Map<String, dynamic>) {
      return ApiException(
        statusCode: e.response?.statusCode,
        message: data['erro'] ?? data['message'] ?? 'Erro desconhecido.',
      );
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return const ApiException(message: 'Tempo de conexão esgotado.');

      case DioExceptionType.receiveTimeout:
        return const ApiException(message: 'Tempo de resposta esgotado.');

      case DioExceptionType.connectionError:
        return const ApiException(message: 'Sem conexão com a internet.');

      default:
        return ApiException(
          statusCode: e.response?.statusCode,
          message: 'Erro ao comunicar com o servidor.',
        );
    }
  }
}
