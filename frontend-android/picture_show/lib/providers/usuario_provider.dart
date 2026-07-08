import 'package:flutter/material.dart';
import 'package:picture_show/models/usuario_response_model.dart';
import 'package:picture_show/repositories/usuario_repository.dart';

class UsuarioProvider extends ChangeNotifier {
  final UsuarioRepository repository;

  UsuarioProvider(this.repository);

  Usuario? _usuario;

  Usuario? get usuario => _usuario;

  bool get isAuthenticated => _usuario != null;

  /// Carrega o usuário (API → fallback local)
  Future<void> carregarUsuario() async {
    try {
      final usuario = await repository.obterUsuarioLogado();
      _usuario = usuario;
      notifyListeners();
    } catch (e) {
      _usuario = null;
      notifyListeners();
      rethrow;
    }
  }

  /// Define usuário manualmente (ex: login)
  void definirUsuario(Usuario usuario) {
    _usuario = usuario;
    notifyListeners();
  }

  /// Tenta restaurar sessão usando cache local (startup)
  Future<bool> restaurarSessao() async {
    try {
      final usuario = await repository.obterUsuarioLogado();

      _usuario = usuario;
      notifyListeners();
      return true;
    } catch (_) {
      await repository.logoutLocal();
      _usuario = null;
      notifyListeners();
      return false;
    }
  }

  /// Logout completo (API já tratado no AuthProvider)
  Future<void> logout() async {
    await repository.logoutLocal();
    _usuario = null;
    notifyListeners();
  }

  /// Atualiza dados localmente (ex: após edição de perfil)
  Future<void> atualizarLocal(Usuario usuario) async {
    _usuario = usuario;
    await repository.salvarLocal(usuario);
    notifyListeners();
  }
}
