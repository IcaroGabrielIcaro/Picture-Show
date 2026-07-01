import 'package:flutter/material.dart';
import 'package:picture_show/core/exceptions/api_exception.dart';
import 'package:picture_show/core/storage/secure_storage_service.dart';
import 'package:picture_show/features/autenticacao/autenticacao_state.dart';
import 'package:picture_show/features/autenticacao/autenticacao_service.dart';
import 'package:picture_show/features/autenticacao/models/login_response_model.dart';

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
    }

    notifyListeners();
  }

  Future<void> logout() async {
    await storage.removerAccessToken();
    await storage.removerRefreshToken();

    _state = const AutenticacaoState();

    notifyListeners();
  }
}
