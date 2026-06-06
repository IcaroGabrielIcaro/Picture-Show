import 'package:flutter/material.dart';
import 'package:picture_show/core/services/secure_storage_service.dart';
import 'package:picture_show/data/repositories/auth/auth_repository.dart';
import 'package:picture_show/features/auth/entities/auth_user.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository repository;
  final SecureStorageService storage;

  AuthProvider(
    this.repository,
    this.storage
  );

  AuthUser? _user;

  AuthUser? get user => _user;

  bool get isAuthenticated => _user != null;

  Future<void> initialize() async {
    final logged = await storage.isLoggedIn();

    if (!logged) return;

    _user = const AuthUser(profileId: 0, email: 'nicolas@pictureshow.com');

    notifyListeners();
  }

  Future<bool> login({required String email, required String password}) async {
    final user = await repository.login(email: email, password: password);

    if (user == null) {
      return false;
    }

    _user = user;
    await storage.saveLogin();
    notifyListeners();

    return true;
  }

  Future<void> logout() async {
    _user = null;
    await storage.clearLogin();
    notifyListeners();
  }
}