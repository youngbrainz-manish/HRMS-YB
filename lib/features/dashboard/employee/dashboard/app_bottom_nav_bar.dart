import 'package:flutter/material.dart';
import 'package:hrms_yb/core/theme/app_theme_screen.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final WidgetStateProperty<TextStyle?>? labelTextStyle;
  final bool isDarkMode;
  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.labelTextStyle,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.white38 : Colors.black38,
            spreadRadius: 5,
            blurRadius: 15,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onTap,
        height: 75,
        backgroundColor: isDarkMode ? AppThemeScreen.darkGrey : AppThemeScreen.lightGrey,
        indicatorColor: Colors.transparent,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        labelTextStyle: labelTextStyle,
        destinations: [
          NavigationDestination(
            icon: CommonWidget().buildSvgImage(
              path: "assets/svg-icons/dashboard-icons/home-icon.svg",
              height: 25,
              width: 25,
              color: isDarkMode ? AppThemeScreen.lightGrey : AppThemeScreen.darkGrey,
            ),
            selectedIcon: CommonWidget().buildSvgImage(
              path: "assets/svg-icons/dashboard-icons/home-icon.svg",
              height: 25,
              width: 25,
              color: AppThemeScreen.primaryColor,
            ),
            label: "Home",
          ),
          NavigationDestination(
            icon: CommonWidget().buildSvgImage(
              path: "assets/svg-icons/dashboard-icons/attendance-icon.svg",
              height: 25,
              width: 25,
              color: isDarkMode ? AppThemeScreen.lightGrey : AppThemeScreen.darkGrey,
            ),
            selectedIcon: CommonWidget().buildSvgImage(
              path: "assets/svg-icons/dashboard-icons/attendance-icon.svg",
              height: 25,
              width: 25,
              color: AppThemeScreen.primaryColor,
            ),
            label: "Attendance",
          ),
          NavigationDestination(
            icon: CommonWidget().buildSvgImage(
              path: "assets/svg-icons/dashboard-icons/leave-icon.svg",
              height: 28,
              width: 28,
              color: isDarkMode ? AppThemeScreen.lightGrey : AppThemeScreen.darkGrey,
            ),
            selectedIcon: CommonWidget().buildSvgImage(
              path: "assets/svg-icons/dashboard-icons/leave-icon.svg",
              height: 28,
              width: 28,
              color: AppThemeScreen.primaryColor,
            ),
            label: "Leave",
          ),
          NavigationDestination(
            icon: CommonWidget().buildSvgImage(
              path: "assets/svg-icons/dashboard-icons/pay-slip-icon.svg",
              height: 25,
              width: 25,
              color: isDarkMode ? AppThemeScreen.lightGrey : AppThemeScreen.darkGrey,
            ),
            selectedIcon: CommonWidget().buildSvgImage(
              path: "assets/svg-icons/dashboard-icons/pay-slip-icon.svg",
              height: 25,
              width: 25,
              color: AppThemeScreen.primaryColor,
            ),
            label: "Payslip",
          ),
          NavigationDestination(
            icon: CommonWidget().buildSvgImage(
              path: "assets/svg-icons/dashboard-icons/profile-icon.svg",
              height: 22,
              width: 22,
              color: isDarkMode ? AppThemeScreen.lightGrey : AppThemeScreen.darkGrey,
            ),
            selectedIcon: CommonWidget().buildSvgImage(
              path: "assets/svg-icons/dashboard-icons/profile-icon.svg",
              height: 22,
              width: 22,
              color: AppThemeScreen.primaryColor,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
