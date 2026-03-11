import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/leave_management/my_teams_leave_management/my_teams_leave_management_provider.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/hr_leave_management/leave_tracker/models/leave_plan_data_model.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/hr_leave_management/leave_tracker/tab_widget/team_requests_tab/team_requests_tab_screen.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:provider/provider.dart';

class MyTeamsLeaveManagementScreen extends StatelessWidget {
  const MyTeamsLeaveManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyTeamsLeaveManagementProvider(context: context),
      child: Consumer<MyTeamsLeaveManagementProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              leading: CommonWidget.backButton(onTap: () => GoRouter.of(context).pop()),
              title: Text("My Team's Leave Management"),
            ),
            body: SafeArea(
              child: _buildBody(context: context, provider: provider),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody({required BuildContext context, required MyTeamsLeaveManagementProvider provider}) {
    return provider.isLoading
        ? CommonWidget.defaultLoader()
        : 1 == 1
        ? TeamRequestsTabScreen()
        : DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(text: "My Team's Leave Request"),
                    Tab(text: "My Team's Leave Plans"),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      TeamRequestsTabScreen(),
                      _myTeamsLeavePlans(provider: provider, context: context),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  _myTeamsLeavePlans({required MyTeamsLeaveManagementProvider provider, required BuildContext context}) {
    return Column(
      children: [
        if (provider.teamsLeavePlanDataModel != null) ...[
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.width,
              child: LeavePlanDetailsScreen(leavePlanDataModel: provider.teamsLeavePlanDataModel!),
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    leavePlanDataModel.planName ?? "",
                    style: AppTextStyle().titleTextStyle(context: context, fontSize: 14),
                  ),

                  const SizedBox(height: AppSize.verticalWidgetSpacing / 2),

                  _infoRow("Category", leavePlanDataModel.userCategoryName, context: context),
                  _infoRow("Start Date", leavePlanDataModel.planStartDate, context: context),
                  _infoRow("End Date", leavePlanDataModel.planEndDate, context: context),
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

                      _infoRow("Total Leaves", leave?.leaveCount.toString(), context: context),
                      _infoRow("Paid Leave", leave?.isPaid == true ? "Yes" : "No", context: context),
                      _infoRow("Carry Forward", leave?.carryForward == true ? "Yes" : "No", context: context),

                      if (leave?.carryForward == true)
                        _infoRow("Max Carry Forward", (leave?.maxCarryForward ?? 0).toString(), context: context),
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
  Widget _infoRow(String title, String? value, {required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(title, style: AppTextStyle().lableTextStyle(context: context)),
          ),
          Text(
            value ?? "-",
            style: AppTextStyle().subTitleTextStyle(context: context, fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
