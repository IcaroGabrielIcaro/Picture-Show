import 'package:flutter/material.dart';
import 'package:picture_show/core/exceptions/api_exception.dart';
import 'package:picture_show/widgets/feedback/feedback.dart';

class FeedbackBuilder {
  static Widget fromError({
    required ApiErrorType? error,
    required VoidCallback onRetry,
  }) {
    switch (error) {
      case ApiErrorType.network:
        return FeedbackPage(
          icon: Icons.cloud_off_outlined,
          title: 'Você está sem conexão',
          message: 'Conecte-se à internet e tente novamente.',
          onPressed: onRetry,
        );

      case ApiErrorType.server:
        return FeedbackPage(
          icon: Icons.dns_outlined,
          title: 'Servidor indisponível',
          message: 'Não foi possível conectar ao servidor.',
          onPressed: onRetry,
        );

      case ApiErrorType.unauthorized:
        return FeedbackPage(
          icon: Icons.lock_outline,
          title: 'Sua sessão expirou',
          message: 'Faça login novamente.',
          onPressed: onRetry,
        );

      default:
        return FeedbackPage(
          icon: Icons.error_outline,
          title: 'Algo deu errado',
          message: 'Tente novamente em alguns instantes.',
          onPressed: onRetry,
        );
    }
  }
}