import 'package:flutter/material.dart';
import 'package:picture_show/core/network/dio_client.dart';
import 'package:picture_show/core/routes/create_router.dart';
import 'package:picture_show/core/storage/secure_storage_service.dart';
import 'package:picture_show/features/autenticacao/autenticacao_provider.dart';
import 'package:picture_show/features/autenticacao/autenticacao_service.dart';
import 'package:picture_show/features/feed/feed_provider.dart';
import 'package:picture_show/features/feed/feed_service.dart';
import 'package:picture_show/providers/usuario_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Storage
  final secureStorage = SecureStorageService();

  // Dio
  final dio = DioClient.create(secureStorage);

  // Services
  final authService = AutenticacaoService(dio);
  final feedService = FeedService(dio);

  // Providers
  final usuarioProvider = UsuarioProvider();

  final authProvider = AutenticacaoProvider(authService, secureStorage);

  // Restaura a sessão antes de iniciar o app
  final usuario = await authProvider.restaurarSessao();

  if (usuario != null) {
    usuarioProvider.definirUsuario(usuario);
  }

  final feedProvider = FeedProvider(feedService);

  runApp(
    MyApp(
      authService: authService,
      feedService: feedService,
      authProvider: authProvider,
      usuarioProvider: usuarioProvider,
      feedProvider: feedProvider,
    ),
  );
}

class MyApp extends StatelessWidget {
  final AutenticacaoService authService;
  final FeedService feedService;

  final AutenticacaoProvider authProvider;
  final UsuarioProvider usuarioProvider;
  final FeedProvider feedProvider;

  const MyApp({
    super.key,
    required this.authService,
    required this.feedService,
    required this.authProvider,
    required this.usuarioProvider,
    required this.feedProvider,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Services
        Provider<AutenticacaoService>.value(value: authService),
        Provider<FeedService>.value(value: feedService),

        // Providers
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
