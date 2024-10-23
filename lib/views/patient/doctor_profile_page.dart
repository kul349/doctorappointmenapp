import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:doctorappointmenapp/controllers/auth_controller.dart';
import 'package:doctorappointmenapp/controllers/time_slot_controller.dart';
import 'package:doctorappointmenapp/services/bookappointment.dart';
import 'package:doctorappointmenapp/services/token_service.dart';
import 'package:doctorappointmenapp/themes/app_theme.dart';
import 'package:doctorappointmenapp/utils/constant.dart';
import 'package:doctorappointmenapp/utils/decode_patient_token.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctorappointmenapp/models/doctor/gride_model.dart';
import 'package:doctorappointmenapp/controllers/doctor_profile_controller.dart';
import 'package:intl/intl.dart';

class DoctorProfileDetails extends StatefulWidget {
  const DoctorProfileDetails({super.key});

  @override
  State<DoctorProfileDetails> createState() => _DoctorProfileDetailsState();
}

class _DoctorProfileDetailsState extends State<DoctorProfileDetails> {
  final DoctorProfileController controller = Get.put(
    DoctorProfileController(Get.arguments as DoctorModel),
  );
  final AuthController authController = Get.find<AuthController>();

  var selectedDate = DateTime.now().obs; // Observable for selected date
  var selectedTime = TimeOfDay.now().obs; // Observable for selected time
  @override
  void initState() {
    super.initState();

    final doctorModel = Get.arguments as DoctorModel;
    final doctorId = doctorModel.id;

    print('Initializing TimeSlotController with Doctor ID: $doctorId');
    Get.put(TimeSlotController(doctorId));

    final TimeSlotController timeSlotController =
        Get.find<TimeSlotController>();
    timeSlotController.fetchAvailableTimeSlots(selectedDate.value);
  }

  List<Map<String, String>> convertTimeOfDayListToMapList(
      List<TimeOfDay> timeOfDayList) {
    return timeOfDayList.map((timeOfDay) => timeOfDayToMap(timeOfDay)).toList();
  }

  Map<String, String> timeOfDayToMap(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final startTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    final format = DateFormat('yyyy-MM-ddTHH:mm:ss')
        .format(startTime); // ISO 8601 format for the API

    return {
      'startTime': format,
      'endTime': format, // Adjust this if needed
    };
  }

  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;

