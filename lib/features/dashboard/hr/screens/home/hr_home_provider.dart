import 'package:flutter/material.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';

class HrHomeProvider extends ChangeNotifier {
  final BuildContext context;

  final stats = [
    DashboardStat(
      title: "Total Employees",
      value: "14",
      icon: Icons.groups_outlined,
      // gradient: [AppColors.textButtonColor, AppColors.textButtonColor.withValues(alpha: 0.8)],
      gradient: [AppColors.transparantColor, AppColors.transparantColor.withValues(alpha: 0.5)],
    ),
    DashboardStat(
      title: "New This Month",
      value: "0",
      icon: Icons.person_add_alt_1_outlined,
      // gradient: [AppColors.successPrimary, AppColors.successPrimary.withValues(alpha: 0.8)],
      gradient: [AppColors.transparantColor, AppColors.transparantColor.withValues(alpha: 0.5)],
    ),
    DashboardStat(
      title: "Pending Leaves",
      value: "2",
      icon: Icons.calendar_today_outlined,
      // gradient: [AppColors.warningColor, AppColors.errorColor.withValues(alpha: 0.8)],
      gradient: [AppColors.transparantColor, AppColors.transparantColor.withValues(alpha: 0.5)],
    ),
    DashboardStat(
      title: "Attendance Issues",
      value: "3",
      icon: Icons.error_outline,
      // gradient: [AppColors.errorColor, AppColors.errorColor.withValues(alpha: 0.8)],
      gradient: [AppColors.transparantColor, AppColors.transparantColor.withValues(alpha: 0.5)],
    ),
  ];

  final quickActions = [
    QuickAction(title: "Add Employee", icon: Icons.person_add_alt_1, color: AppColors.textButtonColor),
    QuickAction(title: "Review Leaves", icon: Icons.calendar_month, color: AppColors.successPrimary),
    QuickAction(title: "Attendance Corrections", icon: Icons.access_time, color: AppColors.warningColor),
    QuickAction(title: "Generate Payroll", icon: Icons.currency_rupee, color: AppColors.primaryPurpleColor),
  ];

  final activities = [
    Activity(title: "Amit Kumar applied for leave", time: "2 hours ago", dotColor: AppColors.textButtonColor),
    Activity(title: "Nikhil Joshi joined the company", time: "1 day ago", dotColor: AppColors.successPrimary),
    Activity(title: "Attendance correction requested", time: "2 days ago", dotColor: AppColors.warningColor),
  ];

  HrHomeProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  void _init() {
    notifyListeners();
  }
}

///========================================================================
class DashboardStat {
  final String title;
  final String value;
  final IconData icon;
  final List<Color> gradient;

  DashboardStat({required this.title, required this.value, required this.icon, required this.gradient});

  DashboardStat copyWith({String? title, String? value, IconData? icon, List<Color>? gradient}) {
    return DashboardStat(
      title: title ?? this.title,
      value: value ?? this.value,
      icon: icon ?? this.icon,
      gradient: gradient ?? this.gradient,
    );
  }
}

class QuickAction {
  final String title;
  final IconData icon;
  final Color color;

  QuickAction({required this.title, required this.icon, required this.color});
}

class Activity {
  final String title;
  final String time;
  final Color dotColor;

  Activity({required this.title, required this.time, required this.dotColor});
}
