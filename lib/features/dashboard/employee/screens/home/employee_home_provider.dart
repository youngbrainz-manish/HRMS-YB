import 'package:flutter/material.dart';

class EmployeeHomeProvider extends ChangeNotifier {
  final BuildContext context;

  List<Map<String, dynamic>> leaveDetailsList = [
    {"name": "Casual Leave", "days": 10},
    {"name": "Sick Leave", "days": 1},
    {"name": "Earned Leave", "days": 4},
    {"name": "Maternity Leave", "days": 9},
  ];

  List<Map<String, dynamic>> notificationList = [
    {"title": "Pay Slip", "description": "Payslip for November 2024 is available.", "time": DateTime.thursday},
    {"title": "Attendance", "description": "Your attendance for Dec 18 has been marked.", "time": DateTime.friday},
    {"title": "Leave", "description": "Your leave requiest rejected.", "time": DateTime.monday},
    {"title": "Leave", "description": "Your leave requiest got accepted.", "time": DateTime.wednesday},
  ];

  EmployeeHomeProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  void _init() {
    notifyListeners();
  }
}
