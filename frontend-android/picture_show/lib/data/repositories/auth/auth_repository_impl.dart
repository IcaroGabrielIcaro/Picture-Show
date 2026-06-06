import 'package:picture_show/data/datasources/mock/auth_mock_datasource.dart';
import 'package:picture_show/data/repositories/auth/auth_repository.dart';
import 'package:picture_show/features/auth/entities/auth_user.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthMockDatasource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<AuthUser?> login({required String email, required String password}) {
    
    return datasource.login(email: email, password: password);
    
  }
}