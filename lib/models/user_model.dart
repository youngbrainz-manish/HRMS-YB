// class UserModel {
//   final String? profilePhoto;
//   final int? empId;
//   final String? firstName;
//   final String? lastName;
//   final String? email;
//   final String? gender;
//   final int? age;
//   final String? mobileNo;
//   final String? birthday;
//   final String? status;
//   final Department? department;
//   final List<Address>? addresses;
//   final List<Education>? education;
//   final List<Role>? roles;
//   final int? roleId;

//   UserModel({
//     this.profilePhoto,
//     this.empId,
//     this.firstName,
//     this.lastName,
//     this.email,
//     this.gender,
//     this.age,
//     this.mobileNo,
//     this.birthday,
//     this.status,
//     this.department,
//     this.addresses,
//     this.education,
//     this.roles,
//     this.roleId,
//   });

//   UserModel copyWith({
//     String? profilePhoto,
//     int? empId,
//     String? firstName,
//     String? lastName,
//     String? email,
//     String? gender,
//     int? age,
//     String? mobileNo,
//     String? birthday,
//     String? status,
//     Department? department,
//     List<Address>? addresses,
//     List<Education>? education,
//     List<Role>? roles,
//     int? roleId,
//   }) {
//     return UserModel(
//       profilePhoto: profilePhoto ?? this.profilePhoto,
//       empId: empId ?? this.empId,
//       firstName: firstName ?? this.firstName,
//       lastName: lastName ?? this.lastName,
//       email: email ?? this.email,
//       gender: gender ?? this.gender,
//       age: age ?? this.age,
//       mobileNo: mobileNo ?? this.mobileNo,
//       birthday: birthday ?? this.birthday,
//       status: status ?? this.status,
//       department: department ?? this.department,
//       addresses: addresses ?? this.addresses,
//       education: education ?? this.education,
//       roles: roles ?? this.roles,
//       roleId: roleId ?? this.roleId,
//     );
//   }

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       profilePhoto: json['profile_photo'],
//       empId: json['emp_id'],
//       firstName: json['first_name'],
//       lastName: json['last_name'],
//       email: json['email'],
//       gender: json['gender'],
//       age: json['age'],
//       mobileNo: json['mobile_no'],
//       birthday: json['birthday'],
//       status: json['status'],
//       department: json['department'] != null ? Department.fromJson(json['department']) : null,
//       addresses: (json['addresses'] as List?)?.map((e) => Address.fromJson(e)).toList(),
//       education: (json['education'] as List?)?.map((e) => Education.fromJson(e)).toList(),
//       roles: (json['roles'] as List?)?.map((e) => Role.fromJson(e)).toList(),
//       roleId: json['role_id'],
//     );
//   }

//   Map<String, dynamic> toJson() => {
//     'profile_photo': profilePhoto,
//     'emp_id': empId,
//     'first_name': firstName,
//     'last_name': lastName,
//     'email': email,
//     'gender': gender,
//     'age': age,
//     'mobile_no': mobileNo,
//     'birthday': birthday,
//     'status': status,
//     'department': department?.toJson(),
//     'addresses': addresses?.map((e) => e.toJson()).toList(),
//     'education': education?.map((e) => e.toJson()).toList(),
//     'roles': roles?.map((e) => e.toJson()).toList(),
//     'role_id': roleId,
//   };
// }

// class Department {
//   final int? empId;
//   final int? deptId;
//   final String? deptName;
//   final String? designation;
//   final String? joiningDate;
//   final int? salary;
//   final ReportingTo? reportingTo;

//   Department({
//     this.empId,
//     this.deptId,
//     this.deptName,
//     this.designation,
//     this.joiningDate,
//     this.salary,
//     this.reportingTo,
//   });

//   Department copyWith({
//     int? empId,
//     int? deptId,
//     String? deptName,
//     String? designation,
//     String? joiningDate,
//     int? salary,
//     ReportingTo? reportingTo,
//   }) {
//     return Department(
//       empId: empId ?? this.empId,
//       deptId: deptId ?? this.deptId,
//       deptName: deptName ?? this.deptName,
//       designation: designation ?? this.designation,
//       joiningDate: joiningDate ?? this.joiningDate,
//       salary: salary ?? this.salary,
//       reportingTo: reportingTo ?? this.reportingTo,
//     );
//   }

//   factory Department.fromJson(Map<String, dynamic> json) {
//     return Department(
//       empId: json['emp_id'],
//       deptId: json['dept_id'],
//       deptName: json['dept_name'],
//       designation: json['designation'],
//       joiningDate: json['joining_date'],
//       salary: json['salary'],
//       reportingTo: json['reporting_to'] != null ? ReportingTo.fromJson(json['reporting_to']) : null,
//     );
//   }

//   Map<String, dynamic> toJson() => {
//     'emp_id': empId,
//     'dept_id': deptId,
//     'dept_name': deptName,
//     'designation': designation,
//     'joining_date': joiningDate,
//     'salary': salary,
//     'reporting_to': reportingTo?.toJson(),
//   };
// }

