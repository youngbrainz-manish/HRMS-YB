import 'package:flutter/material.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';

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
        // color: AppColors.primaryColor,
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
        indicatorColor: isDarkMode ? AppColors.primaryColor : AppColors.darkGrey,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        labelTextStyle: labelTextStyle,
        destinations: [
          NavigationDestination(
            icon: CommonWidget().buildSvgImage(
              path: "assets/svg-icons/dashboard-icons/home-icon.svg",
              height: 25,
              width: 25,
              color: AppColors.secondaryDarkTextColor.withValues(alpha: 0.6),
            ),
            selectedIcon: CommonWidget().buildSvgImage(
              path: "assets/svg-icons/dashboard-icons/home-icon.svg",
              height: 25,
              width: 25,
              color: AppColors.whiteColor,
            ),
            label: "Home",
          ),
          NavigationDestination(
            icon: CommonWidget().buildSvgImage(
              path: "assets/svg-icons/dashboard-icons/attendance-icon.svg",
              height: 25,
              width: 25,
              color: AppColors.secondaryDarkTextColor.withValues(alpha: 0.6),
            ),
            selectedIcon: CommonWidget().buildSvgImage(
              path: "assets/svg-icons/dashboard-icons/attendance-icon.svg",
              height: 25,
              width: 25,
              color: AppColors.whiteColor,
            ),
            label: "Attendance",
          ),
          NavigationDestination(
            icon: CommonWidget().buildSvgImage(
              path: "assets/svg-icons/dashboard-icons/leave-icon.svg",
              height: 28,
              width: 28,
              color: AppColors.secondaryDarkTextColor.withValues(alpha: 0.6),
            ),
            selectedIcon: CommonWidget().buildSvgImage(
              path: "assets/svg-icons/dashboard-icons/leave-icon.svg",
              height: 28,
              width: 28,
              color: AppColors.whiteColor,
            ),
            label: "Leave",
          ),
          NavigationDestination(
            icon: CommonWidget().buildSvgImage(
              path: "assets/svg-icons/dashboard-icons/pay-slip-icon.svg",
              height: 25,
              width: 25,
              color: AppColors.secondaryDarkTextColor.withValues(alpha: 0.6),
            ),
            selectedIcon: CommonWidget().buildSvgImage(
              path: "assets/svg-icons/dashboard-icons/pay-slip-icon.svg",
              height: 25,
              width: 25,
              color: AppColors.whiteColor,
            ),
            label: "Payslip",
          ),
          NavigationDestination(
            icon: CommonWidget().buildSvgImage(
              path: "assets/svg-icons/dashboard-icons/profile-icon.svg",
              height: 22,
              width: 22,
              color: AppColors.secondaryDarkTextColor.withValues(alpha: 0.6),
            ),
            selectedIcon: CommonWidget().buildSvgImage(
              path: "assets/svg-icons/dashboard-icons/profile-icon.svg",
              height: 22,
              width: 22,
              color: AppColors.whiteColor,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
