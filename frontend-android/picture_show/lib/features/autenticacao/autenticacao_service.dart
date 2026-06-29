import 'package:dio/dio.dart';
import 'package:picture_show/core/exceptions/dio_exception_mapper.dart';

class AutenticacaoService {
  final Dio dio;

  AutenticacaoService(this.dio);

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
}
