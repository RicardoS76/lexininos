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
      version: 2, // Asegúrate de que la versión sea 2
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
        correo_electronico TEXT NOT NULL UNIQUE
      )
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Verifica si la columna 'nombre' ya existe antes de agregarla
      var tableInfo = await db.rawQuery('PRAGMA table_info(usuarios)');
      var columnExists = tableInfo.any((column) => column['name'] == 'nombre');
      if (!columnExists) {
        await db
            .execute('ALTER TABLE usuarios ADD COLUMN nombre TEXT NOT NULL');
      }
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
          'correo_electronico'
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
          'correo_electronico'
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
}
