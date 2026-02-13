import 'package:flutter/material.dart';
import 'package:hrms_yb/core/theme/app_theme_provider.dart';
import 'package:hrms_yb/core/theme/app_theme_screen.dart';
import 'package:hrms_yb/features/dashboard/employee/dashboard/app_bottom_nav_bar.dart';
import 'package:hrms_yb/features/dashboard/employee/dashboard/employee_dashboard_provider.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
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
            body: SafeArea(
              child: Column(
                children: [
                  // Container(
                  //   padding: EdgeInsets.only(left: 16, top: 0, right: 16, bottom: 6),
                  //   height: 65,
                  //   width: MediaQuery.of(context).size.height,
                  //   decoration: BoxDecoration(
                  //     color: context.watch<AppThemeProvider>().isDarkMode
                  //         ? AppThemeScreen.darkGrey
                  //         : AppThemeScreen.lightGrey,
                  //     border: Border(bottom: BorderSide(color: AppThemeScreen.borderGrey)),
                  //   ),
                  //   child: ListTile(
                  //     contentPadding: EdgeInsets.all(0),
                  //     title: Text("Patel Manish Kumar", style: context.textStyle.titleMedium),
                  //     subtitle: Text("Employee Id - EMP0003", style: context.textStyle.bodySmall),
                  //     trailing: Icon(Icons.notifications_none_sharp, size: 28),
                  //   ),
                  // ),
                  Expanded(child: widget.widget),
                ],
              ),
            ),
            bottomNavigationBar: AppBottomNavBar(
              isDarkMode: context.watch<AppThemeProvider>().isDarkMode,
              currentIndex: employeeDashboardProvider.currentIndex,
              onTap: (index) {
                employeeDashboardProvider.onItemTapped(index);
              },
              labelTextStyle: WidgetStateProperty.resolveWith(
                (states) => states.contains(WidgetState.selected)
                    ? AppTextStyle().subTitleTextStyle(
                        context: context,
                        color: states.contains(WidgetState.selected)
                            ? AppThemeScreen.primaryColor
                            : AppThemeScreen.darkGrey,
                        fontWeight: states.contains(WidgetState.selected) ? FontWeight.bold : null,
                        fontSize: 13,
                      )
                    : AppTextStyle().subTitleTextStyle(
                        context: context,
                        color: states.contains(WidgetState.selected)
                            ? AppThemeScreen.primaryColor
                            : context.watch<AppThemeProvider>().isDarkMode
                            ? AppThemeScreen.lightGrey
                            : AppThemeScreen.darkGrey,
                        fontWeight: states.contains(WidgetState.selected) ? FontWeight.bold : null,
                        fontSize: 12,
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
