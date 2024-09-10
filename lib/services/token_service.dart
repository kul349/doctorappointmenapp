// token_service.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService {
  final _storage = FlutterSecureStorage();
  final _tokenKey = 'authToken';

  Future<void> storeToken(String token) async {
    try {
      await _storage.write(key: _tokenKey, value: token);
      print('Token stored successfully: $token'); // Debugging line
    } catch (e) {
      print('Failed to store token: $e');
    }
  }

  Future<String?> getToken() async {
    try {
      final token = await _storage.read(key: _tokenKey);
      print('Retrieved token: $token'); // Debugging line
      return token;
    } catch (e) {
      print('Failed to retrieve token: $e');
      return null;
    }
  }

  Future<void> removeToken() async {
    try {
      await _storage.delete(key: _tokenKey);
      print('Token removed successfully'); // Debugging line
    } catch (e) {
      print('Failed to remove token: $e');
    }
  }
}
