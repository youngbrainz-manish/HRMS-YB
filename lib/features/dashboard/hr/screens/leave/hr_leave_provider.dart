import 'package:flutter/material.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/leave/models/leave_summary_model.dart';

class HrLeaveProvider extends ChangeNotifier {
  final BuildContext context;
  LeaveSummaryModel? leaveSummaryModel;

  HrLeaveProvider({required this.context}) {
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

class LeaveRequest {
  final String employeeName;
  final String department;
  final String leaveType;
  final String dates;
  final String days;
  final String reason;
  final String appliedDate;
  final String status;
  final String? hrNotes;

  LeaveRequest({
    required this.employeeName,
    required this.department,
    required this.leaveType,
    required this.dates,
    required this.days,
    required this.reason,
    required this.appliedDate,
    required this.status,
    this.hrNotes,
  });
}
