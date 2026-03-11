import 'package:flutter/material.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/hr_leave_management/leave_plans/all_leave_plan/all_leave_plan_screen.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/hr_leave_management/leave_plans/my_leave_pan/my_leave_plan_screen.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';

class LeavePlanScreen extends StatelessWidget {
  const LeavePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(child: _buildBody(context: context)),
      ),
    );
  }

  Widget _buildBody({required BuildContext context}) {
    return SizedBox(
      child: Column(
        children: [
          const SizedBox(height: AppSize.verticalWidgetSpacing / 2),
          TabBar(
            tabAlignment: TabAlignment.center,
            dividerColor: Colors.transparent,
            isScrollable: true,
            labelStyle: AppTextStyle().titleTextStyle(context: context, color: AppColors.primaryColor, fontSize: 14),
            unselectedLabelStyle: AppTextStyle().lableTextStyle(context: context),
            tabs: const [
              Tab(text: "All Leave Plans"),
              Tab(text: "My Leave Plan"),
            ],
          ),

          const Expanded(child: TabBarView(children: [AllLeavePlanScreen(), MyLeavePlanScreen()])),
        ],
      ),
    );
  }
}
