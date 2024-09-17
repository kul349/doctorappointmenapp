import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:doctorappointmenapp/utils/constant.dart';

class TimeSlotController extends GetxController {
  final String doctorId;

  TimeSlotController(this.doctorId) {
    if (doctorId.isEmpty) {
      print("Doctor ID cannot be empty");
      throw ArgumentError('Doctor ID cannot be empty');
    }
    print(
        "TimeSlotController initialized with Doctor ID before passing url: $doctorId");
  }

  // Selected time observable
  Rx<TimeOfDay> selectedTime = TimeOfDay(hour: 10, minute: 0).obs;

  // List of available time slots (fetched from backend)
  RxList<TimeOfDay> availableTimeSlots = <TimeOfDay>[].obs;

  // List of taken time slots (fetched from backend)
  RxList<TimeOfDay> takenTimeSlots = <TimeOfDay>[].obs;

  // Set of selected time slots
  final Set<TimeOfDay> _selectedTimeSlots = {};

  // Fetch available time slots and taken time slots from the backend
  Future<void> fetchAvailableTimeSlots(DateTime selectedDate) async {
    print("fetchAvailableTimeSlots method called");

    String formattedDate =
        "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
    final url = Uri.parse(
      '$baseUrl/appointment/getAvailableTimeSlots/$doctorId?date=$formattedDate',
    );

    print("Request URL: $url"); // Print URL for debugging
    print("Doctor ID: $doctorId"); // Debugging output

    try {
      final response = await http.get(url);

      print(
          "Status Code: ${response.statusCode}"); // Print status code for debugging

      if (response.statusCode == 200) {
        print("Response body: ${response.body}");
        final data = jsonDecode(response.body);
        print("Decoded data: $data");

        List<TimeOfDay> fetchedTimeSlots = [];
        List<TimeOfDay> fetchedTakenSlots = [];

        if (data['availableSlots'] != null) {
          for (var slot in data['availableSlots']) {
            final startTime = DateTime.parse(slot['startTime']).toLocal();
            fetchedTimeSlots
                .add(TimeOfDay(hour: startTime.hour, minute: startTime.minute));
          }
        }

        if (data['takenSlots'] != null) {
          for (var takenSlot in data['takenSlots']) {
            final startTime = DateTime.parse(takenSlot['startTime']).toLocal();
            fetchedTakenSlots
                .add(TimeOfDay(hour: startTime.hour, minute: startTime.minute));
          }
        }

        availableTimeSlots.assignAll(fetchedTimeSlots);
        takenTimeSlots.assignAll(fetchedTakenSlots);
      } else {
        Get.snackbar("Error",
            "Failed to fetch time slots. Status code: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "Error fetching time slots: $e");
    }
  }

  // Update selected time
  void updateSelectedTime(TimeOfDay newTime) {
    selectedTime.value = newTime;
    print("Selected Time: $newTime");
  }

  // Convert TimeOfDay to DateTime
  DateTime timeOfDayToDateTime(TimeOfDay timeOfDay, {DateTime? dateTime}) {
    if (dateTime != null) {
      return DateTime(dateTime.year, dateTime.month, dateTime.day,
          timeOfDay.hour, timeOfDay.minute);
    } else {
      final now = DateTime.now();
      return DateTime(
          now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    }
  }

  // Check if a time slot is selected
  bool isSelected(TimeOfDay timeOfDay) {
    return _selectedTimeSlots.contains(timeOfDay);
  }

  // Toggle selection of a time slot
  void toggleTimeSlot(TimeOfDay timeOfDay) {
    if (_selectedTimeSlots.contains(timeOfDay)) {
      _selectedTimeSlots.remove(timeOfDay);
    } else {
      _selectedTimeSlots.add(timeOfDay);
    }
    update(); // Notify listeners
  }

  // Get selected time slots
  List<TimeOfDay> get selectedTimeSlots => _selectedTimeSlots.toList();

  // Check if all time slots are taken
  bool allTimeSlotsTaken(List<TimeOfDay> timeSlots) {
    return availableTimeSlots.isEmpty ||
        availableTimeSlots.length == timeSlots.length;
  }
}
