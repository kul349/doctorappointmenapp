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

  Rx<TimeOfDay> selectedTime = TimeOfDay(hour: 10, minute: 0).obs;
  RxList<TimeOfDay> availableTimeSlots = <TimeOfDay>[].obs;
  RxList<TimeOfDay> takenTimeSlots = <TimeOfDay>[].obs;

  final Set<TimeOfDay> _selectedTimeSlots = {};

  Future<void> fetchAvailableTimeSlots(DateTime selectedDate) async {
    try {
      print("Fetching time slots for Doctor ID: $doctorId on $selectedDate");

      final result = await TimeSlotService.getAvailableTimeSlots(doctorId, selectedDate);

      List<TimeOfDay> fetchedAvailableSlots = [];
      List<TimeOfDay> fetchedTakenSlots = [];

      if (result['availableSlots'] != null) {
        for (var slot in result['availableSlots']!) {
          final startTime = DateTime.parse(slot['startTime']).toLocal();
          fetchedAvailableSlots.add(TimeOfDay(hour: startTime.hour, minute: startTime.minute));
        }
      }

      if (result['takenSlots'] != null) {
        for (var takenSlot in result['takenSlots']!) {
          final startTime = DateTime.parse(takenSlot['startTime']).toLocal();
          fetchedTakenSlots.add(TimeOfDay(hour: startTime.hour, minute: startTime.minute));
        }
      }

      availableTimeSlots.assignAll(fetchedAvailableSlots);
      takenTimeSlots.assignAll(fetchedTakenSlots);

      print("Available Slots: $fetchedAvailableSlots");
      print("Taken Slots: $fetchedTakenSlots");

      if (availableTimeSlots.isEmpty && takenTimeSlots.isEmpty) {
        Get.snackbar("Info", "No available time slots for the selected date.");
      }
    } catch (e) {
      Get.snackbar("Error", "Error fetching time slots: $e");
      print(e);
    }
  }

  void updateSelectedTime(TimeOfDay newTime) {
    selectedTime.value = newTime;
    print("Selected Time: $newTime");
  }

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

  bool isSelected(TimeOfDay timeOfDay) {
    return _selectedTimeSlots.contains(timeOfDay);
  }

  void toggleTimeSlot(TimeOfDay timeOfDay) {
    if (_selectedTimeSlots.contains(timeOfDay)) {
      _selectedTimeSlots.remove(timeOfDay);
    } else {
      _selectedTimeSlots.add(timeOfDay);
    }
    update();
  }

  List<TimeOfDay> get selectedTimeSlots => _selectedTimeSlots.toList();

  bool allTimeSlotsTaken() {
    return availableTimeSlots.isEmpty && takenTimeSlots.isNotEmpty;
  }

  String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final format = DateFormat.jm();
    return format.format(dt);
  }
}
