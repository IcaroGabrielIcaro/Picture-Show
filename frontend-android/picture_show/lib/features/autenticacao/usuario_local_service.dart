import 'package:picture_show/core/database/database_service.dart';
import 'package:picture_show/models/usuario_response_model.dart';
import 'package:sqflite/sqflite.dart';

class UsuarioLocalService {
  static const String _tabela = 'usuario';

  Future<void> salvar(Usuario usuario) async {
    final db = await DatabaseService.instance;

    await db.insert(
      _tabela,
      usuario.toDatabase(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Usuario?> obter() async {
    final Database db = await DatabaseService.instance;

    final resultado = await db.query(_tabela, limit: 1);

    if (resultado.isEmpty) {
      return null;
    }

    return Usuario.fromDatabase(resultado.first);
  }

  Future<void> remover() async {
    final Database db = await DatabaseService.instance;

    await db.delete(_tabela);
  }
}
