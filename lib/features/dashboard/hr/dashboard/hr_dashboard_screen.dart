import 'package:flutter/material.dart';
import 'package:hrms_yb/core/theme/app_theme_provider.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/features/dashboard/hr/dashboard/hr_bottom_nav_bar.dart';
import 'package:hrms_yb/features/dashboard/hr/dashboard/hr_dashboard_provider.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:provider/provider.dart';

class HrDashboardScreen extends StatefulWidget {
  final Widget widget;
  const HrDashboardScreen({super.key, required this.widget});

  @override
  State<HrDashboardScreen> createState() => _HrDashboardScreenState();
}

class _HrDashboardScreenState extends State<HrDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HrDashboardProvider(context: context),
      child: Consumer<HrDashboardProvider>(
        builder: (context, hrDashboardProvider, child) {
          return Scaffold(
            appBar: _buildAppBar(context),
            body: SafeArea(
              child: Column(children: [Expanded(child: widget.widget)]),
            ),
            bottomNavigationBar: HrBottomNavBar(
              isDarkMode: context.watch<AppThemeProvider>().isDarkMode,
              currentIndex: hrDashboardProvider.currentIndex,
              onTap: (index) {
                hrDashboardProvider.onItemTapped(index);
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

  AppBar _buildAppBar(BuildContext context) {
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
            "Patel Manish Kumar",
            style: AppTextStyle().titleTextStyle(context: context, color: AppColors.whiteColor),
          ),
          Text(
            "Employee Id - EMP0002",
            style: AppTextStyle().lableTextStyle(context: context, color: AppColors.whiteColor),
          ),
        ],
      ),
      actions: [
        GestureDetector(
          onTap: () {
            context.read<AppThemeProvider>().toggleTheme();
          },
          child: Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.read<AppThemeProvider>().isDarkMode ? AppColors.blackColor : AppColors.whiteColor,
            ),
            child: Icon(context.read<AppThemeProvider>().isDarkMode ? Icons.light_mode : Icons.dark_mode, size: 21),
          ),
        ),
        SizedBox(width: 8),
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.read<AppThemeProvider>().isDarkMode ? AppColors.blackColor : AppColors.whiteColor,
          ),
          child: Icon(Icons.person, size: 20),
        ),
        SizedBox(width: 8),
      ],
    );
  }
}
