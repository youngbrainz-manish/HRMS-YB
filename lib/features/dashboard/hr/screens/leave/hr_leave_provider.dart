import 'package:flutter/material.dart';

class HrLeaveProvider extends ChangeNotifier {
  final BuildContext context;

  int selectedTab = 0;

  final tabs = ["Pending", "Approved", "Rejected"];

  final List<LeaveRequest> dummyLeaves = [
    LeaveRequest(
      employeeName: "Amit Kumar",
      department: "Sales",
      leaveType: "Casual Leave",
      dates: "Dec 23 - Dec 24",
      days: "2 days",
      reason: "Family function",
      appliedDate: "Dec 18",
      status: "Pending",
      hrNotes: "Personal work",
    ),
    LeaveRequest(
      employeeName: "Anjali Verma",
      department: "Accounts",
      leaveType: "Casual Leave",
      dates: "Dec 26 - Dec 27",
      days: "2 days",
      reason: "Personal work",
      appliedDate: "Dec 19",
      status: "Rejected",
      hrNotes: "Year-end critical period, please reschedule",
    ),
    LeaveRequest(
      employeeName: "Manish Patel",
      department: "Mobile",
      leaveType: "Casual Leave",
      dates: "Dec 26 - Dec 27",
      days: "2 days",
      reason: "Personal work",
      appliedDate: "Dec 19",
      status: "Approved",
      hrNotes: "Approved",
    ),
  ];

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
