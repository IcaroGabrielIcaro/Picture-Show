import 'package:flutter/material.dart';
import 'package:picture_show/bootstrap/dependencies.dart';
import 'package:picture_show/core/routes/create_router.dart';
import 'package:picture_show/providers/usuario_provider.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  final Dependencies dependencies;

  const App({super.key, required this.dependencies});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UsuarioProvider>.value(
          value: dependencies.usuarioProvider,
        ),
      ],
      child: Builder(
        builder: (context) {
          final router = createRouter(dependencies);

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
