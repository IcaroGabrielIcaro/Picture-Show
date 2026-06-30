import 'package:dio/dio.dart';

import 'api_exception.dart';

class DioExceptionMapper {
  static ApiException map(DioException e) {
    final data = e.response?.data;

    if (data is Map<String, dynamic>) {
      // APIs que retornam "message" ou "erro"
      if (data.containsKey('message') || data.containsKey('erro')) {
        return ApiException(
          statusCode: e.response?.statusCode,
          message: data['erro'] ?? data['message'],
        );
      }

      // DRF: erros de validação por campo
      final fieldErrors = <String, List<String>>{};
      final messages = <String>[];

      data.forEach((key, value) {
        if (value is List) {
          final errors = value.map((e) => e.toString()).toList();

          fieldErrors[key] = errors;
          messages.addAll(errors);
        } else {
          final error = value.toString();

          fieldErrors[key] = [error];
          messages.add(error);
        }
      });

      return ApiException(
        statusCode: e.response?.statusCode,
        message: messages.join('\n'),
        fieldErrors: fieldErrors,
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
