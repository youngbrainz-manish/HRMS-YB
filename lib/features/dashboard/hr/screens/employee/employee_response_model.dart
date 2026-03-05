class EmployeesResponseModel {
  final bool? success;
  final String? message;
  final EmployeesData? employeesData;

  EmployeesResponseModel({this.success, this.message, this.employeesData});

  factory EmployeesResponseModel.fromJson(Map<String, dynamic> json) {
    return EmployeesResponseModel(
      success: json["success"],
      message: json["message"],
      employeesData: json["data"] != null ? EmployeesData.fromJson(json["data"]) : null,
    );
  }

  Map<String, dynamic> toJson() => {"success": success, "message": message, "data": employeesData?.toJson()};

  EmployeesResponseModel copyWith({bool? success, String? message, EmployeesData? employeesData}) {
    return EmployeesResponseModel(
      success: success ?? this.success,
      message: message ?? this.message,
      employeesData: employeesData ?? this.employeesData,
    );
  }
}

///////////////////////////////////////////////////////////////

class EmployeesData {
  final int? totalRecords;
  final int? currentPage;
  final int? totalPages;
  final List<EmployeeDetailsModel>? employeeDetailsList;

  EmployeesData({this.totalRecords, this.currentPage, this.totalPages, this.employeeDetailsList});

  factory EmployeesData.fromJson(Map<String, dynamic> json) {
    return EmployeesData(
      totalRecords: json["totalRecords"],
      currentPage: json["currentPage"],
      totalPages: json["totalPages"],
      employeeDetailsList: json["employees"] == null
          ? []
          : List<EmployeeDetailsModel>.from(json["employees"].map((x) => EmployeeDetailsModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "totalRecords": totalRecords,
    "currentPage": currentPage,
    "totalPages": totalPages,
    "employees": employeeDetailsList?.map((e) => e.toJson()).toList(),
  };

  EmployeesData copyWith({
    int? totalRecords,
    int? currentPage,
    int? totalPages,
    List<EmployeeDetailsModel>? employeeDetailsList,
  }) {
    return EmployeesData(
      totalRecords: totalRecords ?? this.totalRecords,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      employeeDetailsList: employeeDetailsList ?? this.employeeDetailsList,
    );
  }
}

///////////////////////////////////////////////////////////////

class EmployeeDetailsModel {
  final String? profilePhoto;
  final int? userId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? countryCode;
  final String? mobileNo;
  final String? status;
  final DateTime? createdAt;
  final int? roleId;
  final String? roleName;
  final ReportingTo? reportingTo;
  final String? lastWorkingDay;
  final String? deptName;
  final String? designation;

  EmployeeDetailsModel({
    this.profilePhoto,
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.countryCode,
    this.mobileNo,
    this.status,
    this.createdAt,
    this.roleId,
    this.roleName,
    this.reportingTo,
    this.lastWorkingDay,
    this.deptName,
    this.designation,
  });

  factory EmployeeDetailsModel.fromJson(Map<String, dynamic> json) {
    return EmployeeDetailsModel(
      profilePhoto: json["profile_photo"],
      userId: json["user_id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      countryCode: json["country_code"],
      mobileNo: json["mobile_no"],
      status: json["status"],
      createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
      roleId: json["role_id"],
      roleName: json["role_name"],
      reportingTo: json["reporting_to"] != null ? ReportingTo.fromJson(json["reporting_to"]) : null,
      lastWorkingDay: json["last_working_day"],
      deptName: json["dept_name"],
      designation: json["designation"],
    );
  }

  Map<String, dynamic> toJson() => {
    "profile_photo": profilePhoto,
    "user_id": userId,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "country_code": countryCode,
    "mobile_no": mobileNo,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "role_id": roleId,
    "role_name": roleName,
    "reporting_to": reportingTo?.toJson(),
    "last_working_day": lastWorkingDay,
    "dept_name": deptName,
    "designation": designation,
  };

  EmployeeDetailsModel copyWith({
    String? profilePhoto,
    int? userId,
    String? firstName,
    String? lastName,
    String? email,
    String? countryCode,
    String? mobileNo,
    String? status,
    DateTime? createdAt,
    int? roleId,
    String? roleName,
    ReportingTo? reportingTo,
    String? lastWorkingDay,
    String? deptName,
    String? designation,
  }) {
    return EmployeeDetailsModel(
      profilePhoto: profilePhoto ?? this.profilePhoto,
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      countryCode: countryCode ?? this.countryCode,
      mobileNo: mobileNo ?? this.mobileNo,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      roleId: roleId ?? this.roleId,
      roleName: roleName ?? this.roleName,
      reportingTo: reportingTo ?? this.reportingTo,
      lastWorkingDay: lastWorkingDay ?? this.lastWorkingDay,
      deptName: deptName ?? this.deptName,
      designation: designation ?? this.designation,
    );
  }
}

///////////////////////////////////////////////////////////////

class ReportingTo {
  final int? userId;
  final String? firstName;
  final String? lastName;

  ReportingTo({this.userId, this.firstName, this.lastName});

  factory ReportingTo.fromJson(Map<String, dynamic> json) {
    return ReportingTo(userId: json["user_id"], firstName: json["first_name"], lastName: json["last_name"]);
  }

  Map<String, dynamic> toJson() => {"user_id": userId, "first_name": firstName, "last_name": lastName};

  ReportingTo copyWith({int? userId, String? firstName, String? lastName}) {
    return ReportingTo(
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }
}
