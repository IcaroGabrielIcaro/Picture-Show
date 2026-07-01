import 'package:picture_show/models/usuario_response_model.dart';

/// Representa a resposta retornada pela API após uma autenticação.
///
/// Exemplo:
/// ```json
/// {
///   "refresh": "...",
///   "access": "...",
///   "usuario": { ... }
/// }
/// ```
class LoginResponse {
  /// JWT utilizado para autenticar as requisições.
  final String accessToken;

  /// JWT utilizado para renovar o access token.
  final String refreshToken;

  /// Usuário autenticado.
  final Usuario usuario;

  const LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.usuario,
  });

  /// Cria uma instância a partir do JSON retornado pela API.
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['access'] as String,
      refreshToken: json['refresh'] as String,
      usuario: Usuario.fromJson(json['usuario'] as Map<String, dynamic>),
    );
  }

  /// Converte a instância para JSON.
  Map<String, dynamic> toJson() {
    return {
      'access': accessToken,
      'refresh': refreshToken,
      'usuario': usuario.toJson(),
    };
  }

  /// Cria uma cópia alterando apenas os campos desejados.
  LoginResponse copyWith({
    String? accessToken,
    String? refreshToken,
    Usuario? usuario,
  }) {
    return LoginResponse(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      usuario: usuario ?? this.usuario,
    );
  }
}
