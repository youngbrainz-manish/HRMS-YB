import 'package:flutter/material.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/leave/tab_widget/team_requests_tab/team_requests_tab_provider.dart';
import 'package:provider/provider.dart';

class TeamRequestsTabScreen extends StatelessWidget {
  const TeamRequestsTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TeamRequestsTabProvider(context: context),
      child: Consumer<TeamRequestsTabProvider>(
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
    required TeamRequestsTabProvider provider,
  }) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Center(child: Text("TeamRequestsTabScreen")),
    );
  }
}
