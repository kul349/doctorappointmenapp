class Patient {
  final String fullName;
  final String image;

  Patient({required this.fullName, required this.image});

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      fullName: json['fullName'],
      image: json['image'],
    );
  }
}

class Rating {
  final String review;
  final double rating;
  final Patient patient;
  final DateTime date;

  Rating({required this.review, required this.rating, required this.patient, required this.date});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      review: json['review'],
      rating: json['rating'].toDouble(),
      patient: Patient.fromJson(json['patient']),
      date: DateTime.parse(json['date']),
    );
  }
}
