class AppointmentModel {
  final String appointmentId;
  final String patientId;
  final String doctorId;
  final String patientName;
  final String doctorName;
  final String doctorSpecialization;
  final String date;
  final String startTime;
  final String endTime;
  final String doctorImage;
  final String patientImage;
  AppointmentModel(
      {required this.appointmentId,
      required this.patientId,
      required this.patientName,
      required this.doctorName,
      required this.doctorSpecialization,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.doctorImage,
      required this.doctorId,
      required this.patientImage});

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      appointmentId: json['appointmentId'] ?? "",
      patientId: json['patientId'] ?? "",
      patientName: json['patientName'] ?? "",
      doctorName: json['doctorName'] ?? "",
      doctorSpecialization: json['doctorSpecialization'] ?? "",
      date: json['date'] ?? "",
      startTime: json['startTime'] ?? "",
      endTime: json['endTime'] ?? "",
      doctorImage: json['doctorImage'] ?? "",
      doctorId: json['doctorId'] ?? "",
      patientImage: json['patientImage'] ?? "",
    );
  }
}
