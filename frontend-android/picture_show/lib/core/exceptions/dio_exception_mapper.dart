import 'dart:io';

import 'package:dio/dio.dart';

import 'api_exception.dart';

class DioExceptionMapper {
  static ApiException map(DioException e) {
    final data = e.response?.data;

    if (data is Map<String, dynamic>) {
      // APIs que retornam "message" ou "erro"
      if (data.containsKey('message') || data.containsKey('erro')) {
        return ApiException(
          type: _mapStatusCode(e.response?.statusCode),
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
        type: _mapStatusCode(e.response?.statusCode),
        statusCode: e.response?.statusCode,
        message: messages.join('\n'),
        fieldErrors: fieldErrors,
      );
    }

    // Falha SSL
    if (e.error is HandshakeException) {
      return const ApiException(
        type: ApiErrorType.network,
        message: 'Falha ao validar o certificado do servidor.',
      );
    }

    // Sem conexão
    if (e.error is SocketException) {
      return const ApiException(
        type: ApiErrorType.network,
        message: 'Não foi possível conectar ao servidor.',
      );
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return const ApiException(
          type: ApiErrorType.network,
          message: 'Tempo de conexão esgotado.',
        );

      case DioExceptionType.sendTimeout:
        return const ApiException(
          type: ApiErrorType.network,
          message: 'Tempo de envio da requisição esgotado.',
        );

      case DioExceptionType.receiveTimeout:
        return const ApiException(
          type: ApiErrorType.network,
          message: 'Tempo de resposta esgotado.',
        );

      case DioExceptionType.badCertificate:
        return const ApiException(
          type: ApiErrorType.network,
          message: 'O certificado do servidor é inválido.',
        );

      case DioExceptionType.connectionError:
        return const ApiException(
          type: ApiErrorType.network,
          message: 'Sem conexão com a internet.',
        );

      case DioExceptionType.cancel:
        return const ApiException(
          type: ApiErrorType.unknown,
          message: 'Requisição cancelada.',
        );

      case DioExceptionType.badResponse:
        return ApiException(
          type: _mapStatusCode(e.response?.statusCode),
          statusCode: e.response?.statusCode,
          message: 'O servidor retornou um erro inesperado.',
        );

      case DioExceptionType.unknown:
        return ApiException(
          type: ApiErrorType.unknown,
          statusCode: e.response?.statusCode,
          message: 'Erro ao comunicar com o servidor.',
        );
    }
  }

  static ApiErrorType _mapStatusCode(int? statusCode) {
    if (statusCode == null) {
      return ApiErrorType.unknown;
    }

    if (statusCode == 401 || statusCode == 403) {
      return ApiErrorType.unauthorized;
    }

    if (statusCode >= 500) {
      return ApiErrorType.server;
    }

    return ApiErrorType.unknown;
  }
}
