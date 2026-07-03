import 'package:picture_show/features/feed/feed_local_service.dart';
import 'package:picture_show/features/feed/feed_service.dart';
import 'package:picture_show/features/feed/models/publicacao.dart';

class FeedRepository {
  final FeedService api;
  final FeedLocalService local;

  FeedRepository({
    required this.api,
    required this.local,
  });

  Future<List<Publicacao>> listarFeed({int page = 1}) async {
    try {
      final response = await api.listarPublicacoes(page: page);

      final publicacoes = response.results;

      await local.salvarFeed(publicacoes);

      return publicacoes;
    } catch (e) {
      final cached = await local.obterFeed();

      if (cached.isNotEmpty) return cached;

      rethrow;
    }
  }

  Future<void> refreshCache() async {
    final response = await api.listarPublicacoes(page: 1);
    await local.salvarFeed(response.results);
  }

  Future<List<Publicacao>> obterOffline() {
    return local.obterFeed();
  }

  Future<void> limparCache() {
    return local.limparFeed();
  }
}