import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:hrms_yb/core/theme/app_theme_screen.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final WidgetStateProperty<TextStyle?>? labelTextStyle;
  const AppBottomNavBar({super.key, required this.currentIndex, required this.onTap, this.labelTextStyle});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      height: 70,
      backgroundColor: Colors.white,
      // indicatorColor: AppTheme.primaryColor.withValues(alpha: 0.12),
      indicatorColor: Colors.transparent,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      labelTextStyle: labelTextStyle,
      destinations: [
        NavigationDestination(
          icon: SvgPicture.asset("assets/svg-icons/dashboard-icons/home-icon.svg", width: 25, height: 25),
          selectedIcon: SvgPicture.asset(
            "assets/svg-icons/dashboard-icons/home-icon.svg",
            width: 25,
            height: 25,
            color: AppThemeScreen.primaryColor, // ignore: deprecated_member_use
          ),
          label: "Home",
        ),
        NavigationDestination(
          icon: SvgPicture.asset("assets/svg-icons/dashboard-icons/attendance-icon.svg", width: 25, height: 25),
          selectedIcon: SvgPicture.asset(
            "assets/svg-icons/dashboard-icons/attendance-icon.svg",
            width: 25,
            height: 25,
            color: AppThemeScreen.primaryColor, // ignore: deprecated_member_use
          ),
          label: "Attendance",
        ),
        NavigationDestination(
          icon: SvgPicture.asset("assets/svg-icons/dashboard-icons/leave-icon.svg", width: 28, height: 28),
          selectedIcon: SvgPicture.asset(
            "assets/svg-icons/dashboard-icons/leave-icon.svg",
            width: 28,
            height: 28,
            color: AppThemeScreen.primaryColor, // ignore: deprecated_member_use
          ),
          label: "Leave",
        ),
        NavigationDestination(
          icon: SvgPicture.asset("assets/svg-icons/dashboard-icons/pay-slip-icon.svg", width: 25, height: 25),
          selectedIcon: SvgPicture.asset(
            "assets/svg-icons/dashboard-icons/pay-slip-icon.svg",
            width: 25,
            height: 25,
            color: AppThemeScreen.primaryColor, // ignore: deprecated_member_use
          ),
          label: "Payslip",
        ),
        NavigationDestination(
          icon: SvgPicture.asset("assets/svg-icons/dashboard-icons/profile-icon.svg", width: 22, height: 22),
          selectedIcon: SvgPicture.asset(
            "assets/svg-icons/dashboard-icons/profile-icon.svg",
            width: 22,
            height: 22,
            color: AppThemeScreen.primaryColor, // ignore: deprecated_member_use
          ),
          label: "Profile",
        ),
      ],
    );
  }
}
