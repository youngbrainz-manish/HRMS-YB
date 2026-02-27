import 'package:flutter/material.dart';
import 'package:hrms_yb/core/network/authentication_data.dart';
import 'package:hrms_yb/core/theme/app_theme_provider.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
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
            appBar: _buildAppBar(context: context, provider: employeeDashboardProvider),
            body: SafeArea(
              child: Column(children: [Expanded(child: widget.widget)]),
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
                        color: states.contains(WidgetState.selected) ? AppColors.whiteColor : AppColors.darkGrey,
                        fontWeight: states.contains(WidgetState.selected) ? FontWeight.bold : null,
                        fontSize: 13,
                      )
                    : AppTextStyle().subTitleTextStyle(
                        context: context,
                        color: states.contains(WidgetState.selected)
                            ? AppColors.primaryColor
                            : AppColors.secondaryDarkTextColor,
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

  AppBar _buildAppBar({required BuildContext context, required EmployeeDashboardProvider provider}) {
    return AppBar(
      leading: Container(
        padding: EdgeInsets.all(2),
        margin: EdgeInsets.only(bottom: 8, left: 8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.read<AppThemeProvider>().isDarkMode ? AppColors.blackColor : AppColors.whiteColor,
        ),
        child: Image.asset("assets/images/transparant_logo.png"),
      ),
      centerTitle: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "${AuthenticationData.userModel?.firstName} ${AuthenticationData.userModel?.lastName}",
            style: AppTextStyle().titleTextStyle(context: context, color: AppColors.whiteColor),
          ),
          Text(
            "Employee Id - EMP000${AuthenticationData.userModel?.userId}",
            style: AppTextStyle().lableTextStyle(context: context, color: AppColors.whiteColor),
          ),
        ],
      ),
      actions: [
        SizedBox(width: 8),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          margin: EdgeInsets.all(0),
          child: Padding(padding: EdgeInsets.all(6), child: Icon(Icons.notifications_none_sharp, size: 20)),
        ),
        SizedBox(width: 8),
      ],
    );
  }
}
