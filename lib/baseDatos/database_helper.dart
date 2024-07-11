import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'users.db');
    return await openDatabase(
      path,
      version: 4, // Asegúrate de que la versión sea 4
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE usuarios (
        id_usuario INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre_usuario TEXT NOT NULL UNIQUE,
        nombre TEXT NOT NULL,
        contrasena_hash TEXT NOT NULL,
        correo_electronico TEXT NOT NULL UNIQUE,
        avatar TEXT DEFAULT 'assets/avatares/avatar1.png'
      )
    ''');

    await db.execute('''
      CREATE TABLE resultados_pruebas (
        id_resultado INTEGER PRIMARY KEY AUTOINCREMENT,
        id_usuario INTEGER,
        prueba INTEGER,
        resultado TEXT,
        FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario)
      )
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      var tableInfo = await db.rawQuery('PRAGMA table_info(usuarios)');
      var columnExists = tableInfo.any((column) => column['name'] == 'nombre');
      if (!columnExists) {
        await db
            .execute('ALTER TABLE usuarios ADD COLUMN nombre TEXT NOT NULL');
      }
    }
    if (oldVersion < 3) {
      await db.execute(
          'ALTER TABLE usuarios ADD COLUMN avatar TEXT DEFAULT "assets/avatares/avatar1.png"');
    }
    if (oldVersion < 4) {
      await db.execute('''
        CREATE TABLE resultados_pruebas (
          id_resultado INTEGER PRIMARY KEY AUTOINCREMENT,
          id_usuario INTEGER,
          prueba INTEGER,
          resultado TEXT,
          FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario)
        )
      ''');
    }
  }

  Future<int> insertUser(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('usuarios', row);
  }

  Future<Map<String, dynamic>?> getUser(String username) async {
    Database db = await database;
    List<Map> results = await db.query('usuarios',
        columns: [
          'id_usuario',
          'nombre_usuario',
          'nombre',
          'contrasena_hash',
          'correo_electronico',
          'avatar'
        ],
        where: 'nombre_usuario = ?',
        whereArgs: [username]);
    if (results.isNotEmpty) {
      return Map<String, dynamic>.from(results.first);
    }
    return null;
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    Database db = await database;
    List<Map> results = await db.query('usuarios',
        columns: [
          'id_usuario',
          'nombre_usuario',
          'nombre',
          'contrasena_hash',
          'correo_electronico',
          'avatar'
        ],
        where: 'correo_electronico = ?',
        whereArgs: [email]);
    if (results.isNotEmpty) {
      return Map<String, dynamic>.from(results.first);
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    Database db = await database;
    return await db.query('usuarios');
  }

  Future<int> deleteUser(int id) async {
    Database db = await database;
    return await db
        .delete('usuarios', where: 'id_usuario = ?', whereArgs: [id]);
  }

  Future<int> updateUser(Map<String, dynamic> row) async {
    Database db = await database;
    int id = row['id_usuario'];
    return await db
        .update('usuarios', row, where: 'id_usuario = ?', whereArgs: [id]);
  }

  // Métodos para la tabla resultados_pruebas
  Future<int> insertResult(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('resultados_pruebas', row);
  }

  Future<List<Map<String, dynamic>>> getResultsByUser(int userId) async {
    Database db = await database;
    return await db.query('resultados_pruebas', where: 'id_usuario = ?', whereArgs: [userId]);
  }

  Future<Map<String, dynamic>?> getResult(int userId, int testNumber) async {
    Database db = await database;
    List<Map> results = await db.query('resultados_pruebas',
        where: 'id_usuario = ? AND prueba = ?',
        whereArgs: [userId, testNumber]);
    if (results.isNotEmpty) {
      return Map<String, dynamic>.from(results.first);
    }
    return null;
  }

  Future<int> updateResult(Map<String, dynamic> row) async {
    Database db = await database;
    int id = row['id_resultado'];
    return await db.update('resultados_pruebas', row, where: 'id_resultado = ?', whereArgs: [id]);
  }

  Future<int> deleteResult(int id) async {
    Database db = await database;
    return await db.delete('resultados_pruebas', where: 'id_resultado = ?', whereArgs: [id]);
  }
}
