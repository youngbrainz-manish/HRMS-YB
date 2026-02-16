import 'package:flutter/material.dart';

class EmployeeLeaveProvider extends ChangeNotifier {
  final BuildContext context;

  List<Map<String, dynamic>> leaveDetailsList = [
    {"name": "Casual Leave", "days": 10},
    {"name": "Sick Leave", "days": 1},
    {"name": "Earned Leave", "days": 4},
    {"name": "Maternity Leave", "days": 9},
  ];

  EmployeeLeaveProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  void _init() {
    notifyListeners();
  }
}
