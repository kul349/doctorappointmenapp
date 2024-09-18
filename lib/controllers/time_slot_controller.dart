import 'package:doctorappointmenapp/services/time_slot_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TimeSlotController extends GetxController {
  final String doctorId;

  TimeSlotController(this.doctorId) {
    if (doctorId.isEmpty) {
      throw ArgumentError('Doctor ID cannot be empty');
    }
    print("TimeSlotController initialized with Doctor ID: $doctorId");
  }

  // Selected time observable
  Rx<TimeOfDay> selectedTime = TimeOfDay(hour: 10, minute: 0).obs;

  // List of available time slots (fetched from backend)
  RxList<TimeOfDay> availableTimeSlots = <TimeOfDay>[].obs;

  // List of taken time slots (fetched from backend)
  RxList<TimeOfDay> takenTimeSlots = <TimeOfDay>[].obs;

  // Set of selected time slots
  final Set<TimeOfDay> _selectedTimeSlots = {};

  // Fetch available and taken time slots using the TimeSlotService
  Future<void> fetchAvailableTimeSlots(DateTime selectedDate) async {
    try {
      print("Fetching time slots for Doctor ID: $doctorId on $selectedDate");

      final result =
          await TimeSlotService.getAvailableTimeSlots(doctorId, selectedDate);

      List<TimeOfDay> fetchedAvailableSlots = [];
      List<TimeOfDay> fetchedTakenSlots = [];

      // Safely handle availableSlots (null check)
      if (result['availableSlots'] != null) {
        for (var slot in result['availableSlots']!) {
          final startTime = DateTime.parse(slot['startTime']).toLocal();
          fetchedAvailableSlots
              .add(TimeOfDay(hour: startTime.hour, minute: startTime.minute));
        }
      }

      // Safely handle takenSlots (null check)
      if (result['takenSlots'] != null) {
        for (var takenSlot in result['takenSlots']!) {
          final startTime = DateTime.parse(takenSlot['startTime']).toLocal();
          fetchedTakenSlots
              .add(TimeOfDay(hour: startTime.hour, minute: startTime.minute));
        }
      }

      // Assign fetched data to the respective observables
      availableTimeSlots.assignAll(fetchedAvailableSlots);
      takenTimeSlots.assignAll(fetchedTakenSlots);

      print("Available Slots: $fetchedAvailableSlots");
      print("Taken Slots: $fetchedTakenSlots");

      // Check if there are no available time slots
      if (availableTimeSlots.isEmpty) {
        Get.snackbar("Info", "No available time slots for the selected date.");
      }
    } catch (e) {
      Get.snackbar("Error", "Error fetching time slots: $e");
      print(e);
    }
  }

  // Update selected time
  void updateSelectedTime(TimeOfDay newTime) {
    selectedTime.value = newTime;
    print("Selected Time: $newTime");
  }

  // Convert TimeOfDay to DateTime (optional date parameter for specific date)
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
    update(); // Notify listeners to update the UI
  }

  // Get selected time slots
  List<TimeOfDay> get selectedTimeSlots => _selectedTimeSlots.toList();

  // Check if all available slots are taken
  bool allTimeSlotsTaken() {
    return availableTimeSlots.isEmpty;
  }

  // Format TimeOfDay to a readable string (e.g., "6:30 PM")
  String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final format = DateFormat.jm(); // 6:00 PM
    return format.format(dt);
  }
}
