import 'package:flutter/material.dart';
import 'package:picture_show/core/routers/app_router.dart';
import 'package:picture_show/features/perfil/providers/profile_provider.dart';
import 'package:provider/provider.dart';

// Função principal do app (pronto de entrada)
void main() {
  runApp(const MyApp()); // Inicia o app com o widget raiz
}

// Widget principal do app
// StatelessWidget = não possui estado (não muda sozinho)
class MyApp extends StatelessWidget {
  // Construtor padrão com suporte a chave (key)
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileProvider(),

      child: MaterialApp.router(
        routerConfig: appRouter,
      ),
    );
  }
}