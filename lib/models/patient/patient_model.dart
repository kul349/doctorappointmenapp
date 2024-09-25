class UserModel {
  final String patientId;
  final String email;
  final String fullName;
  final String userName;
  final String avatar;

  UserModel(
      {required this.email,
      required this.fullName,
      required this.userName,
      required this.avatar,
      required this.patientId});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        patientId: json["_id"] ?? "",
        email: json["email"] ?? "",
        fullName: json["fullName"] ?? "",
        userName: json["userName"] ?? "",
        avatar: json["avatar"] ?? "");
  }
  Map<String, dynamic> toJson() {
    return {
      patientId: patientId,
      fullName: fullName,
      userName: userName,
      email: email,
      avatar: avatar
    };
  }
}
