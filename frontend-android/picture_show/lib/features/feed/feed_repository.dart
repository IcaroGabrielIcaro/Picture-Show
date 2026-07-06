import 'package:picture_show/features/feed/feed_service.dart';
import 'package:picture_show/features/feed/models/publicacao.dart';

class FeedRepository {
  final FeedService api;

  FeedRepository({
    required this.api,
  });

  Future<List<Publicacao>> listarFeed({int page = 1}) async {
    final response = await api.listarPublicacoes(page: page);
    return response.results;
  }
}