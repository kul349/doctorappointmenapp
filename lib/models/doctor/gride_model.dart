class DoctorModel {
  final String fullName;
  final String avatar;
  final String email;
  final String doctorName;
  final String specialization;
  final double ratings;  // Add this field
  final String availabilityStatus;  // Add this field

  DoctorModel({
    required this.fullName,
    required this.avatar,
    required this.email,
    required this.doctorName,
    required this.specialization,
    required this.ratings,  // Initialize here
    required this.availabilityStatus,  // Initialize here
  });

  // Factory method to create a DoctorModel from JSON
  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      fullName: json['fullName'] ?? '',
      avatar: json['avatar'] ?? '',
      email: json['email'] ?? '',
      doctorName: json['doctorName'] ?? '',
      specialization: json['specialization'] ?? '',
      ratings: (json['ratings'] ?? 0).toDouble(),  // Parse the rating
      availabilityStatus: json['availabilityStatus'] ?? 'unknown',  // Parse the availability status
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
      'ratings': ratings,  // Convert rating to JSON
      'availabilityStatus': availabilityStatus,  // Convert availability status to JSON
    };
  }
}
