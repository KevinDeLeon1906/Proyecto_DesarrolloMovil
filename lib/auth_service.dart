import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:proyecto/user.dart';
import 'package:proyecto/user_repository.dart';

class AuthService extends ChangeNotifier {
  final UserRepository _userRepository = UserRepository();

  User? _currentUser;
  bool _isLoading = false;
  String? _error;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _currentUser != null;
  String? get error => _error;

  AuthService() {
    // Check if user is already logged in
    _initializeAuth();
  }

  Future<void> _initializeAuth() async {
    _isLoading = true;
    notifyListeners();

    try {
      bool isLoggedIn = await _userRepository.isLoggedIn();
      if (isLoggedIn) {
        _currentUser = await _userRepository.getCurrentUser();
      }
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> register({
    required String username,
    required String email,
    required String password,
    String? fullName,
    String? phoneNumber,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentUser = await _userRepository.registerUser(
        username: username,
        email: email,
        password: password,
        fullName: fullName,
        phoneNumber: phoneNumber,
      );

      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentUser = await _userRepository.loginUser(email, password);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _userRepository.logoutUser();
      _currentUser = null;
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateProfile({
    String? fullName,
    String? phoneNumber,
    String? profileImagePath,
  }) async {
    if (_currentUser == null) return false;

    _isLoading = true;
    notifyListeners();

    try {
      final updatedUser = _currentUser!.copyWith(
        fullName: fullName,
        phoneNumber: phoneNumber,
        profileImagePath: profileImagePath,
      );

      _currentUser = await _userRepository.updateUserProfile(updatedUser);
      _error = null;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addToFavorites(String houseId) async {
    if (_currentUser == null) return false;

    try {
      _currentUser = await _userRepository.addToFavorites(
          _currentUser!.id,
          houseId
      );
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> removeFromFavorites(String houseId) async {
    if (_currentUser == null) return false;

    try {
      _currentUser = await _userRepository.removeFromFavorites(
          _currentUser!.id,
          houseId
      );
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  bool isFavorite(String houseId) {
    return _currentUser?.favoriteHouseIds.contains(houseId) ?? false;
  }
}