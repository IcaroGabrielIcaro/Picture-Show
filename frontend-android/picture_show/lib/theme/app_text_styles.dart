import 'package:flutter/material.dart';

/// Tipografia oficial da aplicação.
///
/// Todos os textos do projeto devem utilizar um destes estilos
/// para manter consistência visual.
class AppTextStyles {
  AppTextStyles._();

  /// Logo da aplicação.
  static const logo = TextStyle(fontSize: 34, fontWeight: FontWeight.w700);

  /// Subtítulos e descrições.
  static const subtitle = TextStyle(fontSize: 15, fontWeight: FontWeight.w400);

  /// Labels dos campos.
  static const label = TextStyle(fontSize: 14, fontWeight: FontWeight.w600);

  /// Texto digitado pelo usuário.
  static const input = TextStyle(fontSize: 15, fontWeight: FontWeight.w400);

  /// Placeholder dos campos.
  static const hint = TextStyle(fontSize: 15, fontWeight: FontWeight.w400);

  /// Texto padrão da aplicação.
  static const body = TextStyle(fontSize: 14, fontWeight: FontWeight.w400);

  /// Texto de botões.
  static const button = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

  /// Mensagens de erro.
  static const error = TextStyle(fontSize: 13, fontWeight: FontWeight.w500);

  /// Textos menores (legendas, informações auxiliares).
  static const caption = TextStyle(fontSize: 12, fontWeight: FontWeight.w400);
}
