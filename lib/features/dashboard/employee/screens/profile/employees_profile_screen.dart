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
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:hrms_yb/shared/widgets/common_button.dart';
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
            floatingActionButton: 1 == 1
                ? SizedBox()
                : FloatingActionButton.small(
                    onPressed: () {},
                    child: Icon(Icons.edit, color: AppColors.whiteColor),
                  ),
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
          ? CommonWidget().defaultLoader()
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: AppSize.verticalWidgetSpacing),
                  _buildProfileCard(provider: provider),

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

                  /// UPDATE PIN
                  CommonButton(
                    icon: Icon(Icons.key_outlined, color: AppColors.primaryColor),
                    title: "Update Access PIN",
                    onTap: () {},
                    mainAxisAlignment: MainAxisAlignment.start,
                    color: AppColors.transparantColor,
                    borderColor: AppColors.primaryColor,
                    titleColor: context.watch<AppThemeProvider>().isDarkMode
                        ? AppColors.whiteColor
                        : AppColors.blackColor,
                  ),

                  SizedBox(height: AppSize.verticalWidgetSpacing),

                  /// LOGOUT
                  CommonButton(
                    icon: Icon(Icons.logout, color: AppColors.whiteColor),
                    title: "Logout",
                    onTap: () async {
                      await CommonMethod().errageAllDataAndGotoLogin();
                      // ignore: use_build_context_synchronously
                      GoRouter.of(context).go(AppRouter.loginScreenRoute);
                    },
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
                  SizedBox(height: AppSize.verticalWidgetSpacing),

                  /// UPDATE THEME
                  Card(
                    margin: EdgeInsets.all(0),
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 8, right: 8, top: 0, bottom: 0),
                      leading: Icon(
                        context.read<AppThemeProvider>().isDarkMode ? Icons.light_mode : Icons.dark_mode,
                        size: 26,
                        color: AppColors.primaryColor,
                      ),
                      title: Text("Dark Theme"),
                      onTap: () {},
                      trailing: Switch(
                        padding: EdgeInsets.all(0),
                        key: context.read<EmployeeDashboardProvider>().themeSwitchKey,
                        value: context.watch<AppThemeProvider>().isDarkMode,
                        onChanged: (v) {
                          context.read<EmployeeDashboardProvider>().toggleThemeMode();
                        },
                      ),
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
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: context.watch<AppThemeProvider>().isDarkMode
                ? [AppColors.blackColor.withValues(alpha: 0.2), AppColors.whiteColor.withValues(alpha: 0.2)]
                : [AppColors.primaryColor.withValues(alpha: 0.6), AppColors.primaryColor],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white.withValues(alpha: .2),
              child: provider.employee?.profilePhoto != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        provider.employee!.profilePhoto!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.person_outline, size: 50, color: AppColors.whiteColor);
                        },
                      ),
                    )
                  : const Icon(Icons.person_outline, size: 50, color: AppColors.whiteColor),
            ),
            const SizedBox(height: 12),
            Text(
              provider.employee?.firstName != null && provider.employee?.lastName != null
                  ? "${provider.employee!.firstName} ${provider.employee!.lastName}"
                  : 'N/A',
              style: AppTextStyle().titleTextStyle(context: context, color: AppColors.whiteColor, fontSize: 20),
            ),
            const SizedBox(height: 4),
            Text(
              ("EMP000${provider.employee?.empId ?? ''}").toString(),
              style: AppTextStyle().subTitleTextStyle(context: context, color: AppColors.whiteColor, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