// class ReportingTo {
//   final int? empId;
//   final String? firstName;
//   final String? lastName;

//   ReportingTo({this.empId, this.firstName, this.lastName});

//   ReportingTo copyWith({int? empId, String? firstName, String? lastName}) {
//     return ReportingTo(
//       empId: empId ?? this.empId,
//       firstName: firstName ?? this.firstName,
//       lastName: lastName ?? this.lastName,
//     );
//   }

//   factory ReportingTo.fromJson(Map<String, dynamic> json) {
//     return ReportingTo(empId: json['emp_id'], firstName: json['first_name'], lastName: json['last_name']);
//   }

//   Map<String, dynamic> toJson() => {'emp_id': empId, 'first_name': firstName, 'last_name': lastName};
// }

// class Address {
//   final int? addressId;
//   final String? addressType;
//   final String? street;
//   final String? city;
//   final String? state;
//   final String? pincode;
//   final String? emergencyContact;
//   final String? emergencyContactName;

//   Address({
//     this.addressId,
//     this.addressType,
//     this.street,
//     this.city,
//     this.state,
//     this.pincode,
//     this.emergencyContact,
//     this.emergencyContactName,
//   });

//   Address copyWith({
//     int? addressId,
//     String? addressType,
//     String? street,
//     String? city,
//     String? state,
//     String? pincode,
//     String? emergencyContact,
//     String? emergencyContactName,
//   }) {
//     return Address(
//       addressId: addressId ?? this.addressId,
//       addressType: addressType ?? this.addressType,
//       street: street ?? this.street,
//       city: city ?? this.city,
//       state: state ?? this.state,
//       pincode: pincode ?? this.pincode,
//       emergencyContact: emergencyContact ?? this.emergencyContact,
//       emergencyContactName: emergencyContactName ?? this.emergencyContactName,
//     );
//   }

//   factory Address.fromJson(Map<String, dynamic> json) {
//     return Address(
//       addressId: json['address_id'],
//       addressType: json['address_type'],
//       street: json['street'],
//       city: json['city'],
//       state: json['state'],
//       pincode: json['pincode'],
//       emergencyContact: json['emergency_contact'],
//       emergencyContactName: json['emergency_contact_name'],
//     );
//   }

//   Map<String, dynamic> toJson() => {
//     'address_id': addressId,
//     'address_type': addressType,
//     'street': street,
//     'city': city,
//     'state': state,
//     'pincode': pincode,
//     'emergency_contact': emergencyContact,
//     'emergency_contact_name': emergencyContactName,
//   };
// }

// class Education {
//   final int? eduId;
//   final String? institutionName;
//   final String? degree;
//   final String? specialization;

//   Education({this.eduId, this.institutionName, this.degree, this.specialization});

//   Education copyWith({int? eduId, String? institutionName, String? degree, String? specialization}) {
//     return Education(
//       eduId: eduId ?? this.eduId,
//       institutionName: institutionName ?? this.institutionName,
//       degree: degree ?? this.degree,
//       specialization: specialization ?? this.specialization,
//     );
//   }

//   factory Education.fromJson(Map<String, dynamic> json) {
//     return Education(
//       eduId: json['edu_id'],
//       institutionName: json['institution_name'],
//       degree: json['degree'],
//       specialization: json['specialization'],
//     );
//   }

//   Map<String, dynamic> toJson() => {
//     'edu_id': eduId,
//     'institution_name': institutionName,
//     'degree': degree,
//     'specialization': specialization,
//   };
// }

// class Role {
//   final int? roleId;
//   final String? roleName;

//   Role({this.roleId, this.roleName});

//   Role copyWith({int? roleId, String? roleName}) {
//     return Role(roleId: roleId ?? this.roleId, roleName: roleName ?? this.roleName);
//   }

//   factory Role.fromJson(Map<String, dynamic> json) {
//     return Role(roleId: json['role_id'], roleName: json['role_name']);
//   }

//   Map<String, dynamic> toJson() => {'role_id': roleId, 'role_name': roleName};
// }

class UserModel {
  final String? profilePhoto;
  final int? userId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? gender;
  final int? age;
  final String? countryCode;
  final String? mobileNo;
  final String? birthday;
  final String? maritialStatus;
  final String? bloodGroup;
  final String? status;
  final Department? department;
  final List<Address>? addresses;
  final List<Education>? education;
  final Role? role;

