import 'package:picture_show/features/auth/entities/auth_user.dart';

abstract class AuthRepository {

  Future<AuthUser?> login({required String email, required String password});
  
}