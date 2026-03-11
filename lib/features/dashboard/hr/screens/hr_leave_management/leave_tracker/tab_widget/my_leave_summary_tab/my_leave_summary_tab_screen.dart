import 'package:flutter/material.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/core/theme/app_theme_provider.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/hr_leave_management/leave_tracker/models/leave_summary_model.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/hr_leave_management/leave_tracker/tab_widget/my_leave_summary_tab/my_leave_summary_tab_provider.dart';
import 'package:hrms_yb/shared/common_method.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:provider/provider.dart';

class MyLeaveSummaryTabScreen extends StatelessWidget {
  const MyLeaveSummaryTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyLeaveSummaryTabProvider(context: context),
      child: Consumer<MyLeaveSummaryTabProvider>(
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

  Widget _buildBody({required BuildContext context, required MyLeaveSummaryTabProvider provider}) {
    return provider.isLoading
        ? Center(child: CommonWidget.defaultLoader())
        : RefreshIndicator(
            onRefresh: () async {
              await provider.getLeaveSummary();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.verticalWidgetSpacing),
              child: provider.leaveSummaryModel == null
                  ? Center(child: Text("Something went wronge! Try again"))
                  : ListView(
                      children: [
                        SizedBox(height: AppSize.verticalWidgetSpacing),

                        _leaveBalanceGrid(
                          context: context,
                          leaveBalances: provider.leaveSummaryModel?.data?.leaveBalance ?? [],
                        ),
                        SizedBox(height: AppSize.verticalWidgetSpacing),
                        leaveSection(
                          context: context,
                          title: "Upcoming Leaves",
                          leaves: provider.leaveSummaryModel?.data?.upcomingLeaves ?? [],
                          provider: provider,
                        ),
                        const SizedBox(height: AppSize.verticalWidgetSpacing),

                        leaveSection(context: context, title: "Past Leaves", leaves: [], provider: provider),
                        const SizedBox(height: AppSize.verticalWidgetSpacing),
                      ],
                    ),
            ),
          );
  }

  Widget _leaveBalanceGrid({required List<LeaveBalance> leaveBalances, required BuildContext context}) {
    return Card(
      margin: EdgeInsets.all(0),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: AppSize.verticalWidgetSpacing),
        childrenPadding: const EdgeInsets.symmetric(horizontal: AppSize.verticalWidgetSpacing),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text("Leave Balance", style: AppTextStyle().titleTextStyle(context: context)),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.verticalWidgetSpacing),
            child: Column(
              children: [
                for (int i = 0; i < leaveBalances.length; i += 2) ...[
                  Row(
                    children: [
                      /// First Item
                      Expanded(
                        child: leaveCard(
                          title: leaveBalances[i].leaveType ?? "",
                          available: "${leaveBalances[i].balance ?? 0}",
                          used: "${leaveBalances[i].usedLeaves ?? 0}",
                          context: context,
                        ),
                      ),

                      /// Second Item OR Spacer
                      if (i + 1 < leaveBalances.length) ...[
                        const SizedBox(width: AppSize.verticalWidgetSpacing),
                        Expanded(
                          child: leaveCard(
                            title: leaveBalances[i + 1].leaveType ?? "",
                            available: "${leaveBalances[i + 1].balance ?? 0}",
                            used: "${leaveBalances[i + 1].usedLeaves ?? 0}",
                            context: context,
                          ),
                        ),
                      ],
                    ],
                  ),

                  const SizedBox(height: AppSize.verticalWidgetSpacing),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget leaveCard({
    required String title,
    required String available,
    required String used,
    required BuildContext context,
  }) {
    return Card(
      color: context.read<AppThemeProvider>().isDarkMode ? AppColors.darkGrey : AppColors.lightGrey,
      margin: EdgeInsets.all(0),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(radius: 14, child: Icon(Icons.assignment_outlined, size: 18)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyle().titleTextStyle(context: context, fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),

            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Available", style: AppTextStyle().subTitleTextStyle(context: context)),
                Text(
                  available,
                  style: AppTextStyle().subTitleTextStyle(context: context, color: AppColors.successPrimary),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Used", style: AppTextStyle().subTitleTextStyle(context: context)),
                Text(
                  used,
                  style: AppTextStyle().subTitleTextStyle(context: context, color: AppColors.errorColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget leaveSection({
    required BuildContext context,
    required String title,
    required List<UpcomingAndPastLeaveModel> leaves,
    required MyLeaveSummaryTabProvider provider,
  }) {
    return Card(
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: AppSize.verticalWidgetSpacing),
        childrenPadding: const EdgeInsets.symmetric(horizontal: AppSize.verticalWidgetSpacing),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(title, style: AppTextStyle().titleTextStyle(context: context)),
        children: [
          if (leaves.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSize.verticalWidgetSpacing * 1.5),
              child: Center(
                child: Text("No Data Found", style: AppTextStyle().lableTextStyle(context: context)),
              ),
            )
          else
            ...leaves.map((leave) => leaveApprovalCard(leave: leave, context: context, provider: provider)),
        ],
      ),
    );
  }

  Widget leaveApprovalCard({
    required UpcomingAndPastLeaveModel leave,
    required BuildContext context,
    required MyLeaveSummaryTabProvider provider,
  }) {
    return Card(
      elevation: 2,
      color: context.read<AppThemeProvider>().isDarkMode ? AppColors.darkGrey : AppColors.lightGrey,
      margin: EdgeInsets.only(bottom: AppSize.verticalWidgetSpacing),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(AppSize.verticalWidgetSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER
            const SizedBox(height: AppSize.verticalWidgetSpacing),

            /// LEAVE DETAILS
            _detailRow(context, "Leave Type", leave.leavePlanType?.leaveType ?? ''),
            _detailRow(context, "Start Date", leave.startDate ?? ''),
            _detailRow(context, "Days", (leave.totalDays ?? '').toString()),

            const SizedBox(height: AppSize.verticalWidgetSpacing / 1.5),

            /// REASON
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.holidayColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Reason: ${leave.reason ?? "Not provided"}",
                style: AppTextStyle().subTitleTextStyle(context: context),
              ),
            ),

            const SizedBox(height: AppSize.verticalWidgetSpacing / 1.5),

            /// HR NOTES
            if (leave.managerComment != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.successPrimary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Manager Notes: ${leave.managerComment}",
                  style: AppTextStyle().subTitleTextStyle(context: context),
                ),
              ),

            const SizedBox(height: AppSize.verticalWidgetSpacing / 2),

            /// APPLIED DATE
            Row(
              children: [
                Text(
                  "Applied on : ${CommonMethod.formatDate(leave.createdAt ?? "")}",
                  style: AppTextStyle().lableTextStyle(context: context),
                ),
                Spacer(),
                _statusChip(context: context, leave: leave),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// STATUS CHIP
  Widget _statusChip({required BuildContext context, required UpcomingAndPastLeaveModel leave}) {
    Color color;

    switch ((leave.status ?? '').toLowerCase()) {
      case "approved":
        color = AppColors.successPrimary;
        break;

      case "rejected":
        color = AppColors.errorColor;
        break;

      default:
        color = AppColors.warningColor;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Text((leave.status ?? '').toUpperCase(), style: AppTextStyle().lableTextStyle(context: context)),
    );
  }

  /// DETAIL ROW
  Widget _detailRow(BuildContext context, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyle().lableTextStyle(context: context)),
          Text(value, style: AppTextStyle().subTitleTextStyle(context: context)),
        ],
      ),
    );
  }
}
