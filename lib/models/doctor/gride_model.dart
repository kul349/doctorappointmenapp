class DoctorModel {
   String id;
   String fullName;
   String avatar;
   String email;
   String doctorName;
   String specialization;
   double averageRating;
   int totalRatings;
  String availabilityStatus;

  // New fields for update
   String? licenseNumber;
   String? bio;
   String? clinicName;
   String? clinicAddress;
   double? consultationFee;
   List<double>? locationCoordinates;

  DoctorModel({
    required this.fullName,
    required this.avatar,
    required this.email,
    required this.doctorName,
    required this.specialization,
    required this.averageRating,
    required this.totalRatings,
    required this.availabilityStatus,
    required this.id,
    this.licenseNumber,
    this.bio,
    this.clinicName,
    this.clinicAddress,
    this.consultationFee,
    this.locationCoordinates,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    final ratingsSummary = json['ratingsSummary'] ?? {};

    return DoctorModel(
      id: json['_id'] ?? "",
      fullName: json['fullName'] ?? '',
      avatar: json['avatar'] ?? '',
      email: json['email'] ?? '',
      doctorName: json['doctorName'] ?? '',
      specialization: json['specialization'] ?? '',
      averageRating: (ratingsSummary['averageRating'] ?? 0).toDouble(),
      totalRatings: (ratingsSummary['totalRatings'] ?? 0).toInt(),
      availabilityStatus: json['availabilityStatus'] ?? 'unknown',

      // Fetching the new fields if present in the JSON
      licenseNumber: json['licenseNumber'] ?? '',
      bio: json['bio'] ?? '',
      clinicName: json['clinicName'] ?? '',
      clinicAddress: json['clinicAddress'] ?? '',
      consultationFee: (json['consultationFee'] ?? 0).toDouble(),
      locationCoordinates: (json['location'] != null && json['location']['coordinates'] != null)
          ? List<double>.from(json['location']['coordinates'].map((e) => e.toDouble()))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
      'licenseNumber': licenseNumber,
      'bio': bio,
      'clinicName': clinicName,
      'clinicAddress': clinicAddress,
      'consultationFee': consultationFee,
      'location': locationCoordinates != null
          ? {
              'coordinates': locationCoordinates,
            }
          : null,
      "_id": id,
    };
  }
}
