import 'package:flutter/material.dart';
import 'package:hrms_yb/shared/models/leave_module/all_user_response_model.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:provider/provider.dart';
import 'all_team_leaves_tab_provider.dart';

class AllTeamLeavesTabScreen extends StatelessWidget {
  const AllTeamLeavesTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AllTeamLeavesTabProvider(context: context),
      child: Consumer<AllTeamLeavesTabProvider>(
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

  Widget _buildBody({required BuildContext context, required AllTeamLeavesTabProvider provider}) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.leaveList.isEmpty) {
      return const Center(child: Text("No Leaves Found"));
    }

    return RefreshIndicator(
      onRefresh: () => provider.getAllUsersLeave(),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: AppSize.verticalWidgetSpacing),
        controller: provider.scrollController,
        itemCount: provider.leaveList.length + 1,
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          if (index == provider.leaveList.length) {
            return provider.isPaginationLoading
                ? const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : const SizedBox();
          }

          LeaveModel leave = provider.leaveList[index];
          final employee = leave.employee;
          final leaveType = leave.leavePlanType;

          return builfDetailsCard(employee, leave, context, leaveType);
        },
      ),
    );
  }

  Widget builfDetailsCard(Employee? employee, LeaveModel leave, BuildContext context, LeavePlanType? leaveType) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                  "${employee?.firstName} ${employee?.lastName}",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: getStatusColor(leave.status ?? '').withValues(alpha: .1),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: getStatusColor(leave.status ?? '')),
                  ),
                  child: Text(
                    leave.status.toString().toUpperCase(),
                    style: AppTextStyle().lableTextStyle(context: context, color: getStatusColor(leave.status ?? '')),
                  ),
                ),
              ],
            ),

            /// Email
            Text(employee?.email ?? '', style: TextStyle(color: Colors.grey[600])),

            const Divider(height: AppSize.verticalWidgetSpacing),

            /// Leave Type
            _rowWidget(context: context, title: "Leave Type", value: leaveType?.leaveType ?? ''),

            /// Date Row
            _rowWidget(context: context, title: "From -> To", value: "${leave.startDate} → ${leave.endDate}"),

            /// Total Days
            _rowWidget(context: context, title: "Duration", value: "${leave.totalDays} Days"),

            /// Reason
            _rowWidget(context: context, title: "Reason", value: leave.reason ?? "-"),
            if (leave.status?.toLowerCase() == 'approved') ...[
              /// Manager comment
              _rowWidget(context: context, title: "Manager Comment", value: leave.managerComment ?? "-"),
            ],
          ],
        ),
      ),
    );
  }

  Widget _rowWidget({required BuildContext context, required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(title, style: AppTextStyle().lableTextStyle(context: context, height: 1.2)),
          ),
          Expanded(flex: 1, child: Text(":")),
          Expanded(
            flex: 14,
            child: Text(value, style: AppTextStyle().titleTextStyle(context: context, fontSize: 13)),
          ),
        ],
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
