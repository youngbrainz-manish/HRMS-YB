import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/router/app_router.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/core/theme/app_theme_provider.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/leave_management/employee_leave_management_provider.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:provider/provider.dart';

class EmployeeLeaveScreen extends StatelessWidget {
  const EmployeeLeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EmployeeLeaveProvider(context: context),
      child: Consumer<EmployeeLeaveProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: SafeArea(
              child: _buildBody(provider: provider, context: context),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody({
    required EmployeeLeaveProvider provider,
    required BuildContext context,
  }) {
    return Container(
      padding: EdgeInsets.all(AppSize.verticalWidgetSpacing),
      height: MediaQuery.of(provider.context).size.height,
      width: MediaQuery.of(provider.context).size.width,
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.all(0),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                vertical: AppSize.verticalWidgetSpacing / 4,
                horizontal: AppSize.verticalWidgetSpacing / 1.5,
              ),
              leading: CircleAvatar(
                radius: 20,
                child: Icon(Icons.calendar_month),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "My Leave Management",
                    style: AppTextStyle().titleTextStyle(
                      context: provider.context,
                    ),
                  ),
                  SizedBox(height: AppSize.verticalWidgetSpacing / 4),
                ],
              ),
              subtitle: Text(
                "Check your leave balance, view leave plans, and manage your leave requests.",
                style: AppTextStyle().lableTextStyle(
                  context: context,
                  fontSize: 11,
                  color: AppColors.greyColor,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: GestureDetector(
                onTap: () async {
                  await GoRouter.of(
                    context,
                  ).push(AppRouter.myLeaveManagementScreenRoute);
                },
                child: Card(
                  color: context.read<AppThemeProvider>().isDarkMode
                      ? AppColors.darkGrey
                      : AppColors.lightGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(20),
                  ),
                  margin: EdgeInsets.all(0),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Icon(Icons.arrow_forward_ios_rounded, size: 18),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: AppSize.verticalWidgetSpacing),

          Card(
            margin: EdgeInsets.all(0),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                vertical: AppSize.verticalWidgetSpacing / 4,
                horizontal: AppSize.verticalWidgetSpacing / 1.5,
              ),
              leading: CircleAvatar(
                radius: 20,
                child: Icon(Icons.calendar_month),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "My Team's Leave Management",
                    style: AppTextStyle().titleTextStyle(
                      context: provider.context,
                    ),
                  ),
                  SizedBox(height: AppSize.verticalWidgetSpacing / 3),
                ],
              ),
              subtitle: Text(
                "Monitor your team’s leave plans and requests, and take actions like approve or reject.",
                style: AppTextStyle().lableTextStyle(
                  context: context,
                  fontSize: 11,
                  color: AppColors.greyColor,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: GestureDetector(
                onTap: () async {
                  await GoRouter.of(
                    context,
                  ).push(AppRouter.myTeamsLeaveManagementScreenRoute);
                },
                child: Card(
                  color: context.read<AppThemeProvider>().isDarkMode
                      ? AppColors.darkGrey
                      : AppColors.lightGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(20),
                  ),
                  margin: EdgeInsets.all(0),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Icon(Icons.arrow_forward_ios_rounded, size: 18),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
