import 'dart:io';

import 'package:flutter/material.dart';
import 'package:picture_show/core/exceptions/api_exception.dart';
import 'package:picture_show/features/criar_publicacao/criar_publicacao_repository.dart';
import 'package:picture_show/features/criar_publicacao/criar_publicacao_state.dart';

class CriarPublicacaoProvider extends ChangeNotifier {
  final CriarPublicacaoRepository repository;

  CriarPublicacaoProvider(this.repository);

  CriarPublicacaoState _state = const CriarPublicacaoState();
  CriarPublicacaoState get state => _state;

  Future<void> publicar() async {
    if (_state.imagem == null) return;

    _state = _state.copyWith(status: CriarPublicacaoStatus.loading);
    notifyListeners();

    try {
      await repository.criarPublicacao(
        imagem: _state.imagem!,
        descricao: _state.descricao,
      );

      _state = const CriarPublicacaoState(
        status: CriarPublicacaoStatus.success,
      );
    } on ApiException catch (e) {
      _state = _state.copyWith(
        status: CriarPublicacaoStatus.error,
        errorType: e.type,
        message: e.message,
      );
    } catch (_) {
      _state = _state.copyWith(
        status: CriarPublicacaoStatus.error,
        errorType: ApiErrorType.unknown,
        message: 'Erro inesperado.',
      );
    }

    notifyListeners();
  }

  void selecionarImagem(File imagem) {
    _state = _state.copyWith(
      imagem: imagem,
      status: CriarPublicacaoStatus.editing,
    );

    notifyListeners();
  }

  void alterarDescricao(String descricao) {
    _state = _state.copyWith(descricao: descricao);
    notifyListeners();
  }

  void limpar() {
    _state = const CriarPublicacaoState();
    notifyListeners();
  }
}
