import 'package:flutter/material.dart';
import 'package:hrms_yb/core/theme/app_theme_provider.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/attendance/attendance_calendar.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/attendance/attendance_history_model.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/attendance/attendance_history_tile.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/attendance/employee_attendance_provider.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:hrms_yb/shared/widgets/action_card_button.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EmployeeAttendaceScreen extends StatelessWidget {
  const EmployeeAttendaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EmployeeAttendanceProvider(context: context),
      child: Consumer<EmployeeAttendanceProvider>(
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

  Widget _buildBody({required BuildContext context, required EmployeeAttendanceProvider provider}) {
    bool isDarkMode = context.watch<AppThemeProvider>().isDarkMode;
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _dateTimeWidget(isDarkMode: isDarkMode),
                    SizedBox(height: AppSize.verticalWidgetSpacing),
                    _punchInPunchOutWidget(isDarkMode, context),
                    SizedBox(height: AppSize.verticalWidgetSpacing),
                    _breakInbreakOutWidget(isDarkMode, context),
                    SizedBox(height: AppSize.verticalWidgetSpacing),
                    Card(
                      margin: EdgeInsets.all(0),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("Break Data", style: AppTextStyle().titleTextStyle(context: context)),
                                  Spacer(),
                                  Icon(Icons.coffee_rounded),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text("Break In        : 12:30 PM"),
                              Text("Break Out     : 01:00 PM"),
                              SizedBox(height: 4),
                              Text("Break In        : 02:30 PM"),
                              Text("Break Out     : 03:00 PM"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: AppSize.verticalWidgetSpacing),
                    _sessionDurationWidget(isDarkMode, context, provider),
                    SizedBox(height: AppSize.verticalWidgetSpacing),
                    _attendanceCalenderWidget(provider, isDarkMode),
                    SizedBox(height: AppSize.verticalWidgetSpacing),
                    _recentHistoryWidget(context: context, provider: provider, isDarkMode: isDarkMode),
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

  Widget _dateTimeWidget({required bool isDarkMode}) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        width: double.infinity,
        child: Column(
          children: [
            CommonWidget().buildSvgImage(
              path: "assets/svg-icons/dashboard-icons/attendance-icon.svg",
              color: isDarkMode ? AppColors.whiteColor : AppColors.textButtonColor,
              height: 24,
            ),
            SizedBox(height: 8),
            StreamBuilder<DateTime>(
              stream: Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now()),
              builder: (context, snapshot) {
                final time = snapshot.data ?? DateTime.now();
                final formattedTime = DateFormat('hh:mm a').format(time);
                return Column(
                  children: [
                    Text(formattedTime, style: AppTextStyle().titleTextStyle(context: context, fontSize: 22)),
                    SizedBox(height: 8),
                    Text(
                      DateFormat('EEEE, MMMM d, yyyy').format(DateTime.now()),
                      style: AppTextStyle().lableTextStyle(context: context),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _punchInPunchOutWidget(bool isDarkMode, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppActionCard(
            bgColor: AppColors.successSecondary,
            textColor: AppColors.successPrimary,
            title: "Punch In",
            isEnabled: false,
            onTap: () {},
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: AppActionCard(
            bgColor: isDarkMode ? AppColors.dartButtonColor : AppColors.lightButtonColor,
            textColor: AppColors.whiteColor,
            title: "Punch Out",
            isEnabled: true,
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget _sessionDurationWidget(bool isDarkMode, BuildContext context, EmployeeAttendanceProvider provider) {
    return Card(
      margin: EdgeInsets.all(0),
      color: isDarkMode ? AppColors.primaryDarkColor : AppColors.primaryColor,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Session Duration",
              style: AppTextStyle().titleTextStyle(context: context, color: AppColors.whiteColor),
            ),
            SizedBox(height: 16),
            StreamBuilder<DateTime>(
              stream: Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now()),
              builder: (context, snapshot) {
                final now = snapshot.data ?? DateTime.now();
                final difference = now.difference(provider.checkInTime);

                final hours = difference.inHours;
                final minutes = difference.inMinutes.remainder(60);
                final seconds = difference.inSeconds.remainder(60);

                final formatted =
                    "${hours.toString().padLeft(2, '0')}:"
                    "${minutes.toString().padLeft(2, '0')}:"
                    "${seconds.toString().padLeft(2, '0')}";

                return Text(
                  formatted,
                  style: AppTextStyle().titleTextStyle(context: context, fontSize: 28, color: AppColors.whiteColor),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _attendanceCalenderWidget(EmployeeAttendanceProvider provider, bool isDarkMode) {
    return Card(
      margin: EdgeInsets.all(0),
      child: AttendanceCalendar(attendanceList: provider.dummyAttendance, isDarkMode: isDarkMode),
    );
  }

  Widget _recentHistoryWidget({
    required BuildContext context,
    required EmployeeAttendanceProvider provider,
    required bool isDarkMode,
  }) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Recent History", style: AppTextStyle().titleTextStyle(context: context)),
            SizedBox(height: 16),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: provider.dummyHistory.length,
              itemBuilder: (context, index) {
                AttendanceHistoryModel model = provider.dummyHistory[index];
                return AttendanceHistoryTile(
                  model: model,
                  isLastItem: (index + 1) == provider.dummyHistory.length,
                  isDarkMode: isDarkMode,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _breakInbreakOutWidget(bool isDarkMode, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppActionCard(
            bgColor: AppColors.successSecondary,
            textColor: AppColors.successPrimary,
            title: "Break In",
            isEnabled: true,
            onTap: () {},
          ),
        ),
        SizedBox(width: AppSize.verticalWidgetSpacing),
        Expanded(
          child: AppActionCard(
            bgColor: isDarkMode ? AppColors.errorColor : AppColors.absentColor,
            textColor: AppColors.whiteColor,
            title: "Break Out",
            isEnabled: false,
            onTap: () {},
          ),
        ),
        SizedBox(height: AppSize.verticalWidgetSpacing),
      ],
    );
  }
}
