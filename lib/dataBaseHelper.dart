import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:proyecto/user.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'numi_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    // Users table
    await db.execute('''
      CREATE TABLE users(
        id TEXT PRIMARY KEY,
        username TEXT NOT NULL,
        email TEXT NOT NULL,
        password TEXT NOT NULL,
        profileImagePath TEXT,
        fullName TEXT,
        phoneNumber TEXT,
        favoriteHouseIds TEXT,
        preferences TEXT,
        createdAt TEXT NOT NULL,
        lastLoginAt TEXT NOT NULL
      )
    ''');

    // Sessions table
    await db.execute('''
      CREATE TABLE sessions(
        id TEXT PRIMARY KEY,
        userId TEXT NOT NULL,
        token TEXT NOT NULL,
        expiresAt TEXT NOT NULL,
        FOREIGN KEY (userId) REFERENCES users (id)
      )
    ''');
  }

  // User operations
  Future<int> insertUser(User user, String password) async {
    Database db = await database;
    Map<String, dynamic> userData = user.toJson();
    userData['password'] = password; // Store hashed password in real app
    userData['favoriteHouseIds'] = userData['favoriteHouseIds'].join(',');
    userData['preferences'] = userData['preferences'] != null
        ? userData['preferences'].toString()
        : null;

    return await db.insert('users', userData);
  }

  Future<User?> getUserById(String id) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      Map<String, dynamic> userData = maps.first;
      userData['favoriteHouseIds'] = userData['favoriteHouseIds'] != null
          ? userData['favoriteHouseIds'].split(',')
          : [];
      // Parse preferences back to Map if needed
      return User.fromJson(userData);
    }
    return null;
  }

  Future<User?> getUserByEmail(String email) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      Map<String, dynamic> userData = maps.first;
      userData['favoriteHouseIds'] = userData['favoriteHouseIds'] != null
          ? userData['favoriteHouseIds'].split(',')
          : [];
      return User.fromJson(userData);
    }
    return null;
  }

  Future<bool> checkCredentials(String email, String password) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password], // Use hashed password in real app
    );
    return maps.isNotEmpty;
  }

  Future<int> updateUser(User user) async {
    Database db = await database;
    Map<String, dynamic> userData = user.toJson();
    userData['favoriteHouseIds'] = userData['favoriteHouseIds'].join(',');
    userData['preferences'] = userData['preferences'] != null
        ? userData['preferences'].toString()
        : null;

    return await db.update(
      'users',
      userData,
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(String id) async {
    Database db = await database;
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Session operations
  Future<int> createSession(String userId, String token, DateTime expiresAt) async {
    Database db = await database;
    return await db.insert('sessions', {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'userId': userId,
      'token': token,
      'expiresAt': expiresAt.toIso8601String(),
    });
  }

  Future<bool> validateSession(String token) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'sessions',
      where: 'token = ? AND expiresAt > ?',
      whereArgs: [token, DateTime.now().toIso8601String()],
    );
    return maps.isNotEmpty;
  }

  Future<int> deleteSession(String token) async {
    Database db = await database;
    return await db.delete(
      'sessions',
      where: 'token = ?',
      whereArgs: [token],
    );
  }

  Future<int> deleteAllSessions(String userId) async {
    Database db = await database;
    return await db.delete(
      'sessions',
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }
}