class EmployeeModel {
  final String name;
  final String employeeId;
  final String mobile;
  final String email;
  final String department;
  final String designation;
  final String joiningDate;
  final String employeeType;

  const EmployeeModel({
    required this.name,
    required this.employeeId,
    required this.mobile,
    required this.email,
    required this.department,
    required this.designation,
    required this.joiningDate,
    required this.employeeType,
  });

  EmployeeModel copyWith({
    String? name,
    String? employeeId,
    String? mobile,
    String? email,
    String? department,
    String? designation,
    String? joiningDate,
    String? employeeType,
  }) {
    return EmployeeModel(
      name: name ?? this.name,
      employeeId: employeeId ?? this.employeeId,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      department: department ?? this.department,
      designation: designation ?? this.designation,
      joiningDate: joiningDate ?? this.joiningDate,
      employeeType: employeeType ?? this.employeeType,
    );
  }
}
