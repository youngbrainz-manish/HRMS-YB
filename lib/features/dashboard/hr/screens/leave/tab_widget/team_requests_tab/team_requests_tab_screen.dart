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
          return Stack(
            children: [
              Scaffold(
                body: SafeArea(
                  child: _buildBody(context: context, provider: provider),
                ),
              ),
              if (provider.showFullScreenLoader) ...[CommonWidget.fullScreenLoader()],
            ],
          );
        },
      ),
    );
  }

  Widget _buildBody({required BuildContext context, required TeamRequestsTabProvider provider}) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: provider.isLoading
          ? CommonWidget.defaultLoader()
          : provider.teamLeaveDataModel.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Data not found."),
                  SizedBox(height: AppSize.verticalWidgetSpacing),
                  CommonButton(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 40,
                    title: "Refres",
                    onTap: () => provider.getTeamsLeaveRequest(),
                    icon: Icon(Icons.refresh, color: AppColors.whiteColor),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: () async {
                await provider.getTeamsLeaveRequest();
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(AppSize.verticalWidgetSpacing),
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: provider.teamLeaveDataModel.length,
                itemBuilder: (context, index) {
                  final leave = provider.teamLeaveDataModel[index];
                  final employee = leave.employee;
                  final leaveType = leave.leavePlanType;

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
                                  style: AppTextStyle().lableTextStyle(
                                    context: context,
                                    color: getStatusColor(leave.status ?? ''),
                                  ),
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
                          _rowWidget(
                            context: context,
                            title: "From -> To",
                            value: "${leave.startDate} → ${leave.endDate}",
                          ),

                          /// Total Days
                          _rowWidget(context: context, title: "Duration", value: "${leave.totalDays} Days"),

                          /// Reason
                          _rowWidget(context: context, title: "Reason", value: leave.reason ?? "-"),
                          if (leave.status?.toLowerCase() == 'approved') ...[
                            /// Manager comment
                            _rowWidget(context: context, title: "Manager Comment", value: leave.managerComment ?? "-"),
                          ] else if (leave.status?.toLowerCase() != 'Cancelled'.toLowerCase()) ...[
                            SizedBox(height: AppSize.verticalWidgetSpacing),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: CommonButton(
                                    borderRadius: 6,
                                    height: 36,
                                    title: "Reject",
                                    onTap: () async {
                                      String? reason = await CommonWidget.showTextInputDialog(
                                        context: context,
                                        title: "Reject Leave Request",
                                        hintText: "Enter Rejection reason",
                                        cancelText: "Cancel",
                                        confirmText: "Reject",
                                      );

                                      if ((reason ?? '').isNotEmpty) {
                                        Map<String, dynamic> data = {"status": "approved", "manager_comment": reason};
                                        bool? val = await provider.approveOrRejectLeave(leave: leave, data: data);
                                        if (val == true) {
                                          provider.getTeamsLeaveRequest();
                                        }
                                      }
                                    },
                                    color: context.read<AppThemeProvider>().isDarkMode
                                        ? AppColors.darkGrey
                                        : AppColors.lightGrey,
                                    titleColor: AppColors.primaryColor,
                                    borderColor: AppColors.primaryColor,
                                  ),
                                ),
                                if (leave.status?.toLowerCase() != 'approved') ...[
                                  SizedBox(width: AppSize.verticalWidgetSpacing),
                                  Expanded(
                                    child: CommonButton(
                                      borderRadius: 6,
                                      height: 36,
                                      title: "Approve",
                                      onTap: () async {
                                        String? reason = await CommonWidget.showTextInputDialog(
                                          context: context,
                                          title: "Approve Leave Request",
                                          hintText: "Enter Approve reason",
                                          cancelText: "Cancel",
                                          confirmText: "Approve",
                                        );

                                        if ((reason ?? '').isNotEmpty) {
                                          Map<String, dynamic> data = {"status": "approved", "manager_comment": reason};
                                          bool? val = await provider.approveOrRejectLeave(leave: leave, data: data);
                                          if (val == true) {
                                            provider.getTeamsLeaveRequest();
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
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
