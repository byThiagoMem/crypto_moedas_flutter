import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  //Construtor com acesso privado
  DB._();
  //Criar instancia de DB
  static final DB instance = DB._();
  //Instancia do SQLite
  static Database? _database;
  //Retornar database, se já estiver inicializado só retorna a instancia, se não, instancia e retorna
  get database async {
    if (_database != null) return _database;
    return await _initDatabase();
  }

  //Inicializar database
  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'cripto.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  //Função para criar e estruturar o banco
  _onCreate(db, versao) async {
    await db.execute(_conta);
    await db.execute(_carteira);
    await db.execute(_historico);
    await db.insert('conta', {'saldo': 0});
  }

  //Estruturação das tabelas
  String get _conta => '''
  CREATE TABLE conta (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    saldo REAL
  )
  ''';
  //Estruturação das tabelas
  String get _carteira => '''
  CREATE TABLE carteira (
    sigla TEXT PRIMARY KEY,
    moeda TEXT,
    quantidade TEXT
  )
  ''';
  //Estruturação das tabelas
  String get _historico => '''
  CREATE TABLE historico (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    data_operacao INT,
    tipo_operacao TEXT,
    moeda TEXT,
    sigla TEXT,
    valor REAL,
    quantidade TEXT
  )
  ''';
}
