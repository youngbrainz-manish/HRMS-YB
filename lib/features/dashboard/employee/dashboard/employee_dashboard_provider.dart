import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/router/app_router.dart';

class EmployeeDashboardProvider extends ChangeNotifier {
  final BuildContext context;
  int currentIndex = 0;
  List<String> titleNames = ["Home", "Attendance", "Leave", "PatSlip", "Profile"];

  EmployeeDashboardProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  void onItemTapped(int index) {
    switch (index) {
      case 0:
        GoRouter.of(rootNavigatorKey.currentState!.context).go(AppRouter.employeeshomeScreenRoute);
      case 1:
        GoRouter.of(rootNavigatorKey.currentState!.context).go(AppRouter.employeesAttendaceScreenRoute);
      case 2:
        GoRouter.of(rootNavigatorKey.currentState!.context).go(AppRouter.employeesLeaveScreenRoute);
      case 3:
        GoRouter.of(rootNavigatorKey.currentState!.context).go(AppRouter.employeesPaySlipScreenRoute);
      case 4:
        GoRouter.of(rootNavigatorKey.currentState!.context).go(AppRouter.employeesProfileScreenRoute);
    }
    currentIndex = index;
    notifyListeners();
  }
}
