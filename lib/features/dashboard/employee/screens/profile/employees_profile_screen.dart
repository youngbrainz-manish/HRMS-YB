import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/router/app_router.dart';
import 'package:hrms_yb/core/theme/app_theme_provider.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/features/dashboard/employee/dashboard/employee_dashboard_provider.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/profile/employees_profile_provider.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/profile/info_tile.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/profile/section_dard.dart';
import 'package:hrms_yb/shared/common_method.dart';
import 'package:hrms_yb/shared/screens/hierarchy/hierarchy_screen.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:hrms_yb/shared/widgets/common_text.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:provider/provider.dart';

class EmployeesProfileScreen extends StatefulWidget {
  const EmployeesProfileScreen({super.key});

  @override
  State<EmployeesProfileScreen> createState() => _EmployeesProfileScreenState();
}

class _EmployeesProfileScreenState extends State<EmployeesProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EmployeesProfileProvider(context: context),
      child: Consumer<EmployeesProfileProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: SafeArea(child: _buildBody(provider: provider)),
          );
        },
      ),
    );
  }

  Widget _buildBody({required EmployeesProfileProvider provider}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: provider.isLoading
          ? CommonWidget.defaultLoader()
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: AppSize.verticalWidgetSpacing),
                  _buildProfileCard(provider: provider),

                  SizedBox(height: AppSize.verticalWidgetSpacing),

                  /// Edit Profile
                  CommonWidget.butoonWithImageAndText(
                    color: AppColors.primaryColor,
                    onTap: () async {
                      var data = await GoRouter.of(context).push(AppRouter.editProfileScreenRoute);
                      if (data == true) {
                        provider.getProfileData();
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.person_4_sharp, color: AppColors.whiteColor),
                        SizedBox(width: 10),
                        CommonTextWidget().buildButtonText(context: context, title: "Edit Profile"),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_rounded, size: 20, color: AppColors.whiteColor),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSize.verticalWidgetSpacing),

                  /// PERSONAL DETAILS
                  SectionCard(
                    title: "Personal Details",
                    children: [
                      InfoTile(
                        icon: Icons.person_outline,
                        bgColor: Colors.blue.shade50,
                        iconColor: Colors.blue,
                        title: "Full Name",
                        // value: provider.employee.name,
                        value: "${provider.employee?.firstName ?? ''} ${provider.employee?.lastName ?? ''}",
                      ),
                      InfoTile(
                        icon: Icons.call_outlined,
                        bgColor: Colors.green.shade50,
                        iconColor: Colors.green,
                        title: "Mobile",
                        value: provider.employee?.mobileNo ?? '',
                      ),
                      InfoTile(
                        icon: Icons.email_outlined,
                        bgColor: Colors.purple.shade50,
                        iconColor: Colors.purple,
                        title: "Email",
                        value: provider.employee?.email ?? '',
                      ),
                    ],
                  ),
                  SizedBox(height: AppSize.verticalWidgetSpacing),

                  /// EMPLOYMENT DETAILS
                  SectionCard(
                    title: "Employment Details",
                    children: [
                      InfoTile(
                        icon: Icons.apartment_outlined,
                        bgColor: Colors.orange.shade50,
                        iconColor: Colors.orange,
                        title: "Department",
                        value: provider.employee?.department?.deptName ?? '',
                      ),
                      InfoTile(
                        icon: Icons.work_outline,
                        bgColor: Colors.pink.shade50,
                        iconColor: Colors.pink,
                        title: "Designation",
                        value: provider.employee?.department?.designation ?? '',
                      ),
                      InfoTile(
                        icon: Icons.calendar_today_outlined,
                        bgColor: Colors.cyan.shade50,
                        iconColor: Colors.cyan,
                        title: "Joining Date",
                        value: provider.employee?.department?.joiningDate ?? '',
                      ),
                      InfoTile(
                        icon: Icons.badge_outlined,
                        bgColor: Colors.indigo.shade50,
                        iconColor: Colors.indigo,
                        title: "Employee Type",
                        value: provider.employee?.roles?.first.roleName == "HR"
                            ? "HR"
                            : provider.employee?.roles?.first.roleName == "Employee"
                            ? "Employee"
                            : '',
                      ),
                    ],
                  ),
                  SizedBox(height: AppSize.verticalWidgetSpacing),

                  /// Holiday List
                  CommonWidget.butoonWithImageAndText(
                    onTap: () async {
                      GoRouter.of(context).push(AppRouter.holidayScreenRoute);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.beach_access, color: AppColors.primaryColor),
                        SizedBox(width: 10),
                        Text("View All Holidays", style: AppTextStyle().titleTextStyle(context: context, fontSize: 14)),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_rounded, size: 20, color: AppColors.primaryColor),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSize.verticalWidgetSpacing),

                  /// UPDATE PIN
                  CommonWidget.butoonWithImageAndText(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HierarchyScreen()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.key_outlined, color: AppColors.primaryColor),
                        SizedBox(width: 10),
                        Text("Update Access PIN", style: AppTextStyle().titleTextStyle(context: context, fontSize: 14)),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_rounded, size: 20, color: AppColors.primaryColor),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSize.verticalWidgetSpacing),

                  /// UPDATE THEME
                  CommonWidget.butoonWithImageAndText(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          context.read<AppThemeProvider>().isDarkMode ? Icons.light_mode : Icons.dark_mode,
                          size: 26,
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(width: 10),
                        Text("Dark Theme", style: AppTextStyle().titleTextStyle(context: context, fontSize: 14)),
                        Spacer(),
                        Switch(
                          padding: EdgeInsets.all(0),
                          key: context.read<EmployeeDashboardProvider>().themeSwitchKey,
                          value: context.watch<AppThemeProvider>().isDarkMode,
                          onChanged: (v) {
                            context.read<EmployeeDashboardProvider>().toggleThemeMode();
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSize.verticalWidgetSpacing),

                  /// LOGOUT
                  CommonWidget.butoonWithImageAndText(
                    onTap: () async {
                      if (context.mounted) {
                        await CommonMethod().errageAllDataAndGotoLogin(context: context);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.logout, color: AppColors.primaryColor),
                        SizedBox(width: 10),
                        Text("Logout", style: AppTextStyle().titleTextStyle(context: context, fontSize: 14)),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_rounded, size: 20, color: AppColors.primaryColor),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSize.verticalWidgetSpacing),
                ],
              ),
            ),
    );
  }

  _buildProfileCard({required EmployeesProfileProvider provider}) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: context.watch<AppThemeProvider>().isDarkMode
                ? [AppColors.blackColor.withValues(alpha: 0.2), AppColors.whiteColor.withValues(alpha: 0.2)]
                : [AppColors.primaryColor.withValues(alpha: 0.6), AppColors.primaryColor],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: AppSize.verticalWidgetSpacing),
            CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.lightGrey,
              backgroundImage: (provider.employee?.profilePhoto ?? "").isNotEmpty
                  ? NetworkImage(provider.employee!.profilePhoto!)
                  : null,
              child: (provider.employee?.profilePhoto ?? "").isEmpty
                  ? const Icon(Icons.person_outline, size: 50, color: AppColors.whiteColor)
                  : SizedBox(),
            ),
            const SizedBox(width: AppSize.verticalWidgetSpacing),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  provider.employee?.firstName != null && provider.employee?.lastName != null
                      ? "${provider.employee!.firstName} ${provider.employee!.lastName}"
                      : 'N/A',
                  style: AppTextStyle().titleTextStyle(context: context, color: AppColors.whiteColor, fontSize: 20),
                ),
                const SizedBox(height: AppSize.verticalWidgetSpacing / 2),
                Text(
                  provider.employee?.firstName != null && provider.employee?.lastName != null
                      ? "${provider.employee!.department?.designation}"
                      : 'N/A',
                  style: AppTextStyle().subTitleTextStyle(context: context, color: AppColors.whiteColor),
                ),
                Text(
                  ("ID - EMP000${provider.employee?.empId ?? ''}").toString(),
                  style: AppTextStyle().lableTextStyle(context: context, color: AppColors.whiteColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
