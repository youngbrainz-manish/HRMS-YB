import 'package:flutter/material.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';

class HrAttendanceProvider extends ChangeNotifier {
  final BuildContext context;

  final List<AttendanceModel> attendanceList = [
    AttendanceModel(
      name: "Amit Kumar",
      department: "Sales",
      empId: "EMP003",
      status: "Present",
      punchIn: "09:05",
      punchOut: "-",
    ),
  ];

  TextEditingController dateController = TextEditingController();

  HrAttendanceProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  void _init() {
    DateTime dateTime = DateTime.now();
    dateController.text = "${dateTime.day}/${dateTime.month}/${dateTime.year}";
    notifyListeners();
  }

  Future<void> pickDate() async {
    final date = await showDatePicker(
      barrierColor: AppColors.borderGrey.withValues(alpha: 0.3),
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );

    if (date != null) {
      dateController.text = "${date.day}/${date.month}/${date.year}";
    }
    notifyListeners();
  }
}

class AttendanceModel {
  final String name;
  final String department;
  final String empId;
  final String status;
  final String punchIn;
  final String punchOut;

  AttendanceModel({
    required this.name,
    required this.department,
    required this.empId,
    required this.status,
    required this.punchIn,
    required this.punchOut,
  });
}
