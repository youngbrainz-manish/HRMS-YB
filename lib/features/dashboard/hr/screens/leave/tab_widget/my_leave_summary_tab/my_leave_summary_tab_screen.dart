import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/leave/hr_leave_provider.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/leave/models/leave_summary_model.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/leave/tab_widget/my_leave_summary_tab/my_leave_summary_tab_provider.dart';
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
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {},
              label: const Text("Apply Leave"),
              icon: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody({
    required BuildContext context,
    required MyLeaveSummaryTabProvider provider,
  }) {
    return provider.isLoading
        ? Center(child: CommonWidget.defaultLoader())
        : RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 1), () {
                if (kDebugMode) {
                  print("object route => Refreshed");
                }
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSize.verticalWidgetSpacing,
              ),
              child: provider.leaveSummaryModel == null
                  ? Center(child: Text("Something went wronge! Try again"))
                  : ListView(
                      children: [
                        SizedBox(height: AppSize.verticalWidgetSpacing),
                        _leaveBalanceGrid(
                          context: context,
                          leaveBalances:
                              provider.leaveSummaryModel?.data?.leaveBalance ??
                              [],
                        ),

                        leaveSection(
                          context: context,
                          title: "Upcoming Leaves",
                          leaves: [],
                        ),
                        const SizedBox(height: AppSize.verticalWidgetSpacing),

                        leaveSection(
                          context: context,
                          title: "Past Leaves",
                          leaves: [],
                        ),
                      ],
                    ),
            ),
          );
  }

  Widget _leaveBalanceGrid({
    required List<LeaveBalance> leaveBalances,
    required BuildContext context,
  }) {
    return Column(
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
    );
  }

  Widget leaveCard({
    required String title,
    required String available,
    required String used,
    required BuildContext context,
  }) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 14,
                  child: Icon(Icons.assignment_outlined, size: 18),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyle().titleTextStyle(
                      context: context,
                      fontSize: 14,
                    ),
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
                Text(
                  "Available",
                  style: AppTextStyle().subTitleTextStyle(context: context),
                ),
                Text(
                  available,
                  style: AppTextStyle().subTitleTextStyle(
                    context: context,
                    color: AppColors.successPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Used",
                  style: AppTextStyle().subTitleTextStyle(context: context),
                ),
                Text(
                  used,
                  style: AppTextStyle().subTitleTextStyle(
                    context: context,
                    color: AppColors.errorColor,
                  ),
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
    required List<LeaveRequest> leaves,
  }) {
    return Card(
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(
          horizontal: AppSize.verticalWidgetSpacing,
        ),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          title,
          style: AppTextStyle().titleTextStyle(context: context),
        ),
        children: [
          if (leaves.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppSize.verticalWidgetSpacing * 1.5,
              ),
              child: Center(
                child: Text(
                  "No Data Found",
                  style: AppTextStyle().lableTextStyle(context: context),
                ),
              ),
            )
          else
            ...leaves.map(
              (leave) => leaveApprovalCard(leave: leave, context: context),
            ),

          SizedBox(height: AppSize.verticalWidgetSpacing),
        ],
      ),
    );
  }

  Widget leaveApprovalCard({
    required LeaveRequest leave,
    required BuildContext context,
  }) {
    return Card(
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(AppSize.verticalWidgetSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// EMPLOYEE INFO
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      leave.employeeName,
                      style: AppTextStyle().titleTextStyle(context: context),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      leave.department,
                      style: AppTextStyle().lableTextStyle(context: context),
                    ),
                  ],
                ),

                /// STATUS CHIP
                _statusChip(context: context, leave: leave),
              ],
            ),

            const SizedBox(height: 14),

            /// LEAVE DETAILS
            _detailRow(context, "Leave Type", leave.leaveType),
            _detailRow(context, "Dates", leave.dates),
            _detailRow(context, "Days", leave.days),

            const SizedBox(height: 12),

            /// REASON
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.holidayColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Reason: ${leave.reason}",
                style: AppTextStyle().subTitleTextStyle(context: context),
              ),
            ),

            const SizedBox(height: 12),

            /// HR NOTES
            if (leave.hrNotes != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.successPrimary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "HR Notes: ${leave.hrNotes}",
                  style: AppTextStyle().subTitleTextStyle(context: context),
                ),
              ),

            const SizedBox(height: 10),

            /// APPLIED DATE
            Text(
              "Applied: ${leave.appliedDate}",
              style: AppTextStyle().lableTextStyle(context: context),
            ),
          ],
        ),
      ),
    );
  }

  /// STATUS CHIP
  Widget _statusChip({
    required BuildContext context,
    required LeaveRequest leave,
  }) {
    Color color;

    switch (leave.status.toLowerCase()) {
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        leave.status,
        style: AppTextStyle().lableTextStyle(context: context),
      ),
    );
  }

  /// DETAIL ROW
  Widget _detailRow(BuildContext context, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyle().subTitleTextStyle(context: context),
          ),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
