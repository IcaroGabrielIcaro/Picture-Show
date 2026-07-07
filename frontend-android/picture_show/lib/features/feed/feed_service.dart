import 'package:dio/dio.dart';
import 'package:picture_show/core/exceptions/dio_exception_mapper.dart';
import 'package:picture_show/features/feed/models/publicacao_response.dart';

/// Responsável por toda comunicação da API relacionada ao feed.
class FeedService {
  final Dio dio;

  const FeedService(this.dio);

  /// Busca uma página de publicações.
  ///
  /// Exemplo:
  /// GET /publicacoes/?page=1
  Future<PublicacoesResponse> listarPublicacoes({int page = 1}) async {
    try {
      final response = await dio.get(
        'publicacoes/',
        queryParameters: {'page': page},
      );

      return PublicacoesResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw DioExceptionMapper.map(e);
    }
  }
}
