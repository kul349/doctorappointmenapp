import 'dart:convert';
import 'package:doctorappointmenapp/services/token_service.dart';
import 'package:doctorappointmenapp/utils/constant.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchRatings(String doctorId) async {
  final TokenService _tokenService = TokenService(); // Instance of TokenService

  print("doctor in rating:$doctorId");
  final token = await _tokenService.getToken();

  final response = await http.get(
    Uri.parse('$baseUrl/doctor/getRating/$doctorId'),
    headers: {
      'Authorization': 'Bearer $token', // Add the token to the request header
    },
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    print(response.body);
    return jsonDecode(response.body); // Returning a map (JSON response)
  } else {
    throw Exception('Failed to load ratings');
  }
}
