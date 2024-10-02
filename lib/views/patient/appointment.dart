import 'package:doctorappointmenapp/controllers/appointment_controller.dart';
import 'package:doctorappointmenapp/themes/pagetheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentView extends StatelessWidget {
  final String doctorId; // doctorId is passed from the previous screen

  // Pass the doctorId to the controller
  final AppointmentController appointmentController;

  AppointmentView({required this.doctorId, super.key})
      : appointmentController = Get.put(AppointmentController(doctorId));

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: AppTheme.customTheme(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("My Appointments"),
            centerTitle: true,
          ),
          body: Obx(() {
            if (appointmentController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (appointmentController.errorMessage.isNotEmpty) {
              return Center(
                  child: Text(appointmentController.errorMessage.value));
            }

            return ListView.builder(
              itemCount: appointmentController.userAppointments.length,
              itemBuilder: (context, index) {
                final appointment =
                    appointmentController.userAppointments[index];
                return Card(
                  margin: const EdgeInsets.all(10.0),
                  elevation: 5,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10.0),
                    leading: appointment.doctorImage != null
                        ? CircleAvatar(
                            backgroundImage:
                                NetworkImage(appointment.doctorImage!),
                            radius: 30,
                          )
                        : const CircleAvatar(
                            backgroundColor: Colors.green,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                    title: Text(
                      "Dr.${appointment.doctorName}",
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(appointment.doctorSpecialization,
                            style: const TextStyle(fontSize: 18)),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(Icons.watch_later_rounded),
                                  Text(
                                      ' ${appointment.startTime} - ${appointment.endTime}'),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(Icons.calendar_month_outlined,
                                      color: Colors.black),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(' ${appointment.date}'),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    // Removed the trailing status box
                  ),
                );
              },
            );
          }),
        ));
  }
}
