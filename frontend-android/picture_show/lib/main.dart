import 'package:flutter/material.dart';
import 'package:picture_show/core/network/dio_client.dart';
import 'package:picture_show/features/autenticacao/autenticacao.dart';
import 'package:picture_show/features/autenticacao/autenticacao_provider.dart';
import 'package:picture_show/features/autenticacao/autenticacao_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AutenticacaoService>(
          create: (_) => AutenticacaoService(DioClient.dio),
        ),
        ChangeNotifierProvider<AutenticacaoProvider>(
          create: (context) =>
              AutenticacaoProvider(context.read<AutenticacaoService>()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const Autenticacao(),
      ),
    );
  }
}
