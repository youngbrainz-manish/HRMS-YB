import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/router/app_router.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/leave/employee_leave_provider.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:hrms_yb/shared/widgets/common_button.dart';
import 'package:provider/provider.dart';

class EmployeeLeaveScreen extends StatelessWidget {
  const EmployeeLeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EmployeeLeaveProvider(context: context),
      child: Consumer<EmployeeLeaveProvider>(
        builder: (context, provider, child) {
          return Scaffold(body: _buildBody(provider: provider));
        },
      ),
    );
  }

  Widget _buildBody({required EmployeeLeaveProvider provider}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          leaveBalanceCard(provider: provider),
          SizedBox(height: AppSize().verticalWidgetSpacing),
          CommonButton(
            title: "+ Apply for leave",
            onTap: () async {
              await GoRouter.of(provider.context).push(AppRouter.leaveFormScreenRoute);
            },
          ),
          SizedBox(height: AppSize().verticalWidgetSpacing),
          myLeaveRequestCard(provider: provider),
          SizedBox(height: AppSize().verticalWidgetSpacing),
        ],
      ),
    );
  }

  Widget leaveBalanceCard({required EmployeeLeaveProvider provider}) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(blurRadius: 12, color: Colors.black.withValues(alpha: .05))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Leave Balance", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: provider.leaveDetailsList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.9,
              ),
              itemBuilder: (_, i) {
                Map<String, dynamic> leaves = provider.leaveDetailsList[i];
                return leaveBalanceItemWidget(
                  context: provider.context,
                  title: leaves['name'].toString(),
                  days: leaves['days'].toString(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget leaveBalanceItemWidget({required BuildContext context, required String title, required String days}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyle().subTitleTextStyle(context: context)),
          Spacer(),
          Text(days, style: AppTextStyle().titleTextStyle(context: context, fontSize: 20)),
          Spacer(),
          Text(
            "days left",
            style: AppTextStyle().lableTextStyle(context: context, color: AppColors.greyColor),
          ),
        ],
      ),
    );
  }

  Widget myLeaveRequestCard({required EmployeeLeaveProvider provider}) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(blurRadius: 12, color: Colors.black.withValues(alpha: .05))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("My Leave Requests", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(height: AppSize().verticalWidgetSpacing),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (contex, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 12, top: 12),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderGrey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Casual Leave", style: AppTextStyle().titleTextStyle(context: provider.context)),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.leaveColor.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "Pending",
                              style: AppTextStyle().subTitleTextStyle(context: provider.context, fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Dec 23 - Dec 24, 2024",
                        style: AppTextStyle().lableTextStyle(context: provider.context, fontSize: 15),
                      ),
                      SizedBox(height: 12),
                      Container(
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.greyColor.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Reason:",
                              style: AppTextStyle().lableTextStyle(context: provider.context, fontSize: 16),
                            ),
                            Text("Family function", style: AppTextStyle().subTitleTextStyle(context: provider.context)),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Text("2 days", style: AppTextStyle().lableTextStyle(context: provider.context)),
                          Spacer(),
                          Text("Applied: Dec 18", style: AppTextStyle().lableTextStyle(context: provider.context)),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
