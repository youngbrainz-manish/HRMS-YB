import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/network/authentication_data.dart';
import 'package:hrms_yb/core/router/app_router.dart';
import 'package:hrms_yb/core/theme/app_theme_provider.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/features/dashboard/hr/dashboard/hr_dashboard_provider.dart';
import 'package:hrms_yb/shared/common_method.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:provider/provider.dart';

class HrDashboardScreen extends StatefulWidget {
  final Widget widget;
  const HrDashboardScreen({super.key, required this.widget});

  @override
  State<HrDashboardScreen> createState() => _HrDashboardScreenState();
}

class _HrDashboardScreenState extends State<HrDashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey _themeSwitchKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HrDashboardProvider(context: context),
      child: Consumer<HrDashboardProvider>(
        builder: (context, hrDashboardProvider, child) {
          return Scaffold(
            key: _scaffoldKey,
            appBar: _buildAppBar(context: context, provider: hrDashboardProvider),
            body: SafeArea(
              child: Column(children: [Expanded(child: widget.widget)]),
            ),
            drawer: _buildAppDrawer(context: context, provider: hrDashboardProvider),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar({required BuildContext context, required HrDashboardProvider provider}) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.menu, color: AppColors.whiteColor),
        onPressed: () => _scaffoldKey.currentState?.openDrawer(),
      ),
      titleSpacing: 0,
      centerTitle: false,
      title: Text(
        provider.title,
        style: AppTextStyle().titleTextStyle(context: context, color: AppColors.whiteColor, fontSize: 18),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            GoRouter.of(context).push(AppRouter.notificationScreenRoute);
          },
          child: Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.read<AppThemeProvider>().isDarkMode ? AppColors.blackColor : AppColors.whiteColor,
            ),
            child: Icon(Icons.notifications_active, size: 20),
          ),
        ),
        SizedBox(width: 8),
      ],
    );
  }

  // New Method to build the Drawer
  Widget _buildAppDrawer({required BuildContext context, required HrDashboardProvider provider}) {
    return Drawer(
      backgroundColor: context.watch<AppThemeProvider>().isDarkMode ? AppColors.darkGrey : AppColors.whiteColor,
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            margin: EdgeInsets.all(0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: context.watch<AppThemeProvider>().isDarkMode ? AppColors.darkGrey : AppColors.primaryColor,
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40),
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: AppColors.whiteColor,
                      backgroundImage: NetworkImage(
                        AuthenticationData.userModel?.profilePhoto ??
                            "https://avatars.githubusercontent.com/u/105523679?v=4",
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "${AuthenticationData.userModel?.firstName} ${AuthenticationData.userModel?.lastName} ",
                      style: AppTextStyle().titleTextStyle(context: context, color: AppColors.whiteColor),
                    ),
                    Text(
                      "Employee Id - EMP000${AuthenticationData.userModel?.userId}",
                      style: AppTextStyle().lableTextStyle(context: context, color: AppColors.whiteColor, fontSize: 12),
                    ),
                    SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    margin: EdgeInsets.all(0),
                    child: ListTile(
                      leading: CommonWidget.buildSvgImage(
                        path: "assets/svg-icons/dashboard-icons/home-icon.svg",
                        height: 22,
                        width: 22,
                        color: AppColors.primaryColor,
                      ),
                      title: Text("Home"),
                      onTap: () {
                        Navigator.pop(context);
                        if (provider.title == "Home") return;
                        provider.changeTitle("Home");
                        GoRouter.of(context).push(AppRouter.hrDashboardRoute);
                      },
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      contentPadding: EdgeInsets.only(left: 16, right: 8),
                    ),
                  ),
                  SizedBox(height: 4),
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    margin: EdgeInsets.all(0),
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 16, right: 8),
                      leading: Icon(Icons.people, size: 22, color: AppColors.primaryColor),
                      title: Text("Employees"),
                      onTap: () {
                        Navigator.pop(context);
                        if (provider.title == "Employees") return;
                        provider.changeTitle("Employees");
                        GoRouter.of(context).push(AppRouter.hrEmployeeScreenRoute);
                      },
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    ),
                  ),
                  SizedBox(height: 4),
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    margin: EdgeInsets.all(0),
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 16, right: 8),
                      leading: CommonWidget.buildSvgImage(
                        path: "assets/svg-icons/dashboard-icons/profile-icon.svg",
                        height: 22,
                        width: 22,
                        color: AppColors.primaryColor,
                      ),
                      title: Text("Profile"),
                      onTap: () {
                        Navigator.pop(context);
                        if (provider.title == "Profile") return;
                        provider.changeTitle("Profile");
                        GoRouter.of(context).push(AppRouter.hrProfileScreenRoute);
                      },
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    ),
                  ),
                  SizedBox(height: 4),
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    margin: EdgeInsets.all(0),
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 16, right: 8),
                      leading: CommonWidget.buildSvgImage(
                        path: "assets/svg-icons/dashboard-icons/attendance-icon.svg",
                        height: 22,
                        width: 22,
                        color: AppColors.primaryColor,
                      ),
                      title: Text("Attendance"),
                      onTap: () {
                        Navigator.pop(context);
                        if (provider.title == "Attendance") return;
                        provider.changeTitle("Attendance");
                        GoRouter.of(context).push(AppRouter.hrAttendanceScreenRoute);
                      },
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    ),
                  ),
                  SizedBox(height: 4),
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    margin: EdgeInsets.all(0),
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 16, right: 8),
                      leading: CommonWidget.buildSvgImage(
                        path: "assets/svg-icons/dashboard-icons/leave-icon.svg",
                        height: 22,
                        width: 22,
                        color: AppColors.primaryColor,
                      ),
                      title: Text("Leave"),
                      onTap: () {
                        Navigator.pop(context);
                        if (provider.title == "Leave") return;
                        provider.changeTitle("Leave");
                        GoRouter.of(context).push(AppRouter.hrLeaveScreenRoute);
                      },
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    ),
                  ),
                  SizedBox(height: 4),
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    margin: EdgeInsets.all(0),
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 16, right: 8),
                      leading: CommonWidget.buildSvgImage(
                        path: "assets/svg-icons/dashboard-icons/pay-slip-icon.svg",
                        height: 22,
                        width: 22,
                        color: AppColors.primaryColor,
                      ),
                      title: Text("Payroll"),
                      onTap: () {
                        Navigator.pop(context);
                        if (provider.title == "Payroll") return;
                        provider.changeTitle("Payroll");
                        GoRouter.of(context).push(AppRouter.hrPayrollScreenRoute);
                      },
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    ),
                  ),
                  SizedBox(height: 4),
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    margin: EdgeInsets.all(0),
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 16, right: 8),
                      leading: CommonWidget.buildSvgImage(
                        path: "assets/svg-icons/dashboard-icons/leave-icon.svg",
                        height: 22,
                        width: 22,
                        color: AppColors.primaryColor,
                      ),
                      title: Text("Holidays"),
                      onTap: () {
                        Navigator.pop(context);
                        if (provider.title == "Holidays") return;
                        provider.changeTitle("Holidays");
                        GoRouter.of(context).push(AppRouter.hrHolidayScreenRoute);
                      },
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    ),
                  ),
                  SizedBox(height: 4),
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    margin: EdgeInsets.all(0),
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 16, right: 8),
                      leading: Icon(
                        context.read<AppThemeProvider>().isDarkMode ? Icons.light_mode : Icons.dark_mode,
                        size: 22,
                        color: AppColors.primaryColor,
                      ),
                      title: Text("Dark Theme"),
                      onTap: () {},
                      trailing: Switch(
                        key: _themeSwitchKey,
                        value: context.watch<AppThemeProvider>().isDarkMode,
                        onChanged: (v) {
                          final renderBox = _themeSwitchKey.currentContext?.findRenderObject() as RenderBox?;
                          final origin =
                              renderBox?.localToGlobal(Offset(renderBox.size.width / 2, renderBox.size.height / 2)) ??
                              Offset.zero;
                          context.read<AppThemeProvider>().toggleThemeWithAnimation(
                            origin: origin,
                            overlayState: Overlay.of(context),
                            devicePixelRatio: MediaQuery.of(context).devicePixelRatio,
                          );
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 4),
                  Card(
                    margin: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    child: ListTile(
                      leading: Icon(Icons.logout, color: Colors.red),
                      title: Text("Logout", style: TextStyle(color: Colors.red)),
                      onTap: () async {
                        if (context.mounted) {
                          await CommonMethod().errageAllDataAndGotoLogin(context: context);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
