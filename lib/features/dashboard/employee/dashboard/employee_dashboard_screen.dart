import 'package:flutter/material.dart';
import 'package:hrms_yb/core/theme/app_theme_screen.dart';
import 'package:hrms_yb/features/dashboard/employee/dashboard/app_bottom_nav_bar.dart';
import 'package:hrms_yb/features/dashboard/employee/dashboard/employee_dashboard_provider.dart';
import 'package:hrms_yb/shared/utils/theme_extension.dart';
import 'package:provider/provider.dart';

class EmployeeDashboardScreen extends StatefulWidget {
  final Widget widget;
  const EmployeeDashboardScreen({super.key, required this.widget});

  @override
  State<EmployeeDashboardScreen> createState() => _EmployeeDashboardScreenState();
}

class _EmployeeDashboardScreenState extends State<EmployeeDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EmployeeDashboardProvider(context: context),
      child: Consumer<EmployeeDashboardProvider>(
        builder: (context, employeeDashboardProvider, child) {
          return Scaffold(
            body: widget.widget,
            bottomNavigationBar: AppBottomNavBar(
              currentIndex: employeeDashboardProvider.currentIndex,
              onTap: (index) {
                employeeDashboardProvider.onItemTapped(index);
              },
              labelTextStyle: WidgetStateProperty.resolveWith(
                (states) => context.textStyle.bodyLarge?.copyWith(
                  fontSize: 14,
                  color: states.contains(WidgetState.selected) ? AppThemeScreen.primaryColor : AppThemeScreen.darkGrey,
                  fontWeight: states.contains(WidgetState.selected) ? FontWeight.bold : null,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
