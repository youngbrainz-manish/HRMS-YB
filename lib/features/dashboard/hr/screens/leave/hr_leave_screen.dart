import 'package:flutter/material.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/core/theme/app_theme_provider.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/leave/hr_leave_provider.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:provider/provider.dart';

class HrLeaveScreen extends StatelessWidget {
  const HrLeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HrLeaveProvider(context: context),
      child: Consumer<HrLeaveProvider>(
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

  Widget _buildBody({required BuildContext context, required HrLeaveProvider provider}) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          _tabBar(provider: provider, context: context),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: provider.dummyLeaves.length,
              itemBuilder: (_, i) => LeaveApprovalCard(leave: provider.dummyLeaves[i]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabBar({required HrLeaveProvider provider, required BuildContext context}) {
    return Card(
      margin: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Container(
        padding: const EdgeInsets.only(left: 4, top: 6, right: 4, bottom: 6),
        child: Row(
          children: List.generate(provider.tabs.length, (index) {
            final selected = provider.selectedTab == index;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  provider.selectedTab = index;
                  provider.updateState();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: selected
                        ? (context.watch<AppThemeProvider>().isDarkMode
                              ? AppColors.dartButtonColor
                              : AppColors.primaryColor)
                        : AppColors.greyColor.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      provider.tabs[index],
                      style: selected
                          ? AppTextStyle().titleTextStyle(
                              context: context,
                              color: selected ? AppColors.whiteColor : null,
                            )
                          : AppTextStyle().lableTextStyle(context: context),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class LeaveApprovalCard extends StatelessWidget {
  final LeaveRequest leave;

  const LeaveApprovalCard({super.key, required this.leave});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(leave.employeeName, style: AppTextStyle().titleTextStyle(context: context)),
                    SizedBox(height: 4),
                    Text(leave.department, style: AppTextStyle().lableTextStyle(context: context)),
                  ],
                ),
                _statusChip(),
              ],
            ),

            const SizedBox(height: 16),

            /// DETAILS BOX
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.greyColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  _row(context: context, title: "Leave Type", value: leave.leaveType),
                  _row(context: context, title: "Dates", value: leave.dates),
                  _row(context: context, title: "Days", value: leave.days),
                ],
              ),
            ),

            const SizedBox(height: 12),

            /// REASON
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.holidayColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Reason:", style: AppTextStyle().titleTextStyle(context: context)),
                  const SizedBox(height: 4),
                  Text(leave.reason, style: AppTextStyle().subTitleTextStyle(context: context)),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// BUTTONS
            Row(
              children: [
                _actionButton(context: context, text: "Approve", color: AppColors.successPrimary, icon: Icons.check),
                const SizedBox(width: 8),
                _actionButton(context: context, text: "Reject", color: AppColors.errorColor, icon: Icons.close),
                const SizedBox(width: 8),
                _actionButton(
                  context: context,
                  text: "Info",
                  color: AppColors.warningColor,
                  icon: Icons.chat_bubble_outline,
                ),
              ],
            ),

            const SizedBox(height: 16),

            Text("Applied: ${leave.appliedDate}", style: AppTextStyle().lableTextStyle(context: context)),
          ],
        ),
      ),
    );
  }

  Widget _row({required BuildContext context, required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyle().subTitleTextStyle(context: context)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _statusChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.warningColor.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text("Pending", style: TextStyle(color: AppColors.errorColor)),
    );
  }

  Widget _actionButton({
    required BuildContext context,
    required String text,
    required Color color,
    required IconData icon,
  }) {
    return Expanded(
      child: Container(
        height: 44,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.whiteColor, size: 18),
            const SizedBox(width: 6),
            Text(
              text,
              style: AppTextStyle().titleTextStyle(context: context, color: AppColors.whiteColor, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
