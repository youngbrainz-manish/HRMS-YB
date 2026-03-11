import 'package:flutter/material.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/hr_leave_management/leave_plans/my_leave_pan/my_leave_plan_provider.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:provider/provider.dart';

class MyLeavePlanScreen extends StatelessWidget {
  const MyLeavePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyLeavePlanProvider(context: context),
      child: Consumer<MyLeavePlanProvider>(
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

  Widget _buildBody({required BuildContext context, required MyLeavePlanProvider provider}) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: provider.isLoading
          ? CommonWidget.defaultLoader()
          : provider.leavePlanDataModel == null
          ? Center(child: Text("Data not found"))
          : SingleChildScrollView(
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
                            provider.leavePlanDataModel!.planName ?? "",
                            style: AppTextStyle().titleTextStyle(context: context, fontSize: 14),
                          ),

                          const SizedBox(height: AppSize.verticalWidgetSpacing / 2),

                          _infoRow("Category", provider.leavePlanDataModel!.userCategoryName, context: context),
                          _infoRow("Start Date", provider.leavePlanDataModel!.planStartDate, context: context),
                          _infoRow("End Date", provider.leavePlanDataModel!.planEndDate, context: context),
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
                        itemCount: provider.leavePlanDataModel!.leaveTypes?.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final leave = provider.leavePlanDataModel!.leaveTypes?[index];

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
