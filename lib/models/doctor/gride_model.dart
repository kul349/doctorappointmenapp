class DoctorModel {
  String id; // Corresponds to _id in MongoDB
  String fullName;
  String avatar;
  String email;
  String doctorName;
  String specialization;
  double averageRating; // From ratingsSummary.averageRating
  int totalRatings; // From ratingsSummary.totalRatings
  String availabilityStatus;
  String? licenseNumber;
  String? bio;
  String? clinicName;
  String? clinicAddress;
  double? consultationFee;
  List<double>? locationCoordinates; // For location.coordinates field

  DoctorModel({
    required this.id,
    required this.fullName,
    required this.avatar,
    required this.email,
    required this.doctorName,
    required this.specialization,
    required this.averageRating,
    required this.totalRatings,
    required this.availabilityStatus,
    this.licenseNumber,
    this.bio,
    this.clinicName,
    this.clinicAddress,
    this.consultationFee,
    this.locationCoordinates,
  });

  // Factory constructor to create an instance from JSON
  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    final ratingsSummary = json['ratingsSummary'] ?? {};

    return DoctorModel(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      avatar: json['avatar'] ?? '',
      email: json['email'] ?? '',
      doctorName: json['doctorName'] ?? '',
      specialization: json['specialization'] ?? '',
      averageRating: (ratingsSummary['averageRating'] ?? 0).toDouble(),
      totalRatings: (ratingsSummary['totalRatings'] ?? 0).toInt(),
      availabilityStatus: json['availabilityStatus'] ?? 'unknown',
      licenseNumber: json['licenseNumber'],
      bio: json['bio'],
      clinicName: json['clinicName'],
      clinicAddress: json['clinicAddress'],
      consultationFee: json['consultationFee'] != null
          ? (json['consultationFee']).toDouble()
          : null,
      locationCoordinates:
          (json['location'] != null && json['location']['coordinates'] != null)
              ? List<double>.from(
                  json['location']['coordinates'].map((e) => e.toDouble()))
              : null,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'fullName': fullName,
      'avatar': avatar,
      'email': email,
      'doctorName': doctorName,
      'specialization': specialization,
      'ratingsSummary': {
        'averageRating': averageRating,
        'totalRatings': totalRatings,
      },
      'availabilityStatus': availabilityStatus,
      '_id': id,
    };

    if (licenseNumber != null) data['licenseNumber'] = licenseNumber;
    if (bio != null) data['bio'] = bio;
    if (clinicName != null) data['clinicName'] = clinicName;
    if (clinicAddress != null) data['clinicAddress'] = clinicAddress;
    if (consultationFee != null) data['consultationFee'] = consultationFee;
    if (locationCoordinates != null) {
      data['location'] = {
        'coordinates': locationCoordinates,
      };
    }

    return data;
  }
}
