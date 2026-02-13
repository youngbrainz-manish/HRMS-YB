import 'package:flutter/material.dart';
import 'package:hrms_yb/core/theme/app_theme_provider.dart';
import 'package:hrms_yb/core/theme/app_theme_screen.dart';
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
      color: isDarkMode ? AppThemeScreen.appScreenDark : AppThemeScreen.appScreenLight,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    _welcomeCardWidget(isDarkMode, context),
                    SizedBox(height: AppSize().verticalWidgetSpacing),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Center(
                              child: PunchButton(
                                title: "09:00 AM",
                                lable: "PUNCH OUT",
                                titleColor: AppThemeScreen.errorColor,
                                icon: Icon(Icons.touch_app_outlined, size: 38, color: AppThemeScreen.errorColor),
                                isDarkMode: isDarkMode,
                                progress: 0.82,
                                onTap: () {
                                  print("Punch Clicked");
                                },
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
                                    color: AppThemeScreen.successSecondary.withValues(alpha: isDarkMode ? 0.2 : 0.3),
                                    borderColor: AppThemeScreen.successSecondary.withValues(
                                      alpha: isDarkMode ? 0.2 : 0.3,
                                    ),
                                    style: AppTextStyle().subTitleTextStyle(context: context),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  flex: 1,
                                  child: CommonButton(
                                    title: "View",
                                    onTap: () {},
                                    color: AppThemeScreen.successSecondary.withValues(alpha: isDarkMode ? 0.2 : 0.8),
                                    borderColor: AppThemeScreen.successPrimary.withValues(alpha: 0.3),
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
                    SizedBox(height: 8),
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
        color: isDarkMode ? AppThemeScreen.darkGrey : AppThemeScreen.lightGrey,
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

  Widget _welcomeCardWidget(bool isDarkMode, BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      color: isDarkMode ? AppThemeScreen.darkGrey : AppThemeScreen.primaryColor,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome back,",
              style: AppTextStyle().subTitleTextStyle(context: context, color: AppThemeScreen.whiteColor),
            ),
            Text(
              "Amit Kumar",
              style: AppTextStyle().titleTextStyle(context: context, color: AppThemeScreen.whiteColor),
            ),
            Text(
              "EMP003",
              style: AppTextStyle().subTitleTextStyle(context: context, color: AppThemeScreen.whiteColor),
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
                  color: isDarkMode ? AppThemeScreen.lightGrey : AppThemeScreen.darkGrey,
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
              color: AppThemeScreen.successSecondary.withValues(alpha: isDarkMode ? 0.2 : 0.3),
              borderColor: AppThemeScreen.successSecondary,
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
            child: Container(
              height: 90,
              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppThemeScreen.successSecondary.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.login_outlined, size: 28, color: AppThemeScreen.successPrimary),
                  ),
                  SizedBox(height: 16),
                  Text("Punch In/Out", style: AppTextStyle().subTitleTextStyle(context: context)),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Card(
            child: Container(
              height: 90,
              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppThemeScreen.secondaryPurpleColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CommonWidget().buildSvgImage(
                      path: "assets/svg-icons/dashboard-icons/leave-icon.svg",
                      height: 28,
                      color: AppThemeScreen.primaryPurpleColor,
                    ),
                  ),
                  SizedBox(height: 16),
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
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 2.2,
              ),
              itemBuilder: (context, index) {
                Map<String, dynamic> leaveData = provider.leaveDetailsList[index];
                return Container(
                  padding: EdgeInsets.only(left: 12, top: 6, bottom: 6),
                  decoration: BoxDecoration(
                    color: AppThemeScreen.borderGrey.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        leaveData['name'],
                        style: AppTextStyle().subTitleTextStyle(context: context, color: AppThemeScreen.greyColor),
                      ),
                      SizedBox(height: 2),
                      Text("${leaveData['days']} days", style: AppTextStyle().titleTextStyle(context: context)),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: AppSize().verticalWidgetSpacing),
            CommonButton(
              title: "1 leave request pending approval",
              onTap: () {},
              color: AppThemeScreen.warningColor.withValues(alpha: isDarkMode ? 0.1 : 0.2),
              borderColor: AppThemeScreen.warningColor,
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
                  color: AppThemeScreen.textButtonColor,
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
                    color: AppThemeScreen.textButtonColor,
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
                  style: AppTextStyle().titleTextStyle(context: context, color: AppThemeScreen.textButtonColor),
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
