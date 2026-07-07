import 'dart:io';

import 'package:picture_show/bootstrap/app.dart';

import 'dependencies.dart';
import 'http_overrides.dart';

class Bootstrap {
  Bootstrap._();

  static Future<App> initialize() async {
    HttpOverrides.global = MyHttpOverrides();

    final dependencies = await Dependencies.create();

    final usuario = await dependencies.authProvider.restaurarSessao();

    if (usuario != null) {
      dependencies.usuarioProvider.definirUsuario(usuario);
    }

    return App(
      authProvider: dependencies.authProvider,
      usuarioProvider: dependencies.usuarioProvider,
      feedProvider: dependencies.feedProvider,
    );
  }
}
