import 'package:flutter/material.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/attendance/attendance_history_model.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/attendance/attendance_model.dart';

class EmployeeAttendanceProvider extends ChangeNotifier {
  final BuildContext context;

  DateTime checkInTime = DateTime(2026, 2, 13, 9, 30, 0);
  final List<AttendanceModel> dummyAttendance = [
    AttendanceModel(date: DateTime(2025, 12, 1), status: AttendanceStatus.present),
    AttendanceModel(date: DateTime(2025, 12, 2), status: AttendanceStatus.present),
    AttendanceModel(date: DateTime(2025, 12, 6), status: AttendanceStatus.holiday),
    AttendanceModel(date: DateTime(2025, 12, 8), status: AttendanceStatus.holiday),
    AttendanceModel(date: DateTime(2025, 12, 12), status: AttendanceStatus.present),
    AttendanceModel(date: DateTime(2025, 12, 15), status: AttendanceStatus.holiday),
    AttendanceModel(date: DateTime(2025, 12, 18), status: AttendanceStatus.leave),
  ];

  final List<AttendanceHistoryModel> dummyHistory = [
    AttendanceHistoryModel(
      date: DateTime(2024, 12, 19),
      checkIn: DateTime(2024, 12, 19, 9, 5),
      status: AttendanceStatus.absent,
    ),
    AttendanceHistoryModel(
      date: DateTime(2024, 12, 18),
      checkIn: DateTime(2024, 12, 18, 9, 10),
      checkOut: DateTime(2024, 12, 18, 18, 15),
      status: AttendanceStatus.leave,
    ),
    AttendanceHistoryModel(
      date: DateTime(2024, 12, 17),
      checkIn: DateTime(2024, 12, 17, 9, 15),
      checkOut: DateTime(2024, 12, 17, 18, 20),
      status: AttendanceStatus.present,
    ),
    AttendanceHistoryModel(
      date: DateTime(2024, 12, 16),
      checkIn: DateTime(2024, 12, 16, 9, 20),
      checkOut: DateTime(2024, 12, 16, 18, 25),
      status: AttendanceStatus.present,
    ),
    AttendanceHistoryModel(date: DateTime(2024, 12, 15), status: AttendanceStatus.holiday),
    AttendanceHistoryModel(date: DateTime(2024, 12, 14), status: AttendanceStatus.holiday),
    AttendanceHistoryModel(
      date: DateTime(2024, 12, 13),
      checkIn: DateTime(2024, 12, 13, 9, 5),
      checkOut: DateTime(2024, 12, 13, 18, 10),
      status: AttendanceStatus.present,
    ),
    AttendanceHistoryModel(
      date: DateTime(2024, 12, 12),
      checkIn: DateTime(2024, 12, 12, 9, 25),
      checkOut: DateTime(2024, 12, 12, 18, 30),
      status: AttendanceStatus.present,
    ),
    AttendanceHistoryModel(
      date: DateTime(2024, 12, 11),
      checkIn: DateTime(2024, 12, 11, 9, 10),
      checkOut: DateTime(2024, 12, 11, 18, 15),
      status: AttendanceStatus.present,
    ),
    AttendanceHistoryModel(
      date: DateTime(2024, 12, 10),
      checkIn: DateTime(2024, 12, 10, 9, 15),
      checkOut: DateTime(2024, 12, 10, 18, 20),
      status: AttendanceStatus.present,
    ),
  ];

  EmployeeAttendanceProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  void _init() {
    notifyListeners();
  }
}
