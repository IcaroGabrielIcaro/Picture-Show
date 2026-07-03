import 'package:flutter/material.dart';
import 'package:picture_show/core/network/dio_client.dart';
import 'package:picture_show/core/routes/create_router.dart';
import 'package:picture_show/core/storage/secure_storage_service.dart';
import 'package:picture_show/features/autenticacao/autenticacao_provider.dart';
import 'package:picture_show/features/autenticacao/autenticacao_service.dart';
import 'package:picture_show/features/feed/feed_local_service.dart';
import 'package:picture_show/features/feed/feed_provider.dart';
import 'package:picture_show/features/feed/feed_repository.dart';
import 'package:picture_show/features/feed/feed_service.dart';
import 'package:picture_show/providers/usuario_provider.dart';
import 'package:picture_show/repositories/usuario_repository.dart';
import 'package:picture_show/services/usuario_local_service.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // =========================
  // STORAGE
  // =========================
  final secureStorage = SecureStorageService();

  // =========================
  // DATABASE SERVICES
  // =========================
  final usuarioLocalService = UsuarioLocalService();
  final feedLocalService = FeedLocalService();

  // =========================
  // DIO
  // =========================
  final dio = DioClient.create(secureStorage);

  // =========================
  // API SERVICES
  // =========================
  final authService = AutenticacaoService(dio);
  final feedService = FeedService(dio);

  // =========================
  // REPOSITORIES
  // =========================
  final usuarioRepository = UsuarioRepository(
    api: authService,
    local: usuarioLocalService,
  );

  final feedRepository = FeedRepository(
    api: feedService,
    local: feedLocalService,
  );

  // =========================
  // PROVIDERS
  // =========================
  final usuarioProvider = UsuarioProvider(usuarioRepository);

  final authProvider = AutenticacaoProvider(authService, secureStorage);

  final feedProvider = FeedProvider(feedRepository);

  // =========================
  // RESTAURA SESSÃO
  // =========================
  final usuario = await authProvider.restaurarSessao();

  if (usuario != null) {
    usuarioProvider.definirUsuario(usuario);
  }

  // =========================
  // RUN APP
  // =========================
  runApp(
    MyApp(
      authProvider: authProvider,
      usuarioProvider: usuarioProvider,
      feedProvider: feedProvider,
    ),
  );
}

class MyApp extends StatelessWidget {
  final AutenticacaoProvider authProvider;
  final UsuarioProvider usuarioProvider;
  final FeedProvider feedProvider;

  const MyApp({
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
