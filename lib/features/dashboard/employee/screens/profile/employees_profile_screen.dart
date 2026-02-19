import 'package:flutter/material.dart';
import 'package:hrms_yb/core/theme/app_theme_provider.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/profile/employees_profile_provider.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/profile/info_tile.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/profile/section_dard.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/widgets/common_button.dart';
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
                    backgroundColor: context.watch<AppThemeProvider>().isDarkMode
                        ? AppColors.primaryColor
                        : AppColors.primaryColor,
                    child: Icon(Icons.edit),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildBody({required EmployeesProfileProvider provider}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileCard(provider: provider),

            SizedBox(height: AppSize().verticalWidgetSpacing),

            /// PERSONAL DETAILS
            SectionCard(
              title: "Personal Details",
              children: [
                InfoTile(
                  icon: Icons.person_outline,
                  bgColor: Colors.blue.shade50,
                  iconColor: Colors.blue,
                  title: "Full Name",
                  value: provider.employee.name,
                ),
                InfoTile(
                  icon: Icons.call_outlined,
                  bgColor: Colors.green.shade50,
                  iconColor: Colors.green,
                  title: "Mobile",
                  value: provider.employee.mobile,
                ),
                InfoTile(
                  icon: Icons.email_outlined,
                  bgColor: Colors.purple.shade50,
                  iconColor: Colors.purple,
                  title: "Email",
                  value: provider.employee.email,
                ),
              ],
            ),
            SizedBox(height: AppSize().verticalWidgetSpacing),

            /// EMPLOYMENT DETAILS
            SectionCard(
              title: "Employment Details",
              children: [
                InfoTile(
                  icon: Icons.apartment_outlined,
                  bgColor: Colors.orange.shade50,
                  iconColor: Colors.orange,
                  title: "Department",
                  value: provider.employee.department,
                ),
                InfoTile(
                  icon: Icons.work_outline,
                  bgColor: Colors.pink.shade50,
                  iconColor: Colors.pink,
                  title: "Designation",
                  value: provider.employee.designation,
                ),
                InfoTile(
                  icon: Icons.calendar_today_outlined,
                  bgColor: Colors.cyan.shade50,
                  iconColor: Colors.cyan,
                  title: "Joining Date",
                  value: provider.employee.joiningDate,
                ),
                InfoTile(
                  icon: Icons.badge_outlined,
                  bgColor: Colors.indigo.shade50,
                  iconColor: Colors.indigo,
                  title: "Employee Type",
                  value: provider.employee.employeeType,
                ),
              ],
            ),

            SizedBox(height: AppSize().verticalWidgetSpacing),

            /// UPDATE PIN
            CommonButton(
              icon: Icon(
                Icons.key_outlined,
                color: context.watch<AppThemeProvider>().isDarkMode ? AppColors.whiteColor : AppColors.blackColor,
              ),
              title: "Update Access PIN",
              onTap: () {},
              mainAxisAlignment: MainAxisAlignment.start,
              color: AppColors.transparantColor,
              borderColor: AppColors.primaryColor,
              titleColor: context.watch<AppThemeProvider>().isDarkMode ? AppColors.whiteColor : AppColors.blackColor,
            ),

            SizedBox(height: AppSize().verticalWidgetSpacing),

            /// LOGOUT
            CommonButton(
              icon: Icon(Icons.logout, color: AppColors.whiteColor),
              title: "Logout",
              onTap: () {},
              mainAxisAlignment: MainAxisAlignment.start,
            ),
            SizedBox(height: AppSize().verticalWidgetSpacing),
          ],
        ),
      ),
    );
  }

  _buildProfileCard({required EmployeesProfileProvider provider}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: context.watch<AppThemeProvider>().isDarkMode
              ? [AppColors.dartButtonColor.withValues(alpha: 0.6), AppColors.dartButtonColor]
              : [AppColors.primaryColor.withValues(alpha: 0.6), AppColors.primaryColor],
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 45,
            backgroundColor: Colors.white.withValues(alpha: .2),
            child: const Icon(Icons.person_outline, size: 45, color: Colors.white),
          ),
          const SizedBox(height: 12),
          Text(
            provider.employee.name,
            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(provider.employee.employeeId, style: const TextStyle(color: Colors.white70, fontSize: 16)),
        ],
      ),
    );
  }
}
