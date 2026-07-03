import 'package:picture_show/core/database/database_service.dart';
import 'package:picture_show/features/feed/models/publicacao.dart';
import 'package:sqflite/sqflite.dart';

class FeedLocalService {
  static const String _tabela = 'publicacao';

  Future<void> salvarFeed(List<Publicacao> publicacoes) async {
    final Database db = await DatabaseService.instance;

    final batch = db.batch();

    batch.delete(_tabela);

    for (final publicacao in publicacoes) {
      batch.insert(
        _tabela,
        publicacao.toDatabase(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  Future<List<Publicacao>> obterFeed() async {
    final Database db = await DatabaseService.instance;

    final resultado = await db.query(_tabela, orderBy: 'publicado_em DESC');

    return resultado.map(Publicacao.fromDatabase).toList();
  }

  Future<void> limparFeed() async {
    final Database db = await DatabaseService.instance;

    await db.delete(_tabela);
  }
}
