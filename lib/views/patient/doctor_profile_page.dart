// views/patient/doctor_profile_details.dart
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:doctorappointmenapp/controllers/time_slot_controller.dart';
import 'package:doctorappointmenapp/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctorappointmenapp/models/doctor/gride_model.dart';
import 'package:doctorappointmenapp/controllers/doctor_profile_controller.dart';

class DoctorProfileDetails extends StatefulWidget {
  const DoctorProfileDetails({super.key});

  @override
  State<DoctorProfileDetails> createState() => _DoctorProfileDetailsState();
}

class _DoctorProfileDetailsState extends State<DoctorProfileDetails> {
  // Initializing the GetX controller with the doctor model
  final DoctorProfileController controller = Get.put(
    DoctorProfileController(Get.arguments as DoctorModel),
  );

  var selectedDate = DateTime.now().obs; // Observable selected date
  var selectedTime = DateTime.now().obs; // Observable for selected time

  @override
  void initState() {
    super.initState();

    // Ensure that DoctorProfileController is initialized with the correct doctor
    final doctorModel = Get.arguments as DoctorModel;
    final doctorId = doctorModel.id;

    print('Initializing TimeSlotController with Doctor ID: $doctorId');

    Get.put(TimeSlotController(doctorId));
  }

  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
  }

  void updateSelectedTime(DateTime time) {
    selectedTime.value = time;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.doctor.specialization),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDoctorCard(),
                  const SizedBox(height: 8),
                  _buildDateTimeline(),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
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
                const SizedBox(width: 20),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dr. ${controller.doctor.fullName}',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        ' ${controller.doctor.specialization}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Row(
                        children: [
                          Expanded(child: ratingCard()),
                          const SizedBox(width: 4),
                          Expanded(child: _buildPatientCard()),
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
          padding: EdgeInsets.all(18.0),
          child: Column(
            children: [
              Text("PATIENT",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text("1000+",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              (Icon(Icons.people_alt))
            ],
          )),
    );
  }

  Widget ratingCard() {
    return Card(
      color: kpinkcolor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              "Rating",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              controller.doctor.averageRating.toStringAsFixed(1),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildStarRating(controller.doctor.averageRating),
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
      stars.add(const Icon(Icons.star, color: Colors.amber, size: 20));
    }

    if (hasHalfStar) {
      stars.add(const Icon(Icons.star_half, color: Colors.amber, size: 18));
    }

    while (stars.length < 5) {
      stars.add(const Icon(Icons.star_border, color: Colors.amber, size: 18));
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
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Dr. ${controller.doctor.fullName} is a highly skilled ${controller.doctor.specialization}.',
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          'Dr. ${controller.doctor.id} is a highly skilled ${controller.doctor.specialization}.',
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Choose date",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: DatePicker(
            DateTime.now(),
            height: 95,
            width: 82,
            initialSelectedDate: DateTime.now(),
            selectedTextColor: whiteColor,
            selectionColor: Colors.green,
            onDateChange: (date) {
              updateSelectedDate(date);
              print(date);
            },
          ),
        ),
        const Text(
          "Choose Time",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        buildTimeSlotPicker(),
        const SizedBox(height: 10),
        Center(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "Book Appointment",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 30),
      ]),
    );
  }

  // Widget for Time Slot Picker
  Widget buildTimeSlotPicker() {
    final TimeSlotController timeSlotController =
        Get.find<TimeSlotController>();

    List<TimeOfDay> timeSlots = generateTimeSlots(
      TimeOfDay(hour: 9, minute: 0),
      TimeOfDay(hour: 17, minute: 0),
    );

    bool allSlotsTaken = timeSlotController.allTimeSlotsTaken(timeSlots);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: allSlotsTaken
          ? Center(
              child: Text(
                'All time slots are taken',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            )
          : SizedBox(
              height: 500,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: timeSlots.length,
                itemBuilder: (context, index) {
                  final slot = timeSlots[index];
                  return Obx(() {
                    final isSelected =
                        slot == timeSlotController.selectedTime.value;
                    final isTaken =
                        timeSlotController.takenTimeSlots.contains(slot);

                    return GestureDetector(
                      onTap: isTaken
                          ? null
                          : () {
                              timeSlotController.updateSelectedTime(slot);
                            },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isTaken
                              ? Colors.red
                              : isSelected
                                  ? Colors.green
                                  : Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: isSelected ? Colors.green : Colors.grey),
                        ),
                        child: Center(
                          child: Text(
                            formatTimeOfDay(slot),
                            style: TextStyle(
                              color: isSelected || isTaken
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  });
                },
              ),
            ),
    );
  }

  // Generate time slots based on start and end times
  List<TimeOfDay> generateTimeSlots(TimeOfDay startTime, TimeOfDay endTime) {
    List<TimeOfDay> slots = [];
    TimeOfDay current = startTime;

    while (current.hour < endTime.hour ||
        (current.hour == endTime.hour && current.minute < endTime.minute)) {
      slots.add(current);
      int nextMinute = current.minute + 30;
      int nextHour = current.hour;

      if (nextMinute >= 60) {
        nextMinute -= 60;
        nextHour++;
      }

      if (nextHour >= 24) {
        break; // Prevent going beyond 24 hours
      }

      current = TimeOfDay(hour: nextHour, minute: nextMinute);
    }

    return slots;
  }

  // Helper function to format TimeOfDay
  String formatTimeOfDay(TimeOfDay timeOfDay) {
    return MaterialLocalizations.of(Get.context!).formatTimeOfDay(
      timeOfDay,
      alwaysUse24HourFormat: false,
    );
  }
}
