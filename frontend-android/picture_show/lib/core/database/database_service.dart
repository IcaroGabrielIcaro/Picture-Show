import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  DatabaseService._();

  static Database? _database;

  static Future<Database> get instance async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();

    return _database!;
  }

  static Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'picture_show.db'),
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  static Future<void> _onCreate(Database db, int version) async {
    // Usuário logado
    await db.execute('''
      CREATE TABLE usuario (
        id INTEGER PRIMARY KEY,
        username TEXT NOT NULL,
        nome TEXT NOT NULL,
        bio TEXT,
        imagem TEXT,
        seguidores INTEGER NOT NULL,
        seguindo INTEGER NOT NULL,
        publicacoes INTEGER NOT NULL,
        eu_sigo INTEGER NOT NULL
      )
    ''');

    // Feed
    await db.execute('''
      CREATE TABLE publicacao (
        id INTEGER PRIMARY KEY,
        descricao TEXT,
        imagem TEXT NOT NULL,

        autor_id INTEGER NOT NULL,
        autor_username TEXT NOT NULL,
        autor_nome TEXT NOT NULL,
        autor_imagem TEXT,

        likes INTEGER NOT NULL,
        dislikes INTEGER NOT NULL,
        comentarios INTEGER NOT NULL,
        minha_reacao TEXT,

        publicado_em TEXT NOT NULL
      )
    ''');
  }

  static Future<void> _onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    // Migrações futuras
  }
}
