import 'package:doctorappointmenapp/services/token_service.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class TokenHelper {
  static final TokenService _tokenService = TokenService();

  // Method to get patientId by decoding the token
  static Future<String?> getPatientId() async {
    try {
      // Fetch token using TokenService
      String? token = await _tokenService.getToken();

      if (token != null) {
        // Decode the token using JwtDecoder
        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        print("heper:$decodedToken");
        // Return patientId from the decoded token
        return decodedToken[
            '_id']; // Use the correct key here // Assuming 'patientId' is the key
      } else {
        print('Token is null');
        return null;
      }
    } catch (e) {
      print('Error while decoding token: $e');
      return null;
    }
  }
  // New method to get avatar URL from the token
  static Future<String?> getAvatarUrl() async {
    try {
      String? token = await _tokenService.getToken();
      if (token != null) {
        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        return decodedToken['avatar']; // Use the correct key for avatar
      } else {
        print('Token is null');
        return null;
      }
    } catch (e) {
      print('Error while decoding token: $e');
      return null;
    }
  }
}
