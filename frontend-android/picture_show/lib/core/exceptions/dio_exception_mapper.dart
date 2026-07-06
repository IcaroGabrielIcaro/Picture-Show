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

    // Erros de rede específicos
    if (e.error is HandshakeException) {
      return const ApiException(
        message: 'Falha ao validar o certificado do servidor.',
      );
    }

    if (e.error is SocketException) {
      return const ApiException(
        message: 'Não foi possível conectar ao servidor.',
      );
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return const ApiException(message: 'Tempo de conexão esgotado.');

      case DioExceptionType.sendTimeout:
        return const ApiException(
          message: 'Tempo de envio da requisição esgotado.',
        );

      case DioExceptionType.receiveTimeout:
        return const ApiException(message: 'Tempo de resposta esgotado.');

      case DioExceptionType.badCertificate:
        return const ApiException(
          message: 'O certificado do servidor é inválido.',
        );

      case DioExceptionType.connectionError:
        return const ApiException(message: 'Sem conexão com a internet.');

      case DioExceptionType.cancel:
        return const ApiException(message: 'Requisição cancelada.');

      case DioExceptionType.badResponse:
        return ApiException(
          statusCode: e.response?.statusCode,
          message: 'O servidor retornou um erro inesperado.',
        );

      case DioExceptionType.unknown:
        return ApiException(
          statusCode: e.response?.statusCode,
          message: 'Erro ao comunicar com o servidor.',
        );
    }
  }
}
