import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:proyecto/dataBaseHelper.dart';
import 'package:proyecto/user.dart';

class UserRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  // Register a new user
  Future<User?> registerUser({
    required String username,
    required String email,
    required String password,
    String? fullName,
    String? phoneNumber,
  }) async {
    // Check if email already exists
    User? existingUser = await _databaseHelper.getUserByEmail(email);
    if (existingUser != null) {
      throw Exception('Email already registered');
    }

    // Create a new user
    final user = User(
      id: _generateUserId(),
      username: username,
      email: email,
      fullName: fullName,
      phoneNumber: phoneNumber,
      createdAt: DateTime.now(),
      lastLoginAt: DateTime.now(),
    );

    // Hash the password (in a real app, use a more secure method)
    String hashedPassword = _hashPassword(password);

    // Insert the user into the database
    await _databaseHelper.insertUser(user, hashedPassword);

    // Return the created user
    return user;
  }

  // Login a user
  Future<User?> loginUser(String email, String password) async {
    // Hash the password
    String hashedPassword = _hashPassword(password);

    // Check credentials
    bool isValid = await _databaseHelper.checkCredentials(email, hashedPassword);
    if (!isValid) {
      throw Exception('Invalid email or password');
    }

    // Get the user
    User? user = await _databaseHelper.getUserByEmail(email);
    if (user == null) {
      throw Exception('User not found');
    }

    // Update last login time
    user = user.copyWith(lastLoginAt: DateTime.now());
    await _databaseHelper.updateUser(user);

    // Create a session
    String token = _generateSessionToken();
    DateTime expiresAt = DateTime.now().add(const Duration(days: 30));
    await _databaseHelper.createSession(user.id, token, expiresAt);

    // Save token to shared preferences
    await _saveSessionToken(token);

    return user;
  }

  // Logout the current user
  Future<void> logoutUser() async {
    String? token = await _getSessionToken();
    if (token != null) {
      await _databaseHelper.deleteSession(token);
      await _clearSessionToken();
    }
  }

  // Check if a user is logged in
  Future<bool> isLoggedIn() async {
    String? token = await _getSessionToken();
    if (token == null) {
      return false;
    }
    return await _databaseHelper.validateSession(token);
  }

  // Get the current logged-in user
  Future<User?> getCurrentUser() async {
    String? token = await _getSessionToken();
    if (token == null) {
      return null;
    }

    bool isValid = await _databaseHelper.validateSession(token);
    if (!isValid) {
      await _clearSessionToken();
      return null;
    }

    // In a real app, you would get the userId from the session
    // For simplicity, we'll just get the first user
    List<User> users = await getAllUsers();
    if (users.isEmpty) {
      return null;
    }
    return users.first;
  }

  // Update user profile
  Future<User?> updateUserProfile(User user) async {
    await _databaseHelper.updateUser(user);
    return await _databaseHelper.getUserById(user.id);
  }

  // Add a house to favorites
  Future<User?> addToFavorites(String userId, String houseId) async {
    User? user = await _databaseHelper.getUserById(userId);
    if (user == null) {
      throw Exception('User not found');
    }

    if (!user.favoriteHouseIds.contains(houseId)) {
      user.favoriteHouseIds.add(houseId);
      await _databaseHelper.updateUser(user);
    }

    return user;
  }

  // Remove a house from favorites
  Future<User?> removeFromFavorites(String userId, String houseId) async {
    User? user = await _databaseHelper.getUserById(userId);
    if (user == null) {
      throw Exception('User not found');
    }

    user.favoriteHouseIds.remove(houseId);
    await _databaseHelper.updateUser(user);

    return user;
  }

  // Get all users (for admin purposes)
  Future<List<User>> getAllUsers() async {
    Database db = await _databaseHelper.database;
    List<Map<String, dynamic>> maps = await db.query('users');

    return List.generate(maps.length, (i) {
      Map<String, dynamic> userData = maps[i];
      userData['favoriteHouseIds'] = userData['favoriteHouseIds'] != null
          ? userData['favoriteHouseIds'].split(',')
          : [];
      return User.fromJson(userData);
    });
  }

  // Helper methods
  String _generateUserId() {
    return 'user_${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(10000)}';
  }

  String _hashPassword(String password) {
    // In a real app, use a more secure method with salt
    var bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  String _generateSessionToken() {
    var random = Random.secure();
    var values = List<int>.generate(32, (i) => random.nextInt(256));
    return base64Url.encode(values);
  }

  Future<void> _saveSessionToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('session_token', token);
  }

  Future<String?> _getSessionToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('session_token');
  }

  Future<void> _clearSessionToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('session_token');
  }
}