import 'package:flutter/material.dart';
import 'package:picture_show/core/exceptions/api_exception.dart';
import 'package:picture_show/core/storage/secure_storage_service.dart';
import 'package:picture_show/features/autenticacao/autenticacao_state.dart';
import 'package:picture_show/features/autenticacao/autenticacao_service.dart';
import 'package:picture_show/features/autenticacao/models/login_response_model.dart';
import 'package:picture_show/models/usuario_response_model.dart';

class AutenticacaoProvider extends ChangeNotifier {
  final AutenticacaoService service;
  final SecureStorageService storage;

  AutenticacaoProvider(this.service, this.storage);

  AutenticacaoState _state = const AutenticacaoState();
  AutenticacaoState get state => _state;

  Future<LoginResponse?> login({
    required String username,
    required String password,
  }) async {
    _state = const AutenticacaoState(status: AutenticacaoStatus.loading);

    notifyListeners();

    try {
      final response = await service.login(
        username: username,
        password: password,
      );

      // salva tokens
      await storage.salvarAccessToken(response.accessToken);
      await storage.salvarRefreshToken(response.refreshToken);

      _state = const AutenticacaoState(status: AutenticacaoStatus.success);

      notifyListeners();

      return response;
    } on ApiException catch (e) {
      _state = AutenticacaoState(
        status: AutenticacaoStatus.error,
        message: e.message,
      );

      notifyListeners();
      return null;
    } catch (e) {
      _state = AutenticacaoState(
        status: AutenticacaoStatus.error,
        message: "Erro inesperado",
      );

      notifyListeners();
      return null;
    }
  }

  Future<void> logout() async {
    await storage.removerAccessToken();
    await storage.removerRefreshToken();

    _state = const AutenticacaoState();
    notifyListeners();
  }

  /// tenta restaurar sessão ao abrir o app
  Future<Usuario?> restaurarSessao() async {
    final token = await storage.obterAccessToken();

    if (token == null) {
      return null;
    }

    try {
      return await service.obterUsuarioLogado();
    } on ApiException {
      await storage.limpar();
      return null;
    } catch (_) {
      await storage.limpar();
      return null;
    }
  }
}
