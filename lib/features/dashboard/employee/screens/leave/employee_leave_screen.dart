import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/router/app_router.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/core/theme/app_theme_provider.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/leave/employee_leave_provider.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/leave/models/leave_plan_data_model.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/leave/models/leave_summary_model.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/leave/tab_widget/my_leave_requests_tab/my_leave_requests_tab_screen.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/leave/tab_widget/team_requests_tab/team_requests_tab_screen.dart';
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
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: AppSize.verticalWidgetSpacing,
                            ),

                            /// My Leave Plan
                            Card(
                              margin: EdgeInsets.zero,
                              child: Theme(
                                data: Theme.of(
                                  context,
                                ).copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                  title: Text(
                                    "My Leave Plan",
                                    style: AppTextStyle().titleTextStyle(
                                      context: context,
                                    ),
                                  ),
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(
                                    //     horizontal:
                                    //         AppSize.verticalWidgetSpacing,
                                    //   ),
                                    //   child: _leaveBalanceGrid(
                                    //     context: context,
                                    //     leaveBalances:
                                    //         provider
                                    //             .leaveSummaryModel
                                    //             ?.data
                                    //             ?.leaveBalance ??
                                    //         [],
                                    //   ),
                                    // ),
                                    if (provider.leavePlanDataModel !=
                                        null) ...[
                                      SizedBox(
                                        height: MediaQuery.of(
                                          context,
                                        ).size.width,
                                        child: LeavePlanDetailsScreen(
                                          leavePlanDataModel:
                                              provider.leavePlanDataModel!,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: AppSize.verticalWidgetSpacing),

                            /// My Leave Balance
                            Card(
                              margin: EdgeInsets.zero,
                              child: Theme(
                                data: Theme.of(
                                  context,
                                ).copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                  title: Text(
                                    "My Leave Balance",
                                    style: AppTextStyle().titleTextStyle(
                                      context: context,
                                    ),
                                  ),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal:
                                            AppSize.verticalWidgetSpacing,
                                      ),
                                      child: _leaveBalanceGrid(
                                        context: context,
                                        leaveBalances:
                                            provider
                                                .leaveSummaryModel
                                                ?.data
                                                ?.leaveBalance ??
                                            [],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: AppSize.verticalWidgetSpacing,
                            ),

                            /// Apply Leave Button
                            CommonButton(
                              title: "+ Apply for leave",
                              onTap: () async {
                                var data = await GoRouter.of(
                                  context,
                                ).push(AppRouter.addUpdateLeaveScreenRoute);
                                if (data == true) {
                                  provider.refreshPage();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// TabBar
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _SliverAppBarDelegate(
                        TabBar(
                          tabAlignment: TabAlignment.center,
                          dividerColor: Colors.transparent,
                          isScrollable: true,
                          labelColor: AppColors.primaryColor,
                          tabs: const [
                            Tab(text: "My Leave Requests"),
                            Tab(text: "Team Requests"),
                          ],
                        ),
                      ),
                    ),
                  ];
                },

                /// Tab Views
                body: const TabBarView(
                  children: [
                    MyLeaveRequestsTabScreen(hideFloatingButton: true),
                    TeamRequestsTabScreen(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Leave Balance Grid
  Widget _leaveBalanceGrid({
    required List<LeaveBalance> leaveBalances,
    required BuildContext context,
  }) {
    return Column(
      children: [
        for (int i = 0; i < leaveBalances.length; i += 2) ...[
          Row(
            children: [
              Expanded(
                child: leaveCard(
                  title: leaveBalances[i].leaveType ?? "",
                  available: "${leaveBalances[i].balance ?? 0}",
                  used: "${leaveBalances[i].usedLeaves ?? 0}",
                  context: context,
                ),
              ),
              if (i + 1 < leaveBalances.length) ...[
                const SizedBox(width: AppSize.verticalWidgetSpacing),
                Expanded(
                  child: leaveCard(
                    title: leaveBalances[i + 1].leaveType ?? "",
                    available: "${leaveBalances[i + 1].balance ?? 0}",
                    used: "${leaveBalances[i + 1].usedLeaves ?? 0}",
                    context: context,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: AppSize.verticalWidgetSpacing),
        ],
      ],
    );
  }

  /// Leave Card
  Widget leaveCard({
    required String title,
    required String available,
    required String used,
    required BuildContext context,
  }) {
    return Card(
      color: context.read<AppThemeProvider>().isDarkMode
          ? AppColors.darkGrey
          : AppColors.lightGrey,
      margin: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 14,
                  child: Icon(Icons.assignment_outlined, size: 18),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyle().titleTextStyle(
                      context: context,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Available",
                  style: AppTextStyle().subTitleTextStyle(context: context),
                ),
                Text(
                  available,
                  style: AppTextStyle().subTitleTextStyle(
                    context: context,
                    color: AppColors.successPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Used",
                  style: AppTextStyle().subTitleTextStyle(context: context),
                ),
                Text(
                  used,
                  style: AppTextStyle().subTitleTextStyle(
                    context: context,
                    color: AppColors.errorColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Sticky TabBar Delegate
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverAppBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class LeavePlanDetailsScreen extends StatelessWidget {
  final LeavePlanDataModel leavePlanDataModel;

  const LeavePlanDetailsScreen({super.key, required this.leavePlanDataModel});

  @override
  Widget build(BuildContext context) {
    // final plan = data["data"];
    // final leaveTypes = plan["leave_types"] as List;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// PLAN INFO CARD
          Card(
            color: context.read<AppThemeProvider>().isDarkMode
                ? AppColors.darkGrey
                : AppColors.lightGrey,
            margin: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    leavePlanDataModel.planName ?? "",
                    style: AppTextStyle().titleTextStyle(
                      context: context,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: AppSize.verticalWidgetSpacing / 2),

                  _infoRow(
                    "Category",
                    leavePlanDataModel.userCategoryName,
                    context: context,
                  ),
                  _infoRow(
                    "Start Date",
                    leavePlanDataModel.planStartDate,
                    context: context,
                  ),
                  _infoRow(
                    "End Date",
                    leavePlanDataModel.planEndDate,
                    context: context,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: AppSize.verticalWidgetSpacing),

          Card(
            color: context.read<AppThemeProvider>().isDarkMode
                ? AppColors.darkGrey
                : AppColors.lightGrey,
            margin: EdgeInsets.all(0),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSize.verticalWidgetSpacing,
                vertical: AppSize.verticalWidgetSpacing / 2,
              ),
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: leavePlanDataModel.leaveTypes?.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final leave = leavePlanDataModel.leaveTypes?[index];

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

                      _infoRow(
                        "Total Leaves",
                        leave?.leaveCount.toString(),
                        context: context,
                      ),
                      _infoRow(
                        "Paid Leave",
                        leave?.isPaid == true ? "Yes" : "No",
                        context: context,
                      ),
                      _infoRow(
                        "Carry Forward",
                        leave?.carryForward == true ? "Yes" : "No",
                        context: context,
                      ),

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
          // const SizedBox(height: AppSize.verticalWidgetSpacing),
        ],
      ),
    );
  }

  /// Reusable Info Row
  Widget _infoRow(
    String title,
    String? value, {
    required BuildContext context,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            title,
            style: AppTextStyle().lableTextStyle(context: context, height: 1.2),
          ),
        ),
        Text(
          value ?? "-",
          style: AppTextStyle().subTitleTextStyle(
            context: context,
            height: 1,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
