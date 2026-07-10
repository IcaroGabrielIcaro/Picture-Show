import 'dart:io';

import 'package:picture_show/core/exceptions/api_exception.dart';

enum CriarPublicacaoStatus { initial, editing, loading, success, error }

class CriarPublicacaoState {
  final CriarPublicacaoStatus status;

  final File? imagem;

  final String descricao;

  final ApiErrorType? errorType;

  final String? message;

  const CriarPublicacaoState({
    this.status = CriarPublicacaoStatus.initial,
    this.imagem,
    this.descricao = '',
    this.errorType,
    this.message,
  });

  bool get loading => status == CriarPublicacaoStatus.loading;

  bool get success => status == CriarPublicacaoStatus.success;

  bool get hasError => status == CriarPublicacaoStatus.error;

  bool get possuiImagem => imagem != null;

  CriarPublicacaoState copyWith({
    CriarPublicacaoStatus? status,
    File? imagem,
    String? descricao,
    ApiErrorType? errorType,
    String? message,
  }) {
    return CriarPublicacaoState(
      status: status ?? this.status,
      imagem: imagem ?? this.imagem,
      descricao: descricao ?? this.descricao,
      errorType: errorType ?? this.errorType,
      message: message ?? this.message,
    );
  }
}