  UserModel({
    this.profilePhoto,
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.age,
    this.countryCode,
    this.mobileNo,
    this.birthday,
    this.maritialStatus,
    this.bloodGroup,
    this.status,
    this.department,
    this.addresses,
    this.education,
    this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      profilePhoto: json['profile_photo'],
      userId: json['user_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      gender: json['gender'],
      age: json['age'],
      countryCode: json['country_code'],
      mobileNo: json['mobile_no'],
      birthday: json['birthday'],
      maritialStatus: json['maritial_status'],
      bloodGroup: json['blood_group'],
      status: json['status'],
      department: json['department'] != null ? Department.fromJson(json['department']) : null,
      addresses: (json['addresses'] as List?)?.map((e) => Address.fromJson(e)).toList(),
      education: (json['education'] as List?)?.map((e) => Education.fromJson(e)).toList(),
      role: json['role'] != null ? Role.fromJson(json['role']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'profile_photo': profilePhoto,
    'user_id': userId,
    'first_name': firstName,
    'last_name': lastName,
    'email': email,
    'gender': gender,
    'age': age,
    'country_code': countryCode,
    'mobile_no': mobileNo,
    'birthday': birthday,
    'maritial_status': maritialStatus,
    'blood_group': bloodGroup,
    'status': status,
    'department': department?.toJson(),
    'addresses': addresses?.map((e) => e.toJson()).toList(),
    'education': education?.map((e) => e.toJson()).toList(),
    'role': role?.toJson(),
  };
}

/* ---------------------------------------------------------- */
/* ---------------------- Department ------------------------ */
/* ---------------------------------------------------------- */

class Department {
  final int? userId;
  final int? deptId;
  final String? deptName;
  final String? designation;
  final String? joiningDate;
  final int? salary;
  final String? employmentType;
  final String? categoryName;
  final ReportingTo? reportingTo;

  Department({
    this.userId,
    this.deptId,
    this.deptName,
    this.designation,
    this.joiningDate,
    this.salary,
    this.employmentType,
    this.categoryName,
    this.reportingTo,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      userId: json['user_id'],
      deptId: json['dept_id'],
      deptName: json['dept_name'],
      designation: json['designation'],
      joiningDate: json['joining_date'],
      salary: json['salary'],
      employmentType: json['employement_type'],
      categoryName: json['category_name'],
      reportingTo: json['reporting_to'] != null ? ReportingTo.fromJson(json['reporting_to']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'dept_id': deptId,
    'dept_name': deptName,
    'designation': designation,
    'joining_date': joiningDate,
    'salary': salary,
    'employement_type': employmentType,
    'category_name': categoryName,
    'reporting_to': reportingTo?.toJson(),
  };
}

/* ---------------------------------------------------------- */
/* ---------------------- ReportingTo ----------------------- */
/* ---------------------------------------------------------- */

class ReportingTo {
  final int? userId;
  final String? firstName;
  final String? lastName;

  ReportingTo({this.userId, this.firstName, this.lastName});

  factory ReportingTo.fromJson(Map<String, dynamic> json) {
    return ReportingTo(userId: json['user_id'], firstName: json['first_name'], lastName: json['last_name']);
  }

  Map<String, dynamic> toJson() => {'user_id': userId, 'first_name': firstName, 'last_name': lastName};
}

/* ---------------------------------------------------------- */
/* ------------------------ Address ------------------------- */
/* ---------------------------------------------------------- */

class Address {
  final int? userId;
  final int? addressId;
  final String? addressType;
  final String? street;
  final String? city;
  final String? state;
  final String? pincode;
  final String? emergencyContact;
  final String? emergencyContactName;

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
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      userId: json['user_id'],
      addressId: json['address_id'],
      addressType: json['address_type'],
      street: json['street'],
      city: json['city'],
      state: json['state'],
      pincode: json['pincode'],
      emergencyContact: json['emergency_contact'],
      emergencyContactName: json['emergency_contact_name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'address_id': addressId,
    'address_type': addressType,
    'street': street,
    'city': city,
    'state': state,
    'pincode': pincode,
    'emergency_contact': emergencyContact,
    'emergency_contact_name': emergencyContactName,
  };
}

/* ---------------------------------------------------------- */
/* ----------------------- Education ------------------------ */
/* ---------------------------------------------------------- */

class Education {
  final int? eduId;
  final String? institutionName;
  final String? typeOfInstitution;
  final int? yearOfPassing;
  final String? grade;
  final String? degree;
  final String? specialization;

  Education({
    this.eduId,
    this.institutionName,
    this.typeOfInstitution,
    this.yearOfPassing,
    this.grade,
    this.degree,
    this.specialization,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      eduId: json['edu_id'],
      institutionName: json['institution_name'],
      typeOfInstitution: json['type_of_institution'],
      yearOfPassing: json['year_of_passing'],
      grade: json['grade'],
      degree: json['degree'],
      specialization: json['specialization'],
    );
  }

  Map<String, dynamic> toJson() => {
    'edu_id': eduId,
    'institution_name': institutionName,
    'type_of_institution': typeOfInstitution,
    'year_of_passing': yearOfPassing,
    'grade': grade,
    'degree': degree,
    'specialization': specialization,
  };
}

/* ---------------------------------------------------------- */
/* -------------------------- Role -------------------------- */
/* ---------------------------------------------------------- */

class Role {
  final int? roleId;
  final String? roleName;

  Role({this.roleId, this.roleName});

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(roleId: json['role_id'], roleName: json['role_name']);
  }

  Map<String, dynamic> toJson() => {'role_id': roleId, 'role_name': roleName};
}
