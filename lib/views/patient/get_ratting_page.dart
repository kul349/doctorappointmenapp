import 'package:doctorappointmenapp/controllers/auth_controller.dart';
import 'package:doctorappointmenapp/controllers/rating_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:doctorappointmenapp/themes/app_theme.dart';

class RatingPage extends StatelessWidget {
  final RatingController ratingController = Get.put(RatingController());
  final String doctorId;

  // Constructor for RatingPage accepting doctorId
  RatingPage({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context) {
    final AuthController authController =
        Get.find<AuthController>(); // Access AuthController

    return Scaffold(
      appBar: AppBar(
        title: const Text("Rate Doctor"),
        centerTitle: true,
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),

              // Rating Bar
              RatingBar.builder(
                initialRating:
                    ratingController.rating.value, // Reactive rating value
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 40,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  ratingController.rating.value =
                      rating; // Update rating value reactively
                },
              ),

              const SizedBox(height: 40),

              // Review Input
              TextField(
                controller: ratingController.reviewController,
                decoration: const InputDecoration(
                  labelText: "Write your review",
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),

              const SizedBox(height: 20),

              // Submit Button
              Center(
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: greenColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: ratingController.isLoading.value
                        ? null // Disable button if loading
                        : () {
                            // Ensure patientId is available
                            if (authController.patientId.value.isEmpty) {
                              // Display an error if patientId is empty
                              ratingController.errorMessage.value =
                                  "Error: Patient ID is missing while submiting.";
                              return;
                            }

                            // Submit rating with doctorId and patientId
                            ratingController.submitRating(
                              doctorId,
                              authController.patientId.value,
                            );
                          },
                    child: Text(
                      ratingController.isLoading.value
                          ? "Submitting..."
                          : "Submit",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Error Message Display
              if (ratingController.errorMessage.isNotEmpty)
                Text(
                  ratingController.errorMessage.value,
                  style: const TextStyle(color: Colors.red),
                ),
            ],
          ),
        );
      }),
    );
  }
}
