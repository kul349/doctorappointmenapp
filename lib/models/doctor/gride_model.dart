class DoctorModel {
  final String fullName;
  final String avatar;
  final String email;
  final String doctorName;
  final String specialization;

  DoctorModel({
    required this.fullName,
    required this.avatar,
    required this.email,
    required this.doctorName,
    required this.specialization,
  });

  // Factory method to create a DoctorModel from JSON
  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      fullName: json['fullName'] ?? '',
      avatar: json['avatar'] ?? '',
      email: json['email'] ?? '',
      doctorName: json['doctorName'] ?? '',
      specialization: json['specialization'] ?? '',
    );
  }

  // Method to convert DoctorModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'avatar': avatar,
      'email': email,
      'doctorName': doctorName,
      'specialization': specialization,
    };
  }
}
