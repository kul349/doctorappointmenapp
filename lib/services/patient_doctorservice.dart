import 'package:doctorappointmenapp/utils/constant.dart';
import 'package:http/http.dart' as http;

void fetchDoctors(String? specialization) async {
  String url = '$baseUrl/doctors'; // Replace with your backend API URL

  if (specialization != null && specialization != 'All') {
    url += '?specialization=$specialization'; // Append specialization query parameter
  }

  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // Parse the response and update your UI with the list of doctors
      print('Doctors fetched successfully');
      // Handle the response data as per your app's requirements
    } else {
      print('Failed to fetch doctors: ${response.body}');
    }
  } catch (error) {
    print('Error fetching doctors: $error');
  }
}