    // Fetch available slots whenever the date changes
    final TimeSlotController timeSlotController =
        Get.find<TimeSlotController>();
    timeSlotController.fetchAvailableTimeSlots(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.doctor.specialization),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDoctorCard(),
                    const SizedBox(height: 8),
                    // SizedBox(
                    //     child: Text(
                    //         'Retrieved Patient ID in DoctorProfileDetails: ${authController.patientId.value}')),
                    _buildDateTimeline(),
                    const SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          final TimeSlotController timeSlotController =
                              Get.find<TimeSlotController>();
                          final selectedTime =
                              timeSlotController.selectedTime.value;
                          if (selectedTime != null) {
                            // Proceed with booking logic
                            final tokenService = TokenService();
                            String? token = await tokenService.getToken();
                            print("token for appointment:$token");
                            if (token != null) {
                              String formattedDate = DateFormat('yyyy-MM-dd')
                                  .format(selectedDate.value);
                              // Convert TimeOfDay to a string in HH:mm format
                              String formattedTimeSlot =
                                  "${selectedTime.hour}:${selectedTime.minute.toString().padLeft(2, '0')}";
                              String? patientId = await TokenHelper
                                  .getPatientId(); // Log the values before booking
                              print('Patient ID: $patientId');
                              print('Doctor ID: ${controller.doctor.id}');
                              print('Formatted Date: $formattedDate');
                              print('Formatted Time Slot: $formattedTimeSlot');

                              try {
                                await bookAppointment(
                                    token: token,
                                    patientId: patientId ?? "",
                                    doctorId: controller.doctor.id,
                                    date: formattedDate,
                                    startTime: formattedTimeSlot);
                                print(
                                    "Booking appointment at $selectedTime on ${selectedDate.value}");
                                print(authController.patientId.value);
                                print("Navigating to Rating page");

                                Get.toNamed(
                                  AppRoutes.addRating,
                                  arguments: {
                                    'doctorId': controller.doctor.id,
                                    "patientId": patientId
                                  },
                                );
                              } catch (e) {
                                print(
                                  "bad error:$e",
                                );
                              }
                            } else {
                              Get.snackbar("Error", "You have to login ");
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Book Appointment",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for Doctor Card
  Widget _buildDoctorCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100, // Set the desired width
                  height: 140, // Set the desired height
                  child: controller.doctor.avatar.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            controller.doctor.avatar,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Icon(
                          Icons.person,
                          size: 60,
                        ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dr. ${controller.doctor.fullName}',
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        controller.doctor.specialization,
                        style: const TextStyle(fontSize: 18),
                      ),
                      Row(
                        children: [
                          ratingCard(),
                          const SizedBox(width: 4),
                          _buildPatientCard(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            _buildAboutSection(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // Widget for Patient Card
  Widget _buildPatientCard() {
    return Card(
      color: kpurplecolor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: const Padding(
        padding: EdgeInsets.all(1.0),
        child: Column(
          children: [
            SizedBox(
              height: 90,
              width: 83,
              child: Column(
                children: [
                  Text("PATIENT",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text("1000+",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Icon(Icons.people_alt),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget ratingCard() {
    return Card(
      color: kpinkcolor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          children: [
            SizedBox(
              height: 80,
              child: Column(
                children: [
                  const Text(
                    "Rating",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    controller.doctor.averageRating.toStringAsFixed(1),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildStarRating(controller.doctor.averageRating),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildStarRating(double rating) {
    List<Widget> stars = [];
    int fullStars = rating.floor();
    bool hasHalfStar = rating - fullStars >= 0.5;

    for (int i = 0; i < fullStars; i++) {
      stars.add(const Icon(Icons.star, color: Colors.amber, size: 17));
    }

    if (hasHalfStar) {
      stars.add(const Icon(Icons.star_half, color: Colors.amber, size: 16));
    }

    while (stars.length < 5) {
      stars.add(const Icon(Icons.star_border, color: Colors.amber, size: 16));
    }

    return stars;
  }

  // Widget for About Section
  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Dr. ${controller.doctor.fullName} is a highly skilled ${controller.doctor.specialization}.',
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  // Widget for Date and Time Selection
  Widget _buildDateTimeline() {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Choose date",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: DatePicker(
              DateTime.now(),
              height: 95,
              width: 82,
              initialSelectedDate: DateTime.now(),
              selectedTextColor: Colors.white,
              selectionColor: Colors.green,
              onDateChange: (date) {
                updateSelectedDate(date);
                print("Selected Date: $date");
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Choose Time",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
          ),
          const SizedBox(height: 8),
          buildTimeSlotPicker(),
        ],
      ),
    );
  }

  // Time slot picker widget
  Widget buildTimeSlotPicker() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Obx(() {
        final TimeSlotController timeSlotController =
            Get.find<TimeSlotController>();
        List<TimeOfDay> availableSlots = timeSlotController.availableTimeSlots;
        List<TimeOfDay> takenSlots = timeSlotController.takenTimeSlots
            .toList(); // Convert RxList to List

        // Convert takenSlots to List<Map<String, String>>
        List<Map<String, String>> takenSlotsMap =
            convertTimeOfDayListToMapList(takenSlots);

        // Reset the selected time if date changes
        if (availableSlots.isNotEmpty &&
            timeSlotController.selectedTime.value == null) {
          // Select the first available slot if no time is currently selected
          timeSlotController.updateSelectedTime(availableSlots.first);
        }

        // If no slots are available, show a message
        if (availableSlots.isEmpty && takenSlots.isEmpty) {
          return const Center(
            child: Text(
              'No available time slots for the selected date',
              style: TextStyle(color: Colors.red, fontSize: 18),
            ),
          );
        }
// don't use expand here it's a incorrect use of parentdata widget
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: availableSlots.length,
          itemBuilder: (context, index) {
            final slot = availableSlots[index];
            final isTaken = takenSlots.any((slotTime) {
              // Convert TimeOfDay to DateTime for comparison
              final slotDateTime = DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
                slotTime.hour,
                slotTime.minute,
              );

              // Check if the slotDateTime falls within the taken time slots
              return takenSlotsMap.any((slotMap) {
                final startTime = DateTime.parse(slotMap['startTime']!);
                final endTime = DateTime.parse(slotMap['endTime']!);
                return slotDateTime.isAfter(startTime) &&
                    slotDateTime.isBefore(endTime);
              });
            });
            final isSelected = slot == timeSlotController.selectedTime.value;

            return GestureDetector(
              onTap: isTaken
                  ? null // Disable if slot is taken
                  : () {
                      // Update selected time slot and handle color changes
                      timeSlotController.updateSelectedTime(slot);
                    },
              child: Container(
                decoration: BoxDecoration(
                  color: isTaken
                      ? Colors.red // Taken slot color
                      : isSelected
                          ? Colors.green // Selected slot color
                          : Colors.grey[200], // Available slot color
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected ? Colors.green : Colors.grey,
                  ),
                ),
                child: Center(
                  child: Text(
                    formatTimeOfDay(slot),
                    style: TextStyle(
                      color:
                          isTaken || isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  // Helper function to format TimeOfDay
  String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final format = DateFormat.jm(); // '6:00 PM'
    return format.format(dt);
  }
}
