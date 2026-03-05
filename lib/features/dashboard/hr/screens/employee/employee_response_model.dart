class EmployeesResponseModel {
  final bool? success;
  final String? message;
  final EmployeesData? employeesData;

  EmployeesResponseModel({this.success, this.message, this.employeesData});

  factory EmployeesResponseModel.fromJson(Map<String, dynamic> json) {
    return EmployeesResponseModel(
      success: json["success"],
      message: json["message"],
      employeesData: json["data"] != null
          ? EmployeesData.fromJson(json["data"])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": employeesData?.toJson(),
  };

  EmployeesResponseModel copyWith({
    bool? success,
    String? message,
    EmployeesData? employeesData,
  }) {
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
  final List<EmployeeModel>? employeeDetailsList;

  EmployeesData({
    this.totalRecords,
    this.currentPage,
    this.totalPages,
    this.employeeDetailsList,
  });

  factory EmployeesData.fromJson(Map<String, dynamic> json) {
    return EmployeesData(
      totalRecords: json["totalRecords"],
      currentPage: json["currentPage"],
      totalPages: json["totalPages"],
      employeeDetailsList: json["employees"] == null
          ? []
          : List<EmployeeModel>.from(
              json["employees"].map((x) => EmployeeModel.fromJson(x)),
            ),
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
    List<EmployeeModel>? employeeDetailsList,
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

class EmployeeModel {
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

  EmployeeModel({
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

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      profilePhoto: json["profile_photo"],
      userId: json["user_id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      countryCode: json["country_code"],
      mobileNo: json["mobile_no"],
      status: json["status"],
      createdAt: json["created_at"] != null
          ? DateTime.parse(json["created_at"])
          : null,
      roleId: json["role_id"],
      roleName: json["role_name"],
      reportingTo: json["reporting_to"] != null
          ? ReportingTo.fromJson(json["reporting_to"])
          : null,
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

  EmployeeModel copyWith({
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
    return EmployeeModel(
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
    return ReportingTo(
      userId: json["user_id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
    );
  }

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "first_name": firstName,
    "last_name": lastName,
  };

  ReportingTo copyWith({int? userId, String? firstName, String? lastName}) {
    return ReportingTo(
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }
}
/////=================================================

class EmployeeDetailsModel {
  String? profilePhoto;
  int? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? gender;
  int? age;
  String? countryCode;
  String? mobileNo;
  String? birthday;
  String? maritialStatus;
  String? bloodGroup;
  String? status;
  String? createdAt;
  String? updatedAt;
  Department? department;
  List<Address>? addresses;
  List<Education>? education;
  Role? role;

  EmployeeDetailsModel({
    this.profilePhoto,
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.gender,
    this.age,
    this.countryCode,
    this.mobileNo,
    this.birthday,
    this.maritialStatus,
    this.bloodGroup,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.department,
    this.addresses,
    this.education,
    this.role,
  });

  EmployeeDetailsModel copyWith({
    String? profilePhoto,
    int? userId,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? gender,
    int? age,
    String? countryCode,
    String? mobileNo,
    String? birthday,
    String? maritialStatus,
    String? bloodGroup,
    String? status,
    String? createdAt,
    String? updatedAt,
    Department? department,
    List<Address>? addresses,
    List<Education>? education,
    Role? role,
  }) {
    return EmployeeDetailsModel(
      profilePhoto: profilePhoto ?? this.profilePhoto,
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      countryCode: countryCode ?? this.countryCode,
      mobileNo: mobileNo ?? this.mobileNo,
      birthday: birthday ?? this.birthday,
      maritialStatus: maritialStatus ?? this.maritialStatus,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      department: department ?? this.department,
      addresses: addresses ?? this.addresses,
      education: education ?? this.education,
      role: role ?? this.role,
    );
  }

  factory EmployeeDetailsModel.fromJson(Map<String, dynamic> json) {
    return EmployeeDetailsModel(
      profilePhoto: json["profile_photo"],
      userId: json["user_id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      password: json["password"],
      gender: json["gender"],
      age: json["age"],
      countryCode: json["country_code"],
      mobileNo: json["mobile_no"],
      birthday: json["birthday"],
      maritialStatus: json["maritial_status"],
      bloodGroup: json["blood_group"],
      status: json["status"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      department: json["department"] == null
          ? null
          : Department.fromJson(json["department"]),
      addresses: json["addresses"] == null
          ? []
          : List<Address>.from(
              json["addresses"].map((x) => Address.fromJson(x)),
            ),
      education: json["education"] == null
          ? []
          : List<Education>.from(
              json["education"].map((x) => Education.fromJson(x)),
            ),
      role: json["role"] == null ? null : Role.fromJson(json["role"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "profile_photo": profilePhoto,
    "user_id": userId,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "password": password,
    "gender": gender,
    "age": age,
    "country_code": countryCode,
    "mobile_no": mobileNo,
    "birthday": birthday,
    "maritial_status": maritialStatus,
    "blood_group": bloodGroup,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "department": department?.toJson(),
    "addresses": addresses?.map((e) => e.toJson()).toList(),
    "education": education?.map((e) => e.toJson()).toList(),
    "role": role?.toJson(),
  };
}

class Department {
  int? userId;
  int? deptId;
  String? deptName;
  String? designation;
  String? joiningDate;
  int? salary;
  String? employementType;
  ReportingTo? reportingTo;
  String? lastWorkingDay;
  String? probationStart;
  String? probationEnd;
  int? userCategoryId;
  String? createdAt;
  String? updatedAt;
  String? categoryName;

  Department({
    this.userId,
    this.deptId,
    this.deptName,
    this.designation,
    this.joiningDate,
    this.salary,
    this.employementType,
    this.reportingTo,
    this.lastWorkingDay,
    this.probationStart,
    this.probationEnd,
    this.userCategoryId,
    this.createdAt,
    this.updatedAt,
    this.categoryName,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      userId: json["user_id"],
      deptId: json["dept_id"],
      deptName: json["dept_name"],
      designation: json["designation"],
      joiningDate: json["joining_date"],
      salary: json["salary"],
      employementType: json["employement_type"],
      reportingTo: json["reporting_to"] == null
          ? null
          : ReportingTo.fromJson(json["reporting_to"]),
      lastWorkingDay: json["last_working_day"],
      probationStart: json["probation_start"],
      probationEnd: json["probation_end"],
      userCategoryId: json["user_category_id"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      categoryName: json["category_name"],
    );
  }

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "dept_id": deptId,
    "dept_name": deptName,
    "designation": designation,
    "joining_date": joiningDate,
    "salary": salary,
    "employement_type": employementType,
    "reporting_to": reportingTo?.toJson(),
    "last_working_day": lastWorkingDay,
    "probation_start": probationStart,
    "probation_end": probationEnd,
    "user_category_id": userCategoryId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "category_name": categoryName,
  };
}

class Address {
  int? userId;
  int? addressId;
  String? addressType;
  String? street;
  String? city;
  String? state;
  String? pincode;
  String? emergencyContact;
  String? emergencyContactName;
  String? createdAt;
  String? updatedAt;

  Address({
    this.userId,
    this.addressId,
    this.addressType,
    this.street,
    this.city,
    this.state,
    this.pincode,
    this.emergencyContact,
    this.emergencyContactName,
    this.createdAt,
    this.updatedAt,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      userId: json["user_id"],
      addressId: json["address_id"],
      addressType: json["address_type"],
      street: json["street"],
      city: json["city"],
      state: json["state"],
      pincode: json["pincode"],
      emergencyContact: json["emergency_contact"],
      emergencyContactName: json["emergency_contact_name"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
    );
  }

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "address_id": addressId,
    "address_type": addressType,
    "street": street,
    "city": city,
    "state": state,
    "pincode": pincode,
    "emergency_contact": emergencyContact,
    "emergency_contact_name": emergencyContactName,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Education {
  int? userId;
  int? eduId;
  String? institutionName;
  String? typeOfInstitution;
  int? yearOfPassing;
  String? grade;
  String? degree;
  String? specialization;
  String? createdAt;
  String? updatedAt;

  Education({
    this.userId,
    this.eduId,
    this.institutionName,
    this.typeOfInstitution,
    this.yearOfPassing,
    this.grade,
    this.degree,
    this.specialization,
    this.createdAt,
    this.updatedAt,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      userId: json["user_id"],
      eduId: json["edu_id"],
      institutionName: json["institution_name"],
      typeOfInstitution: json["type_of_institution"],
      yearOfPassing: json["year_of_passing"],
      grade: json["grade"],
      degree: json["degree"],
      specialization: json["specialization"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
    );
  }

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "edu_id": eduId,
    "institution_name": institutionName,
    "type_of_institution": typeOfInstitution,
    "year_of_passing": yearOfPassing,
    "grade": grade,
    "degree": degree,
    "specialization": specialization,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Role {
  int? roleId;
  String? roleName;
  String? createdAt;
  String? updatedAt;

  Role({this.roleId, this.roleName, this.createdAt, this.updatedAt});

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      roleId: json["role_id"],
      roleName: json["role_name"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
    );
  }

  Map<String, dynamic> toJson() => {
    "role_id": roleId,
    "role_name": roleName,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
