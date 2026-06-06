import 'package:picture_show/features/auth/entities/auth_user.dart';

class AuthMockDatasource {
  final AuthUser mockUser = const AuthUser(profileId: 0, email: "nicolas@pictureshow.com");

  Future<AuthUser?> login({required String email, required String password}) async {
    await Future.delayed(const Duration(microseconds: 500));

    if (email == 'nicolas@pictureshow.com' && password == '123456') {
      return mockUser;
    }
    return null;
  }
}