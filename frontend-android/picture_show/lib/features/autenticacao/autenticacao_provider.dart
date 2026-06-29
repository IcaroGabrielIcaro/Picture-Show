import 'package:flutter/material.dart';
import 'package:picture_show/core/exceptions/api_exception.dart';
import 'package:picture_show/features/autenticacao/autenticacao_state.dart';
import 'package:picture_show/features/autenticacao/autenticacao_service.dart';

class AutenticacaoProvider extends ChangeNotifier {
  final AutenticacaoService service;

  AutenticacaoProvider(this.service);

  AutenticacaoState _state = const AutenticacaoState();

  AutenticacaoState get state => _state;

  Future<void> cadastro({
    required String username,
    required String nome,
    required String senha,
  }) async {
    _state = const AutenticacaoState(status: AutenticacaoStatus.loading);

    notifyListeners();

    try {
      await service.cadastrar(username: username, nome: nome, senha: senha);

      _state = const AutenticacaoState(status: AutenticacaoStatus.success);
    } on ApiException catch (e) {
      _state = AutenticacaoState(
        status: AutenticacaoStatus.error,
        message: e.message,
      );
    }

    notifyListeners();
  }
}
