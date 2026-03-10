import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/router/app_router.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/core/theme/app_theme_provider.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/leave_management/my_leave_management/my_leave_management_provider.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/leave/models/leave_plan_data_model.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/leave/models/leave_summary_model.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/leave/tab_widget/my_leave_requests_tab/my_leave_requests_tab_screen.dart';
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
              leading: CommonWidget.backButton(
                onTap: () => GoRouter.of(context).pop(),
              ),
              title: Text("My Leave Management"),
              actions: [
                GestureDetector(
                  onTap: () async {
                    var data = await GoRouter.of(
                      context,
                    ).push(AppRouter.addUpdateLeaveScreenRoute);
                    if (data == true) {
                      provider.refreshPage();
                    }
                  },
                  child: Card(
                    margin: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(20),
                    ),
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

  Widget _buildBody({
    required BuildContext context,
    required MyLeaveManagementProvider provider,
  }) {
    return provider.isLoading
        ? CommonWidget.defaultLoader()
        : DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(text: "My Leave Summary"),
                    Tab(text: "My Leave Plans"),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _myLeaveSummary(provider: provider, context: context),
                      _myLeavePlans(provider: provider, context: context),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  /// Leave Balance Grid
  Widget _leaveBalanceGrid({
    required List<LeaveBalance> leaveBalances,
    required BuildContext context,
  }) {
    return Column(
      children: [
        for (int i = 0; i < leaveBalances.length; i += 2) ...[
          Row(
            children: [
              Expanded(
                child: leaveCard(
                  title: leaveBalances[i].leaveType ?? "",
                  available: "${leaveBalances[i].balance ?? 0}",
                  used: "${leaveBalances[i].usedLeaves ?? 0}",
                  context: context,
                ),
              ),
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

  /// Leave Card
  Widget leaveCard({
    required String title,
    required String available,
    required String used,
    required BuildContext context,
  }) {
    return Card(
      color: context.read<AppThemeProvider>().isDarkMode
          ? AppColors.darkGrey
          : AppColors.lightGrey,
      margin: EdgeInsets.zero,
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
            const Spacer(),
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

  _myLeaveSummary({
    required MyLeaveManagementProvider provider,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppSize.verticalWidgetSpacing),

        /// My Leave Balance
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSize.verticalWidgetSpacing,
          ),
          child: Card(
            margin: EdgeInsets.zero,
            child: Theme(
              data: Theme.of(
                context,
              ).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                title: Text(
                  "My Leave Balance",
                  style: AppTextStyle().titleTextStyle(context: context),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSize.verticalWidgetSpacing,
                    ),
                    child: _leaveBalanceGrid(
                      context: context,
                      leaveBalances:
                          provider.leaveSummaryModel?.data?.leaveBalance ?? [],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: AppSize.verticalWidgetSpacing),

        /// My Leave Request
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSize.verticalWidgetSpacing,
          ),
          child: Text(
            "My Leave Request",
            style: AppTextStyle().titleTextStyle(context: context),
          ),
        ),
        Expanded(child: MyLeaveRequestsTabScreen(hideFloatingButton: true)),
      ],
    );
  }

  _myLeavePlans({
    required MyLeaveManagementProvider provider,
    required BuildContext context,
  }) {
    return Column(
      children: [
        if (provider.leavePlanDataModel != null) ...[
          // SizedBox(height: AppSize.verticalWidgetSpacing),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.width,
              child: LeavePlanDetailsScreen(
                leavePlanDataModel: provider.leavePlanDataModel!,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class LeavePlanDetailsScreen extends StatelessWidget {
  final LeavePlanDataModel leavePlanDataModel;

  const LeavePlanDetailsScreen({super.key, required this.leavePlanDataModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppSize.verticalWidgetSpacing),

          /// PLAN INFO CARD
          Card(
            margin: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    leavePlanDataModel.planName ?? "",
                    style: AppTextStyle().titleTextStyle(
                      context: context,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: AppSize.verticalWidgetSpacing / 2),

                  _infoRow(
                    "Category",
                    leavePlanDataModel.userCategoryName,
                    context: context,
                  ),
                  _infoRow(
                    "Start Date",
                    leavePlanDataModel.planStartDate,
                    context: context,
                  ),
                  _infoRow(
                    "End Date",
                    leavePlanDataModel.planEndDate,
                    context: context,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: AppSize.verticalWidgetSpacing),

          Card(
            margin: EdgeInsets.all(0),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSize.verticalWidgetSpacing,
                vertical: AppSize.verticalWidgetSpacing / 2,
              ),
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: leavePlanDataModel.leaveTypes?.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final leave = leavePlanDataModel.leaveTypes?[index];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(height: AppSize.verticalWidgetSpacing / 2),

                      /// Leave Type Name
                      Text(
                        leave?.leaveType ?? '',
                        style: AppTextStyle().titleTextStyle(
                          context: context,
                          fontSize: 14,
                          color: AppColors.primaryColor,
                        ),
                      ),

                      const SizedBox(height: AppSize.verticalWidgetSpacing / 2),

                      _infoRow(
                        "Total Leaves",
                        leave?.leaveCount.toString(),
                        context: context,
                      ),
                      _infoRow(
                        "Paid Leave",
                        leave?.isPaid == true ? "Yes" : "No",
                        context: context,
                      ),
                      _infoRow(
                        "Carry Forward",
                        leave?.carryForward == true ? "Yes" : "No",
                        context: context,
                      ),

                      if (leave?.carryForward == true)
                        _infoRow(
                          "Max Carry Forward",
                          (leave?.maxCarryForward ?? 0).toString(),
                          context: context,
                        ),
                      const SizedBox(height: AppSize.verticalWidgetSpacing / 2),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Reusable Info Row
  Widget _infoRow(
    String title,
    String? value, {
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: AppTextStyle().lableTextStyle(context: context),
            ),
          ),
          Text(
            value ?? "-",
            style: AppTextStyle().subTitleTextStyle(
              context: context,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
