import 'package:flutter/material.dart';

class HrEmployeeProvider extends ChangeNotifier {
  final BuildContext context;
  bool showFilters = false;

  String department = "All Departments";
  String designation = "All Designations";
  String status = "All Status";

  final employees = [
    Employee(name: "Rahul Sharma", code: "EMP001", department: "HR", designation: "Manager", isActive: false),
    Employee(name: "Priya Patel", code: "EMP002", department: "HR", designation: "Executive", isActive: true),
    Employee(name: "Amit Kumar", code: "EMP003", department: "Sales", designation: "Manager", isActive: true),
    Employee(name: "Sneha Reddy", code: "EMP004", department: "Sales", designation: "Executive", isActive: true),
    Employee(name: "Vikram Singh", code: "EMP005", department: "Accounts", designation: "Manager", isActive: true),
    Employee(name: "Anjali Verma", code: "EMP006", department: "Accounts", designation: "Associate", isActive: true),
  ];

  HrEmployeeProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  void _init() {
    notifyListeners();
  }

  void updateState() {
    notifyListeners();
  }
}

class Employee {
  final String name;
  final String code;
  final String department;
  final String designation;
  final bool isActive;

  Employee({
    required this.name,
    required this.code,
    required this.department,
    required this.designation,
    required this.isActive,
  });
}
