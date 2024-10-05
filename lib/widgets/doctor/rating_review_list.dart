import 'package:doctorappointmenapp/services/doctor/review_rating_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DoctorReviewsPage extends StatelessWidget {
  final String doctorId;

  const DoctorReviewsPage(this.doctorId, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Reviews'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchRatings(doctorId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final ratings = snapshot.data!['ratings'];
            final ratingsSummary = snapshot.data!['ratingsSummary'];
            double averageRating = ratingsSummary['averageRating'] ?? 0.0;
            String formattedRating = averageRating.toStringAsFixed(2);

            return Column(
              children: [
                // Display summary
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Average Rating: $formattedRating',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Total Ratings: ${ratingsSummary['totalRatings']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),

                // Display reviews
                Expanded(
                  child: ListView.builder(
                    itemCount: ratings.length,
                    itemBuilder: (context, index) {
                      final review = ratings[index];
                      final patient = review['patient'];
                      // Parse and format the date to 'YYYY-MM-DD'
                      String rawDate = review[
                          'date']; // Assuming 'date' is in ISO 8601 format
                      DateTime parsedDate = DateTime.parse(rawDate);
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(parsedDate);

                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(patient['image']),
                          ),
                          title: Text(
                            '${patient['fullName']}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Rating: ${review['rating']}'),
                                Text('Review: ${review['review']}'),
                                Text('Date: $formattedDate'),
                              ] // Use formatted date
                              ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
