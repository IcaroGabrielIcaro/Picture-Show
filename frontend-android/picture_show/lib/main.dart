import 'package:flutter/material.dart';
import 'features/perfil/perfil_page.dart';

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
    // build = método que constrói a interface
    // context = posição desse widget na árvore
    return MaterialApp(
      // Tela inicial do app
      home: const PerfilPage(),
    );
  }
}