import 'package:picture_show/features/autenticacao/autenticacao_service.dart';
import 'package:picture_show/services/usuario_local_service.dart';
import 'package:picture_show/models/usuario_response_model.dart';

class UsuarioRepository {
  final AutenticacaoService api;
  final UsuarioLocalService local;

  UsuarioRepository({required this.api, required this.local});

  Future<Usuario> obterUsuarioLogado() async {
    try {
      final usuario = await api.obterUsuarioLogado();

      await local.salvar(usuario);

      return usuario;
    } catch (e) {
      final localUser = await local.obter();

      if (localUser != null) return localUser;

      rethrow;
    }
  }

  Future<void> salvarLocal(Usuario usuario) {
    return local.salvar(usuario);
  }

  Future<void> logoutLocal() {
    return local.remover();
  }
}
