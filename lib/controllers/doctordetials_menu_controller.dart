// controllers/details_controller.dart

import 'package:get/get.dart';

class DetailsController extends GetxController {
  // Reactive variables
  var isLoading = true.obs;
  var detailData = {}.obs; // Replace with your model or data type

  @override
  void onInit() {
    super.onInit();
    fetchDetailData(); // Fetch the data when the controller is initialized
  }

  // Method to fetch data
  void fetchDetailData() async {
    try {
      // Simulate fetching data with a delay
      await Future.delayed(Duration(seconds: 2));

      // Here, you would fetch your data from the API
      // For example: detailData.value = await ApiService().fetchData();

      // Mock data
      detailData.value = {
        'name': 'Doctor A',
        'qualification': 'MBBS, MD',
        'experience': '10 years',
      };

      // Set loading to false after fetching data
      isLoading.value = false;
    } catch (e) {
      // Handle errors, set loading to false, and show error message if needed
      isLoading.value = false;
      print('Error fetching details: $e');
    }
  }
}
