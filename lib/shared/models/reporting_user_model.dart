class ReportingUserModel {
  final int? userId;
  final String? role;
  final String? firstName;
  final String? lastName;

  ReportingUserModel({this.userId, this.role, this.firstName, this.lastName});

  factory ReportingUserModel.fromJson(Map<String, dynamic> json) {
    return ReportingUserModel(
      userId: json['user_id'],
      role: json['role'],
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "role": role,
      "first_name": firstName,
      "last_name": lastName,
    };
  }

  ReportingUserModel copyWith({
    int? userId,
    String? role,
    String? firstName,
    String? lastName,
  }) {
    return ReportingUserModel(
      userId: userId ?? this.userId,
      role: role ?? this.role,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }

  String get fullName => "${firstName ?? ''} ${lastName ?? ''}".trim();
}
