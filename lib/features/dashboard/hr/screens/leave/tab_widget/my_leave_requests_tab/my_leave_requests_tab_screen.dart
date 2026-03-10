import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/router/app_router.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/leave/tab_widget/my_leave_requests_tab/my_leave_model.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/leave/tab_widget/my_leave_requests_tab/my_leave_requests_tab_provider.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:provider/provider.dart';

class MyLeaveRequestsTabScreen extends StatelessWidget {
  final bool? hideFloatingButton;
  const MyLeaveRequestsTabScreen({super.key, this.hideFloatingButton});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyLeaveRequestsTabProvider(context: context),
      child: Consumer<MyLeaveRequestsTabProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: SafeArea(
              child: provider.isLoading
                  ? CommonWidget.defaultLoader()
                  : buildBody(
                      provider: provider,
                      hideFloatingButton: hideFloatingButton,
                    ),
            ),
            floatingActionButton:
                provider.isLoading || hideFloatingButton == true
                ? const SizedBox()
                : FloatingActionButton.extended(
                    onPressed: () async {
                      await GoRouter.of(
                        context,
                      ).push(AppRouter.addUpdateLeaveScreenRoute);
                    },
                    label: const Text("Apply Leave"),
                    icon: const Icon(Icons.add),
                  ),
          );
        },
      ),
    );
  }

  Widget buildBody({
    required MyLeaveRequestsTabProvider provider,
    bool? hideFloatingButton,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppSize.verticalWidgetSpacing,
        top:
            AppSize.verticalWidgetSpacing *
            (hideFloatingButton == true ? 0.5 : 1),
        right: AppSize.verticalWidgetSpacing,
        bottom: AppSize.verticalWidgetSpacing,
      ),
      child: RefreshIndicator(
        onRefresh: provider.refreshLeaves,
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(0),
          controller: provider.scrollController,
          itemCount: provider.leaveList.length + (provider.isLoadMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == provider.leaveList.length) {
              Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CommonWidget.defaultLoader()),
              );
            }

            final leave = provider.leaveList[index];

            return LeaveDetailCard(leaveModel: leave);
          },
        ),
      ),
    );
  }
}

class LeaveDetailCard extends StatelessWidget {
  final LeaveModel leaveModel;

  const LeaveDetailCard({super.key, required this.leaveModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSize.verticalWidgetSpacing / 2,
      ),
      child: Card(
        margin: EdgeInsets.all(0),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header: Type and Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${leaveModel.leavePlanType?.leaveType} Leave",
                    style: AppTextStyle().titleTextStyle(context: context),
                  ),
                  _buildStatusChip(
                    status: leaveModel.status ?? '',
                    context: context,
                  ),
                ],
              ),
              Divider(
                height: AppSize.verticalWidgetSpacing,
                color: AppColors.greyColor,
              ),

              // Date Row
              Row(
                children: [
                  _buildDateColumn(
                    label: "START DATE",
                    date: leaveModel.startDate ?? "",
                    context: context,
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward, color: Colors.grey, size: 16),
                  const Spacer(),
                  _buildDateColumn(
                    label: "END DATE",
                    date: leaveModel.endDate ?? '',
                    context: context,
                  ),
                ],
              ),
              Divider(
                height: AppSize.verticalWidgetSpacing,
                color: AppColors.greyColor,
              ),

              // Total Days & Reason
              Text(
                "Total Duration: ${leaveModel.totalDays} Days",
                style: AppTextStyle().titleTextStyle(
                  context: context,
                  color: AppColors.indigocolor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: AppSize.verticalWidgetSpacing / 2),
              Text(
                "Reason: ${leaveModel.reason ?? 'No reason provided'}",
                style: AppTextStyle().subTitleTextStyle(
                  context: context,
                  color: AppColors.greyColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip({
    required String status,
    required BuildContext context,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.warningColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.warningColor),
      ),
      child: Text(
        status.toUpperCase(),
        style: AppTextStyle().lableTextStyle(context: context, fontSize: 10),
      ),
    );
  }

  Widget _buildDateColumn({
    required String label,
    required String date,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle().lableTextStyle(
            context: context,
            fontSize: 10,
            height: 1.2,
            color: AppColors.greyColor,
          ),
        ),
        Text(date, style: AppTextStyle().subTitleTextStyle(context: context)),
      ],
    );
  }
}
