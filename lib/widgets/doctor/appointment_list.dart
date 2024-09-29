import 'package:doctorappointmenapp/controllers/doctor/view_patientappointment.dart';
import 'package:doctorappointmenapp/models/appointment/appointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:doctorappointmenapp/themes/app_theme.dart';
import 'package:intl/intl.dart'; // Import the intl package

class PatientAppointmentView extends StatelessWidget {
  final String doctorId;

  // Constructor that accepts doctorId
  PatientAppointmentView({Key? key, required this.doctorId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize the controller with doctorId
    final PatientAppointmentController controller =
        Get.put(PatientAppointmentController(doctorId));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Appointments',
          style: boldTextStyle.copyWith(color: whiteColor),
        ),
        backgroundColor: greenColor,
      ),
      body: FutureBuilder<List<AppointmentModel>>(
        future: controller.fetchAppointments(), // Call fetchAppointments
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final appointments = snapshot.data;

            return ListView.builder(
              itemCount: appointments?.length ?? 0,
              itemBuilder: (context, index) {
                final appointment = appointments![index];

                // Date and time parsing with error handling
                DateTime? parsedDate;
                DateTime? parsedStartTime;
                DateTime? parsedEndTime;

                try {
                  parsedDate = DateTime.parse(appointment.date);
                  parsedStartTime = DateTime.parse(appointment.startTime);
                  parsedEndTime = DateTime.parse(appointment.endTime);
                } catch (e) {
                  // Log error and fallback to null values if parsing fails
                  print('Error parsing date or time: $e');
                }

                // Format the parsed DateTime objects or fallback to raw strings
                final String formattedDate = parsedDate != null
                    ? DateFormat('yyyy-MM-dd').format(parsedDate)
                    : appointment.date;
                final String formattedStartTime = parsedStartTime != null
                    ? DateFormat('h:mm a').format(parsedStartTime)
                    : appointment.startTime;
                final String formattedEndTime = parsedEndTime != null
                    ? DateFormat('h:mm a').format(parsedEndTime)
                    : appointment.endTime;

                return Card(
                  elevation: 4,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(appointment.patientImage),
                      radius: 30,
                    ),
                    title: Text(
                      appointment.patientName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    subtitle: Column(
                      children: [
                        
                        Row(
                          children: [
                            Expanded(
                              // Ensures that content within the Row is properly contained within available space
                              child: Row(
                                children: [
                                  const Icon(Icons.watch_later_rounded),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      '$formattedStartTime - $formattedEndTime',
                                      overflow: TextOverflow
                                          .ellipsis, // Ensures text does not overflow
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Icon(Icons.calendar_month_outlined,
                                      color: Colors.black),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      ' $formattedDate',
                                      overflow: TextOverflow
                                          .ellipsis, // Prevents overflow on the date text
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      // Handle appointment click if necessary
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
