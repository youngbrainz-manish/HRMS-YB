import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/router/app_router.dart';

class HrDashboardProvider extends ChangeNotifier {
  final BuildContext context;
  int currentIndex = 0;
  List<String> titleNames = ["Home", "Employee", "Attendance", "Leave", "Payroll"];

  HrDashboardProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  void onItemTapped(int index) {
    switch (index) {
      case 0:
        GoRouter.of(rootNavigatorKey.currentState!.context).go(AppRouter.hrDashboardRoute);
      case 1:
        GoRouter.of(rootNavigatorKey.currentState!.context).go(AppRouter.hrEmployeeScreenRoute);
      case 2:
        GoRouter.of(rootNavigatorKey.currentState!.context).go(AppRouter.hrAttendanceScreenRoute);
      case 3:
        GoRouter.of(rootNavigatorKey.currentState!.context).go(AppRouter.hrLeaveScreenRoute);
      case 4:
        GoRouter.of(rootNavigatorKey.currentState!.context).go(AppRouter.hrPayrollScreenRoute);
    }
    currentIndex = index;
    notifyListeners();
  }
}
