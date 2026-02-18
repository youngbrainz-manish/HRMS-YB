import 'package:flutter/material.dart';

class AuditLogProvider extends ChangeNotifier {
  final BuildContext context;

  final List<AttendanceCorrection> dummyCorrections = [
    AttendanceCorrection(
      name: "Priya Patel",
      employeeId: "HR - EMP002",
      dateTime: "Dec 18, 2024 3:45 PM",
      title: "Corrected attendance for Amit Kumar",
      description: "Date: Dec 17 | Changed punch out from 18:15 to 19:30",
      reason: "Reason: Employee worked late for urgent client demo",
      accentColor: Colors.blue,
      bgColor: const Color(0xffE8F0FF),
    ),
    AttendanceCorrection(
      name: "Priya Patel",
      employeeId: "HR - EMP002",
      dateTime: "Dec 16, 2024 11:20 AM",
      title: "Corrected attendance for Sneha Reddy",
      description: "Date: Dec 15 | Added missing punch in at 09:00",
      reason: "Reason: Biometric system malfunction",
      accentColor: Colors.green,
      bgColor: const Color(0xffEAF6EC),
    ),
  ];

  AuditLogProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  void _init() {
    notifyListeners();
  }
}

class AttendanceCorrection {
  final String name;
  final String employeeId;
  final String dateTime;
  final String title;
  final String description;
  final String reason;
  final Color accentColor;
  final Color bgColor;

  AttendanceCorrection({
    required this.name,
    required this.employeeId,
    required this.dateTime,
    required this.title,
    required this.description,
    required this.reason,
    required this.accentColor,
    required this.bgColor,
  });
}
