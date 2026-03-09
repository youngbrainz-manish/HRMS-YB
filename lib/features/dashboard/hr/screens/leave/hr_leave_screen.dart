import 'package:flutter/material.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/leave/hr_leave_provider.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/leave/tab_widget/all_team_leaves_tab/all_team_leaves_tab_screen.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/leave/tab_widget/my_leave_summary_tab/my_leave_summary_tab_screen.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/leave/tab_widget/my_leave_requests_tab/my_leave_requests_tab_screen.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/leave/tab_widget/team_requests_tab/team_requests_tab_screen.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:provider/provider.dart';

class HrLeaveScreen extends StatelessWidget {
  const HrLeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HrLeaveProvider(context: context),
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: SafeArea(child: _buildBody(context: context)),
        ),
      ),
    );
  }

  Widget _buildBody({required BuildContext context}) {
    return SizedBox(
      child: Column(
        children: [
          const SizedBox(height: AppSize.verticalWidgetSpacing / 2),
          TabBar(
            tabAlignment: TabAlignment.start,
            dividerColor: Colors.transparent,
            isScrollable: true,
            tabs: const [
              Tab(text: "My Leave Summary"),
              Tab(text: "My Leave Requests"),
              Tab(text: "Team Requests"),
              Tab(text: "All Team Leaves"),
            ],
          ),

          const Expanded(
            child: TabBarView(
              children: [
                MyLeaveSummaryTabScreen(),
                MyLeaveRequestsTabScreen(),
                TeamRequestsTabScreen(),
                AllTeamLeavesTabScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
