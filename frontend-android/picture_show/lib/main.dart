import 'package:flutter/material.dart';
import 'package:picture_show/core/network/dio_client.dart';
import 'package:picture_show/core/routes/create_router.dart';
import 'package:picture_show/core/storage/secure_storage_service.dart';
import 'package:picture_show/features/autenticacao/autenticacao_provider.dart';
import 'package:picture_show/features/autenticacao/autenticacao_service.dart';
import 'package:picture_show/providers/usuario_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dio = DioClient.instance;

  final secureStorage = SecureStorageService();

  final authService = AutenticacaoService(dio);

  final authProvider = AutenticacaoProvider(authService, secureStorage);

  final usuarioProvider = UsuarioProvider();

  runApp(
    MyApp(
      authService: authService,
      authProvider: authProvider,
      usuarioProvider: usuarioProvider,
    ),
  );
}

class MyApp extends StatelessWidget {
  final AutenticacaoService authService;
  final AutenticacaoProvider authProvider;
  final UsuarioProvider usuarioProvider;

  const MyApp({
    super.key,
    required this.authService,
    required this.authProvider,
    required this.usuarioProvider,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AutenticacaoService>.value(value: authService),

        ChangeNotifierProvider<AutenticacaoProvider>.value(value: authProvider),

        ChangeNotifierProvider<UsuarioProvider>.value(value: usuarioProvider),
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
