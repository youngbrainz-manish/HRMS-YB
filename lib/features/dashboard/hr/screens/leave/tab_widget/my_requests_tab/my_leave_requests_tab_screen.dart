import 'package:flutter/material.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/leave/tab_widget/my_requests_tab/my_leave_requests_tab_provider.dart';
import 'package:provider/provider.dart';

class MyLeaveRequestsTabScreen extends StatelessWidget {
  const MyLeaveRequestsTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyLeaveRequestsTabProvider(context: context),
      child: Consumer<MyLeaveRequestsTabProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: SafeArea(child: _buildBody(context: context)),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {},
              label: const Text("Apply Leave"),
              icon: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody({required BuildContext context}) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Center(child: Text("data")),
    );
  }
}
