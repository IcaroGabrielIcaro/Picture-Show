import 'package:flutter/material.dart';
import 'package:picture_show/core/exceptions/api_exception.dart';
import 'package:picture_show/core/storage/secure_storage_service.dart';
import 'package:picture_show/features/autenticacao/autenticacao_state.dart';
import 'package:picture_show/features/autenticacao/autenticacao_service.dart';
import 'package:picture_show/features/autenticacao/models/login_response_model.dart';
import 'package:picture_show/models/usuario_response_model.dart';
import 'package:picture_show/repositories/usuario_repository.dart';

class AutenticacaoProvider extends ChangeNotifier {
  final AutenticacaoService service;
  final SecureStorageService storage;
  final UsuarioRepository usuarioRepository;

  AutenticacaoProvider(this.service, this.storage, this.usuarioRepository);

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

      await usuarioRepository.salvarLocal(response.usuario);

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

  Future<void> cadastrar({
    required String username,
    required String nome,
    required String senha,
  }) async {
    _state = const AutenticacaoState(status: AutenticacaoStatus.loading);

    notifyListeners();

    try {
      await service.cadastrar(username: username, nome: nome, senha: senha);

      _state = const AutenticacaoState(status: AutenticacaoStatus.success);

      notifyListeners();
    } on ApiException catch (e) {
      _state = AutenticacaoState(
        status: AutenticacaoStatus.error,
        message: e.message,
      );

      notifyListeners();
    } catch (_) {
      _state = const AutenticacaoState(
        status: AutenticacaoStatus.error,
        message: 'Erro inesperado',
      );

      notifyListeners();
    }
  }

  Future<void> logout() async {
    await storage.removerAccessToken();
    await storage.removerRefreshToken();

    await usuarioRepository.logoutLocal();

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
      return await usuarioRepository.obterUsuarioLogado();
    } on ApiException {
      return null;
    } catch (_) {
      return null;
    }
  }
}
