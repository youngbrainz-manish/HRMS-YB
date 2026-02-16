import 'package:flutter/material.dart';
import 'package:hrms_yb/models/employee_model.dart';

class EmployeesProfileProvider extends ChangeNotifier {
  final BuildContext context;

  final employee = EmployeeModel(
    name: "Patel ManishKumar",
    employeeId: "EMP003",
    mobile: "9876543212",
    email: "manish@company.com",
    department: "App Developer",
    designation: "App Developer",
    joiningDate: "June 20, 2019",
    employeeType: "Permanent",
  );

  EmployeesProfileProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  void _init() {
    notifyListeners();
  }
}
