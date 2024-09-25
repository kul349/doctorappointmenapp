import 'package:doctorappointmenapp/models/appointment/appointment.dart';
import 'package:doctorappointmenapp/services/token_service.dart';
import 'package:doctorappointmenapp/utils/constant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppointmentController extends GetxController {
  var userAppointments = <AppointmentModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  final TokenService _tokenService = TokenService(); // Instance of TokenService

  @override
  void onInit() {
    fetchUserAppointments();
    super.onInit();
  }

  Future<void> fetchUserAppointments() async {
    isLoading.value = true;
    errorMessage.value = ''; // Reset error message

    try {
      final token = await _tokenService.getToken();

      final response = await http.get(
        Uri.parse(
            '$baseUrl/appointment/getAllOfAppointment'), // Your API endpoint
        headers: {
          'Authorization': 'Bearer $token', // Include your auth token
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        userAppointments.value = (data['appointments'] as List)
            .map((appointment) => AppointmentModel.fromJson(appointment))
            .toList();
      } else {
        errorMessage.value = 'Error fetching appointments';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
