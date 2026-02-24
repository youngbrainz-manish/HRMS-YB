import 'package:flutter/material.dart';
import 'package:hrms_yb/core/network/authentication_data.dart';
import 'package:hrms_yb/core/theme/app_theme_provider.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/features/dashboard/employee/dashboard/employee_dashboard_provider.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/home/employee_home_provider.dart';
import 'package:hrms_yb/shared/utils/app_extensions.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:hrms_yb/shared/widgets/common_button.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:hrms_yb/shared/widgets/punch_button.dart';
import 'package:provider/provider.dart';

class EmployeeHomeScreen extends StatelessWidget {
  const EmployeeHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EmployeeHomeProvider(context: context),
      child: Consumer<EmployeeHomeProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: SafeArea(
              child: _buildBody(context: context, provider: provider),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody({required BuildContext context, required EmployeeHomeProvider provider}) {
    bool isDarkMode = context.watch<AppThemeProvider>().isDarkMode;
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: isDarkMode ? AppColors.appScreenDark : AppColors.appScreenLight,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // _welcomeCardWidget(isDarkMode, context),
                    // SizedBox(height: AppSize().verticalWidgetSpacing),
                    Card(
                      margin: EdgeInsets.all(0),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Center(
                              child: PunchButton(
                                title: "09:00 AM",
                                lable: "PUNCH OUT",
                                titleColor: AppColors.errorColor,
                                icon: Icon(Icons.touch_app_outlined, size: 38, color: AppColors.errorColor),
                                isDarkMode: isDarkMode,
                                progress: 0.82,
                                onTap: () {},
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: CommonButton(
                                    title: "You are currently punch in",
                                    onTap: () {},
                                    color: AppColors.successSecondary.withValues(alpha: isDarkMode ? 0.2 : 0.3),
                                    borderColor: AppColors.successSecondary.withValues(alpha: isDarkMode ? 0.2 : 0.3),
                                    style: AppTextStyle().subTitleTextStyle(context: context),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  flex: 1,
                                  child: CommonButton(
                                    title: "View all",
                                    onTap: () {
                                      context.read<EmployeeDashboardProvider>().onItemTapped(1);
                                    },
                                    color: AppColors.successSecondary.withValues(alpha: isDarkMode ? 0.2 : 0.8),
                                    borderColor: AppColors.successPrimary.withValues(alpha: 0.3),
                                    style: AppTextStyle().subTitleTextStyle(context: context),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // SizedBox(height: AppSize().verticalWidgetSpacing),
                    // _todayAttendanceWidget(context, isDarkMode),
                    SizedBox(height: AppSize().verticalWidgetSpacing),
                    Text("Quick Actions", style: AppTextStyle().titleTextStyle(context: context)),
                    SizedBox(height: 4),
                    _quickActionWidget(context),
                    SizedBox(height: AppSize().verticalWidgetSpacing),
                    _leaveBalanceWidget(context, provider, isDarkMode),
                    SizedBox(height: AppSize().verticalWidgetSpacing),
                    _latestPaySlipWidget(context),
                    SizedBox(height: AppSize().verticalWidgetSpacing),
                    _latestNotificationWidget(context, provider),
                    SizedBox(height: AppSize().verticalWidgetSpacing),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ignore: unused_element
  Widget _customAppBar(BuildContext context, bool isDarkMode) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 60,
      width: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.darkGrey : AppColors.lightGrey,
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.white38 : Colors.black38,
            spreadRadius: 5,
            blurRadius: 15,
            offset: Offset(0, -10),
          ),
        ],
      ),
      child: Row(
        children: [
          Text("Home", style: context.textTheme.titleLarge?.medium),
          Spacer(),
          Icon(Icons.notifications_none_sharp, size: 28),
        ],
      ),
    );
  }

  // ignore: unused_element
  Widget _welcomeCardWidget(bool isDarkMode, BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      color: isDarkMode ? AppColors.darkGrey : AppColors.primaryColor,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome back,",
              style: AppTextStyle().subTitleTextStyle(context: context, color: AppColors.whiteColor),
            ),
            Text(
              "${AuthenticationData.userModel?.firstName} ${AuthenticationData.userModel?.lastName}",
              style: AppTextStyle().titleTextStyle(context: context, color: AppColors.whiteColor),
            ),
            Text(
              "EMP000${AuthenticationData.userModel?.empId}",
              style: AppTextStyle().subTitleTextStyle(context: context, color: AppColors.whiteColor),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: unused_element
  Widget _todayAttendanceWidget(BuildContext context, bool isDarkMode) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Today's Attendance", style: AppTextStyle().titleTextStyle(context: context)),
                Spacer(),
                CommonWidget().buildSvgImage(
                  path: "assets/svg-icons/dashboard-icons/attendance-icon.svg",
                  height: 20,
                  width: 20,
                  color: isDarkMode ? AppColors.lightGrey : AppColors.darkGrey,
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text("Punch In", style: AppTextStyle().subTitleTextStyle(context: context)),
                Spacer(),
                Text("09:12 AM", style: AppTextStyle().titleTextStyle(context: context)),
              ],
            ),
            SizedBox(height: 16),
            CommonButton(
              title: "You are currently clocked in",
              onTap: () {},
              color: AppColors.successSecondary.withValues(alpha: isDarkMode ? 0.2 : 0.3),
              borderColor: AppColors.successSecondary,
              style: AppTextStyle().subTitleTextStyle(context: context),
            ),
            SizedBox(height: 4),
          ],
        ),
      ),
    );
  }

  Widget _quickActionWidget(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            margin: EdgeInsets.all(0),
            child: Container(
              height: 80,
              margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.successSecondary.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.login_outlined, size: 26, color: AppColors.successPrimary),
                  ),
                  SizedBox(height: 8),
                  Text("Punch In/Out", style: AppTextStyle().subTitleTextStyle(context: context)),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Card(
            margin: EdgeInsets.all(0),
            child: Container(
              height: 80,
              margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryPurpleColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CommonWidget().buildSvgImage(
                      path: "assets/svg-icons/dashboard-icons/leave-icon.svg",
                      height: 26,
                      color: AppColors.primaryPurpleColor,
                    ),
                  ),
                  // SizedBox(height: 8),
                  Spacer(),
                  Text("Apply Leave", style: AppTextStyle().subTitleTextStyle(context: context)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _leaveBalanceWidget(BuildContext context, EmployeeHomeProvider provider, bool isDarkMode) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Leave Balance", style: AppTextStyle().titleTextStyle(context: context)),
            SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: provider.leaveDetailsList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 2.2,
              ),
              itemBuilder: (context, index) {
                Map<String, dynamic> leaveData = provider.leaveDetailsList[index];
                return Card(
                  margin: EdgeInsets.all(0),
                  child: Container(
                    padding: EdgeInsets.only(left: 12, top: 6, bottom: 6),
                    decoration: BoxDecoration(
                      color: AppColors.borderGrey.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          leaveData['name'],
                          style: AppTextStyle().subTitleTextStyle(context: context, color: AppColors.greyColor),
                        ),
                        SizedBox(height: 2),
                        Text("${leaveData['days']} days", style: AppTextStyle().titleTextStyle(context: context)),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: AppSize().verticalWidgetSpacing),
            CommonButton(
              title: "1 leave request pending approval",
              onTap: () {},
              color: AppColors.warningColor.withValues(alpha: isDarkMode ? 0.1 : 0.2),
              borderColor: AppColors.warningColor,
              style: AppTextStyle().subTitleTextStyle(context: context),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _latestPaySlipWidget(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Latest PaySlip", style: AppTextStyle().titleTextStyle(context: context)),
                Spacer(),
                CommonWidget().buildSvgImage(
                  path: "assets/svg-icons/dashboard-icons/pay-slip-icon.svg",
                  color: AppColors.textButtonColor,
                  height: 24,
                ),
              ],
            ),
            SizedBox(height: AppSize().verticalWidgetSpacing),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Latest PaySlip", style: AppTextStyle().subTitleTextStyle(context: context)),
                    SizedBox(height: 8),
                    Text("₹89,000", style: AppTextStyle().titleTextStyle(context: context)),
                  ],
                ),
                Spacer(),
                Text(
                  "View Details ->",
                  style: AppTextStyle().titleTextStyle(
                    context: context,
                    color: AppColors.textButtonColor,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _latestNotificationWidget(BuildContext context, EmployeeHomeProvider provider) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Latest Notification", style: AppTextStyle().titleTextStyle(context: context)),
                Spacer(),
                Text(
                  "View All",
                  style: AppTextStyle().titleTextStyle(context: context, color: AppColors.textButtonColor),
                ),
              ],
            ),
            SizedBox(height: 16),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: provider.notificationList.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> notificationData = provider.notificationList[index];
                return ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading: Container(
                    height: 14,
                    width: 14,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                  ),
                  title: Text(notificationData['title'], style: AppTextStyle().titleTextStyle(context: context)),
                  subtitle: Text(
                    notificationData['description'],
                    style: AppTextStyle().lableTextStyle(context: context),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Text(
                    notificationData['time'].toString(),
                    style: AppTextStyle().subTitleTextStyle(context: context),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
