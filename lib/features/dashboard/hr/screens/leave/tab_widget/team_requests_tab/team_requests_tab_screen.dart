import 'package:flutter/material.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/core/theme/app_theme_provider.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/leave/tab_widget/team_requests_tab/team_requests_tab_provider.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:hrms_yb/shared/widgets/common_button.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:provider/provider.dart';

class TeamRequestsTabScreen extends StatelessWidget {
  const TeamRequestsTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TeamRequestsTabProvider(context: context),
      child: Consumer<TeamRequestsTabProvider>(
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

  Widget _buildBody({
    required BuildContext context,
    required TeamRequestsTabProvider provider,
  }) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: provider.isLoading
          ? CommonWidget.defaultLoader()
          : ListView.builder(
              padding: const EdgeInsets.all(AppSize.verticalWidgetSpacing),
              itemCount: provider.teamLeaveDataModel.length,
              itemBuilder: (context, index) {
                final leave = provider.teamLeaveDataModel[index];
                final employee = leave.employee;
                final leaveType = leave.leavePlanType;

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Name + Status
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${employee?.firstName} ${employee?.firstName}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: getStatusColor(
                                  leave.status ?? '',
                                ).withValues(alpha: .1),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: getStatusColor(leave.status ?? ''),
                                ),
                              ),
                              child: Text(
                                leave.status.toString().toUpperCase(),
                                style: AppTextStyle().lableTextStyle(
                                  context: context,
                                  color: getStatusColor(leave.status ?? ''),
                                ),
                              ),
                            ),
                          ],
                        ),

                        /// Email
                        Text(
                          employee?.email ?? '',
                          style: TextStyle(color: Colors.grey[600]),
                        ),

                        const Divider(height: AppSize.verticalWidgetSpacing),

                        /// Leave Type
                        Row(
                          children: [
                            Text(
                              "Leave Type : ",
                              style: AppTextStyle().subTitleTextStyle(
                                context: context,
                              ),
                            ),

                            Text(
                              leaveType?.leaveType ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: AppSize.verticalWidgetSpacing / 3,
                        ),

                        /// Date Row
                        Row(
                          children: [
                            Text(
                              "From -> To  : ",
                              style: AppTextStyle().subTitleTextStyle(
                                context: context,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "${leave.startDate} → ${leave.endDate}",
                              style: AppTextStyle().titleTextStyle(
                                context: context,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: AppSize.verticalWidgetSpacing / 2,
                        ),

                        /// Total Days
                        Row(
                          children: [
                            // const Icon(Icons.timelapse, size: 18),
                            Text(
                              "Duration : ",
                              style: AppTextStyle().subTitleTextStyle(
                                context: context,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "${leave.totalDays} Days",
                              style: AppTextStyle().titleTextStyle(
                                context: context,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        /// Reason
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Reason : ",
                              style: AppTextStyle().subTitleTextStyle(
                                context: context,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                leave.reason ?? "-",
                                style: AppTextStyle().titleTextStyle(
                                  context: context,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppSize.verticalWidgetSpacing),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: CommonButton(
                                height: 40,
                                title: "Reject",
                                onTap: () {},
                                color:
                                    context.read<AppThemeProvider>().isDarkMode
                                    ? AppColors.darkGrey
                                    : AppColors.lightGrey,
                                titleColor: AppColors.primaryColor,
                                borderColor: AppColors.primaryColor,
                              ),
                            ),
                            SizedBox(width: AppSize.verticalWidgetSpacing),
                            Expanded(
                              child: CommonButton(
                                height: 40,
                                title: "Approve",
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "approved":
        return Colors.green;
      case "rejected":
        return Colors.red;
      default:
        return Colors.orange;
    }
  }
}
