import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../Models/password_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase(); // Fixed the syntax error
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'password_manager.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE passwords(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            domain TEXT,
            username TEXT,
            password TEXT,
            iconUrl TEXT
          )
        ''');
      },
    );
  }

  Future<int> addPassword(PasswordModel password) async {
    final db = await database;
    return await db.insert('passwords', password.toMap());
  }

  Future<List<PasswordModel>> getPasswords() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('passwords');
    return List.generate(maps.length, (i) => PasswordModel.fromMap(maps[i]));
  }

  Future<int> updatePassword(PasswordModel password) async {
    final db = await database;
    return await db.update(
      'passwords',
      password.toMap(),
      where: 'id = ?',
      whereArgs: [password.id],
    );
  }

  Future<int> deletePassword(int id) async {
    final db = await database;
    return await db.delete(
      'passwords',
      where: 'id =?',
      whereArgs: [id],
    );
  }
}
