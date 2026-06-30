import 'package:flutter/material.dart';
import 'package:picture_show/core/exceptions/api_exception.dart';
import 'package:picture_show/core/storage/secure_storage_service.dart';
import 'package:picture_show/features/autenticacao/autenticacao_state.dart';
import 'package:picture_show/features/autenticacao/autenticacao_service.dart';
import 'package:picture_show/features/autenticacao/models/usuario_response_model.dart';

class AutenticacaoProvider extends ChangeNotifier {
  final AutenticacaoService service;
  final SecureStorageService storage;

  AutenticacaoProvider(this.service, this.storage);

  AutenticacaoState _state = const AutenticacaoState();

  Usuario? _usuario;

  AutenticacaoState get state => _state;

  Usuario? get usuario => _usuario;

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

  Future<void> login({required String username, required String password}) async {
    _state = const AutenticacaoState(status: AutenticacaoStatus.loading);

    notifyListeners();

    try {
      final response = await service.login(username: username, password: password);

      await storage.salvarAccessToken(response.accessToken);

      await storage.salvarRefreshToken(response.refreshToken);

      _usuario = response.usuario;

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
