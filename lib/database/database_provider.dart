import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import '../model/pontos_turisticos.dart';

class DatabaseProvider {
  static const dbName = 'cadastro_ponto_turistico.db';
  static const dbVersion = 1;

  DatabaseProvider._init();
  static final DatabaseProvider instance = DatabaseProvider._init();

  Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final dbPath = '$databasesPath/$dbName';
    return await openDatabase(
      dbPath,
      version: dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${PontosTuristicos.nomeTabela} (
        ${PontosTuristicos.campoId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${PontosTuristicos.campoDescricao} TEXT NOT NULL,
        ${PontosTuristicos.campoNome} TEXT,
        ${PontosTuristicos.campoDiferenciais} TEXT,
        ${PontosTuristicos.campoInclusao} TEXT,
        ${PontosTuristicos.campoLatitude} TEXT,
        ${PontosTuristicos.campoLongitude} TEXT,
        ${PontosTuristicos.campoCep} TEXT
      );
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {}

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
    }
  }
}
