import 'package:flutter/material.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/leave/tab_widget/all_team_leaves_tab/all_team_leaves_tab_provider.dart';
import 'package:provider/provider.dart';

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

  Widget _buildBody({
    required BuildContext context,
    required AllTeamLeavesTabProvider provider,
  }) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Center(child: Text("All team leaves tab")),
    );
  }
}
