import 'dart:io';

import 'package:dio/dio.dart';
import 'package:picture_show/core/exceptions/dio_exception_mapper.dart';
import 'package:picture_show/models/publicacao.dart';

class CriarPublicacaoService {
  final Dio dio;

  const CriarPublicacaoService(this.dio);

  /// Cria uma nova publicação.
  Future<Publicacao> criarPublicacao({
    required File imagem,
    required String descricao,
  }) async {
    try {
      final formData = FormData.fromMap({
        'descricao': descricao,
        'imagem': await MultipartFile.fromFile(
          imagem.path,
          filename: imagem.path.split('/').last,
        ),
      });

      final response = await dio.post('publicacoes/', data: formData);

      return Publicacao.fromJson(response.data);
    } on DioException catch (e) {
      throw DioExceptionMapper.map(e);
    }
  }
}
