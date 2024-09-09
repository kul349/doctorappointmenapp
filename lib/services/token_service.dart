import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService {
  final _storage = FlutterSecureStorage(); // Create an instance of FlutterSecureStorage

  final _tokenKey = 'authToken'; // Key used for storing the token

  // Function to store the token securely
  Future<void> storeToken(String token) async {
    try {
      await _storage.write(key: _tokenKey, value: token); // Stores the token securely
    } catch (e) {
      print('Failed to store token: $e');
    }
  }

  // Function to retrieve the stored token
  Future<String?> getToken() async {
    try {
      return await _storage.read(key: _tokenKey); // Reads the token from secure storage
    } catch (e) {
      print('Failed to retrieve token: $e');
      return null;
    }
  }

  // Function to remove the stored token (e.g., on logout)
  Future<void> removeToken() async {
    try {
      await _storage.delete(key: _tokenKey); // Deletes the token from secure storage
    } catch (e) {
      print('Failed to remove token: $e');
    }
  }
}
