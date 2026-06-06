import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage();
  static const _isLoggedKey = 'is_logged';

  Future<void> saveLogin() async {
    await _storage.write(key: _isLoggedKey, value: 'true');
  }

  Future<bool> isLoggedIn() async {
    final value = await _storage.read(key: _isLoggedKey);
    return value == 'true';
  }

  Future<void> clearLogin() async {
    await _storage.delete(key: _isLoggedKey);
  }

}