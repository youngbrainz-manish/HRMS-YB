import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/router/app_router.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/core/theme/app_theme_provider.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/leave_management/my_leave_management/my_leave_management_provider.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/hr_leave_management/leave_plans/my_leave_pan/my_leave_plan_screen.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/hr_leave_management/leave_tracker/models/leave_summary_model.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/hr_leave_management/leave_tracker/tab_widget/my_leave_requests_tab/my_leave_requests_tab_screen.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/hr_leave_management/leave_tracker/tab_widget/my_leave_summary_tab/my_leave_summary_tab_screen.dart';
import 'package:hrms_yb/shared/common_method.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:provider/provider.dart';

class MyLeaveManagementScreen extends StatelessWidget {
  const MyLeaveManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyLeaveManagementProvider(context: context),
      child: Consumer<MyLeaveManagementProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              leading: CommonWidget.backButton(onTap: () => GoRouter.of(context).pop()),
              title: Text("My Leave Management"),
              actions: [
                GestureDetector(
                  onTap: () async {
                    var data = await GoRouter.of(context).push(AppRouter.addUpdateLeaveScreenRoute);
                    if (data == true) {
                      provider.refreshPage();
                    }
                  },
                  child: Card(
                    margin: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(20)),
                    child: Icon(Icons.add_circle_outlined, size: 30),
                  ),
                ),
                SizedBox(width: AppSize.verticalWidgetSpacing / 2),
              ],
            ),
            body: SafeArea(
              child: _buildBody(context: context, provider: provider),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody({required BuildContext context, required MyLeaveManagementProvider provider}) {
    return provider.isLoading
        ? CommonWidget.defaultLoader()
        : DefaultTabController(
            length: 3,
            child: Column(
              children: [
                TabBar(
                  labelStyle: AppTextStyle().titleTextStyle(context: context, color: AppColors.primaryColor),
                  unselectedLabelStyle: AppTextStyle().subTitleTextStyle(context: context),
                  tabAlignment: TabAlignment.center,
                  isScrollable: true,
                  tabs: [
                    Tab(text: "My Leave Summary"),
                    Tab(text: "My Leave Request"),
                    Tab(text: "My Leave Plans"),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      MyLeaveSummaryTabScreen(),
                      MyLeaveRequestsTabScreen(hideFloatingButton: true),
                      // _myLeavePlans(provider: provider, context: context),
                      MyLeavePlanScreen(),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  /// Leave Card
  Widget leaveCard({
    required String title,
    required String available,
    required String used,
    required BuildContext context,
  }) {
    return Card(
      color: context.read<AppThemeProvider>().isDarkMode ? AppColors.darkGrey : AppColors.lightGrey,
      margin: EdgeInsets.zero,
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
            const Spacer(),
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
    required MyLeaveManagementProvider provider,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: AppSize.verticalWidgetSpacing, right: AppSize.verticalWidgetSpacing),
      child: Card(
        margin: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: AppSize.verticalWidgetSpacing),
          childrenPadding: const EdgeInsets.symmetric(horizontal: 12),
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

            SizedBox(height: AppSize.verticalWidgetSpacing),
          ],
        ),
      ),
    );
  }

  Widget leaveApprovalCard({
    required UpcomingAndPastLeaveModel leave,
    required BuildContext context,
    required MyLeaveManagementProvider provider,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 2,
        shadowColor: AppColors.greyColor,
        color: context.read<AppThemeProvider>().isDarkMode ? AppColors.darkGrey : AppColors.lightGrey,
        margin: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(AppSize.verticalWidgetSpacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// LEAVE DETAILS
              _detailRow(context, "Leave Type", leave.leavePlanType?.leaveType ?? ''),
              _detailRow(context, "Start Date", leave.startDate ?? ''),
              _detailRow(context, "Days", (leave.totalDays ?? '').toString()),

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
                  "Reason: ${leave.reason ?? "Not provided"}",
                  style: AppTextStyle().subTitleTextStyle(context: context),
                ),
              ),

              const SizedBox(height: AppSize.verticalWidgetSpacing),

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

              const SizedBox(height: 10),

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
