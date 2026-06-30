import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:picture_show/core/storage/secure_storage_keys.dart';

/// Serviço responsável por armazenar informações sensíveis
/// utilizando o armazenamento seguro do dispositivo.
///
/// Atualmente é utilizado para persistir os tokens de autenticação,
/// mas pode ser reutilizado para outras informações confidenciais.
class SecureStorageService {
  static const _storage = FlutterSecureStorage();

  /// Salva o Access Token.
  Future<void> salvarAccessToken(String token) async {
    await _storage.write(key: SecureStorageKeys.accessToken, value: token);
  }

  /// Recupera o Access Token.
  Future<String?> obterAccessToken() async {
    return _storage.read(key: SecureStorageKeys.accessToken);
  }

  /// Remove o Access Token.
  Future<void> removerAccessToken() async {
    await _storage.delete(key: SecureStorageKeys.accessToken);
  }

  /// Salva o Refresh Token.
  Future<void> salvarRefreshToken(String token) async {
    await _storage.write(key: SecureStorageKeys.refreshToken, value: token);
  }

  /// Recupera o Refresh Token.
  Future<String?> obterRefreshToken() async {
    return _storage.read(key: SecureStorageKeys.refreshToken);
  }

  /// Remove o Refresh Token.
  Future<void> removerRefreshToken() async {
    await _storage.delete(key: SecureStorageKeys.refreshToken);
  }

  /// Remove todas as informações armazenadas.
  Future<void> limpar() async {
    await _storage.deleteAll();
  }
}
