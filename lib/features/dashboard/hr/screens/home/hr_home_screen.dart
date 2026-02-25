import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/router/app_router.dart';
import 'package:hrms_yb/features/dashboard/hr/dashboard/hr_dashboard_provider.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/home/hr_home_provider.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:provider/provider.dart';

class HrHomeScreen extends StatefulWidget {
  const HrHomeScreen({super.key});

  @override
  State<HrHomeScreen> createState() => _HrHomeScreenState();
}

class _HrHomeScreenState extends State<HrHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HrHomeProvider(context: context),
      child: Consumer<HrHomeProvider>(
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

  Widget _buildBody({required BuildContext context, required HrHomeProvider provider}) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ===== STATS GRID =====
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: provider.stats.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 1.7,
              ),
              itemBuilder: (_, i) => _StatCard(stat: provider.stats[i]),
            ),
            SizedBox(height: AppSize.verticalWidgetSpacing),

            /// ===== QUICK ACTIONS =====
            _SectionCard(
              title: "Quick Actions",
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: provider.quickActions.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 2.5,
                ),
                itemBuilder: (_, i) => GestureDetector(
                  onTap: () async {
                    if (i == 0) {
                      context.read<HrDashboardProvider>().changeTitle("Add Employee");
                      await GoRouter.of(context).push(AppRouter.addEmployeeScreenRoute);
                      if (context.mounted) {
                        context.read<HrDashboardProvider>().changeTitle("Home");
                        GoRouter.of(context).go(AppRouter.hrDashboardRoute);
                      }
                    } else if (i == 1) {
                      context.read<HrDashboardProvider>().changeTitle("Leave Management");
                      GoRouter.of(context).go(AppRouter.hrLeaveScreenRoute);
                    } else if (i == 2) {
                      context.read<HrDashboardProvider>().changeTitle("Attendance");
                      GoRouter.of(context).go(AppRouter.hrAttendanceScreenRoute);
                    } else if (i == 3) {
                      context.read<HrDashboardProvider>().changeTitle("Payroll");
                      GoRouter.of(context).go(AppRouter.hrPayrollScreenRoute);
                    }
                  },
                  child: _QuickActionCard(action: provider.quickActions[i]),
                ),
              ),
            ),

            SizedBox(height: AppSize.verticalWidgetSpacing),

            /// ===== RECENT ACTIVITIES =====
            _SectionCard(
              title: "Recent Activities",
              child: Column(children: provider.activities.map((e) => _ActivityTile(activity: e)).toList()),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final DashboardStat stat;

  const _StatCard({required this.stat});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(colors: stat.gradient),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(stat.icon, size: 20),
            const Spacer(),
            Text(stat.value, style: AppTextStyle().titleTextStyle(context: context, fontSize: 20)),
            Spacer(),
            Text(stat.title, style: AppTextStyle().lableTextStyle(context: context)),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyle().titleTextStyle(context: context)),
            SizedBox(height: AppSize.verticalWidgetSpacing),
            child,
          ],
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final QuickAction action;

  const _QuickActionCard({required this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: action.color.withValues(alpha: .08),
        border: Border.all(color: action.color.withValues(alpha: .25)),
      ),
      child: Row(
        children: [
          Icon(action.icon, color: action.color, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              action.title,
              style: AppTextStyle().subTitleTextStyle(context: context, color: action.color, height: 1.2),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final Activity activity;

  const _ActivityTile({required this.activity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: activity.dotColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(activity.title, style: const TextStyle(fontSize: 15)),
                const SizedBox(height: 4),
                Text(activity.time, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
