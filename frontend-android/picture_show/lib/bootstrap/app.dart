import 'package:flutter/material.dart';
import 'package:picture_show/core/routes/create_router.dart';
import 'package:picture_show/features/autenticacao/autenticacao_provider.dart';
import 'package:picture_show/features/feed/feed_provider.dart';
import 'package:picture_show/providers/usuario_provider.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  final AutenticacaoProvider authProvider;
  final UsuarioProvider usuarioProvider;
  final FeedProvider feedProvider;

  const App({
    super.key,
    required this.authProvider,
    required this.usuarioProvider,
    required this.feedProvider,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AutenticacaoProvider>.value(value: authProvider),

        ChangeNotifierProvider<UsuarioProvider>.value(value: usuarioProvider),

        ChangeNotifierProvider<FeedProvider>.value(value: feedProvider),
      ],
      child: Builder(
        builder: (context) {
          final router = createRouter(context.read<UsuarioProvider>());

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
          );
        },
      ),
    );
  }
}