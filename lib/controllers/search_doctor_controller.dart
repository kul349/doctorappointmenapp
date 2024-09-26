import 'dart:async';
import 'package:doctorappointmenapp/models/doctor/gride_model.dart';
import 'package:doctorappointmenapp/utils/constant.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DoctorSearchController extends GetxController {
  var searchResults = <DoctorModel>[].obs;
  var isLoading = false.obs;
  Timer? _debounce; // Declare the debounce Timer variable

  // Search doctors based only on specialization
  void searchDoctors(String specialization) {
    // Cancel the previous timer if it's still active
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Create a new timer for the debounce effect
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      isLoading.value = true;

      // Clear results if specialization is empty
      if (specialization.isEmpty) {
        searchResults.clear();
        isLoading.value = false;
        return;
      }

      try {
        // Construct API call with query parameter for specialization only
        final url = Uri.parse(
          '$baseUrl/doctor/search-doctor?specialization=${Uri.encodeQueryComponent(specialization)}',
        );

        print('Request URL: $url'); // Log the request URL
        final response = await http.get(url);

        print('Response Status: ${response.statusCode}'); // Log the response status

        if (response.statusCode == 200) {
          // Parse the response
          final jsonData = jsonDecode(response.body);

          print('Response Body: $jsonData'); // Log the entire response for debugging

          // Ensure that the response is a list
          if (jsonData is List) {
            List<DoctorModel> doctors = jsonData
                .map((doctor) => DoctorModel.fromJson(doctor))
                .toList();
            searchResults.assignAll(doctors);
          } else {
            print('No doctors found in response or invalid format');
            searchResults.clear(); // Clear previous results if no doctors are found
          }
        } else {
          // Handle errors
          print('Error: ${response.statusCode}');
          searchResults.clear(); // Clear previous results on error
        }
      } catch (error) {
        print('Error fetching search results: $error');
        searchResults.clear(); // Clear previous results on exception
      } finally {
        isLoading.value = false;
      }
    });
  }
}
