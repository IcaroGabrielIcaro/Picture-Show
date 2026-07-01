import 'package:flutter/material.dart';
import 'package:picture_show/models/usuario_response_model.dart';

class UsuarioProvider extends ChangeNotifier {
  Usuario? _usuario;

  Usuario? get usuario => _usuario;

  bool get isAuthenticated => _usuario != null;

  void definirUsuario(Usuario usuario) {
    _usuario = usuario;
    notifyListeners();
  }

  void limparUsuario() {
    _usuario = null;
    notifyListeners();
  }
}
