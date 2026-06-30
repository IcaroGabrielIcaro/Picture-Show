import 'package:dio/dio.dart';
import 'package:picture_show/core/exceptions/dio_exception_mapper.dart';
import 'package:picture_show/features/autenticacao/models/login_response_model.dart';

class AutenticacaoService {
  final Dio dio;

  AutenticacaoService(this.dio);

  /// Realiza o cadastro de um novo usuário.
  Future<void> cadastrar({
    required String username,
    required String nome,
    required String senha,
  }) async {
    try {
      await dio.post(
        'cadastrar/',
        data: FormData.fromMap({
          'username': username,
          'nome': nome,
          'senha': senha,
        }),
      );
    } on DioException catch (e) {
      throw DioExceptionMapper.map(e);
    }
  }

  /// Realiza o login do usuário.
  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        'login/',
        data: {'username': username, 'password': password},
      );

      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw DioExceptionMapper.map(e);
    }
  }
}
