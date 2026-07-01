import 'package:flutter/material.dart';
import 'package:picture_show/core/network/dio_client.dart';
import 'package:picture_show/core/routes/create_router.dart';
import 'package:picture_show/core/storage/secure_storage_service.dart';
import 'package:picture_show/features/autenticacao/autenticacao_provider.dart';
import 'package:picture_show/features/autenticacao/autenticacao_service.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dio = DioClient.instance;

  final secureStorage = SecureStorageService();

  final authService = AutenticacaoService(dio);

  final authProvider = AutenticacaoProvider(authService, secureStorage);

  runApp(MyApp(authService: authService, authProvider: authProvider));
}

class MyApp extends StatelessWidget {
  final AutenticacaoService authService;
  final AutenticacaoProvider authProvider;

  const MyApp({
    super.key,
    required this.authService,
    required this.authProvider,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AutenticacaoService>.value(value: authService),
        ChangeNotifierProvider<AutenticacaoProvider>.value(value: authProvider),
      ],
      child: Builder(
        builder: (context) {
          final router = createRouter(context.read<AutenticacaoProvider>());

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
