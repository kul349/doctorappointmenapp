class NotificationModel {
  String id;
  String userType;
  String userId;
  String title;
  String message;
  bool isRead;
  DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.userType,
    required this.userId,
    required this.title,
    required this.message,
    required this.isRead,
    required this.createdAt,
  });

  // Factory constructor to create a NotificationModel from JSON
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'],
      userType: json['userType'],
      userId: json['userId'],
      title: json['title'],
      message: json['message'],
      isRead: json['isRead'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // Convert the NotificationModel to JSON format (if needed)
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userType': userType,
      'userId': userId,
      'title': title,
      'message': message,
      'isRead': isRead,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
