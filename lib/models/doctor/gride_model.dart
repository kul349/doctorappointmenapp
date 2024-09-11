class DoctorModel {
  final String fullName;
  final String avatar;
  final String email;
  final String doctorName;
  final String specialization;
  final double averageRating;
  final int totalRatings;
  final String availabilityStatus;

  DoctorModel({
    required this.fullName,
    required this.avatar,
    required this.email,
    required this.doctorName,
    required this.specialization,
    required this.averageRating,
    required this.totalRatings,
    required this.availabilityStatus,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    final ratingsSummary = json['ratingsSummary'] ?? {};
    
    return DoctorModel(
      fullName: json['fullName'] ?? '',
      avatar: json['avatar'] ?? '',
      email: json['email'] ?? '',
      doctorName: json['doctorName'] ?? '',
      specialization: json['specialization'] ?? '',
      averageRating: (ratingsSummary['averageRating'] ?? 0).toDouble(),
      totalRatings: (ratingsSummary['totalRatings'] ?? 0).toInt(),
      availabilityStatus: json['availabilityStatus'] ?? 'unknown',
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
    };
  }
}
