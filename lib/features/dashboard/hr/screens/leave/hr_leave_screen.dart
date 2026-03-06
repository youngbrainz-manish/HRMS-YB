// import 'package:flutter/material.dart';
// import 'package:hrms_yb/core/theme/app_colors.dart';
// import 'package:hrms_yb/features/dashboard/hr/screens/leave/hr_leave_provider.dart';
// import 'package:hrms_yb/features/dashboard/hr/screens/leave/models/leave_summary_model.dart';
// import 'package:hrms_yb/shared/utils/app_size.dart';
// import 'package:hrms_yb/shared/utils/app_text_style.dart';
// import 'package:provider/provider.dart';

// class HrLeaveScreen extends StatelessWidget {
//   const HrLeaveScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => HrLeaveProvider(context: context),
//       child: Consumer<HrLeaveProvider>(
//         builder: (context, provider, child) {
//           return DefaultTabController(
//             length: 4,
//             child: Scaffold(
//               floatingActionButton: FloatingActionButton.extended(
//                 onPressed: () {},
//                 label: const Text("Apply Leave"),
//                 icon: const Icon(Icons.add),
//               ),
//               body: _buildBody(contexr: context, provider: provider),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildBody({
//     required BuildContext contexr,
//     required HrLeaveProvider provider,
//   }) {
//     return Column(
//       children: [
//         const SizedBox(height: AppSize.verticalWidgetSpacing / 2),
//         TabBar(
//           tabAlignment: TabAlignment.start,
//           dividerColor: Colors.transparent,
//           isScrollable: true,
//           tabs: [
//             Tab(text: "Leave Summary"),
//             Tab(text: "Team Requests"),
//             Tab(text: "My Requests"),
//             Tab(text: "All Team Leaves"),
//           ],
//         ),
//         Expanded(
//           child: TabBarView(
//             children: [
//               _summaryTab(provider: provider),
//               Center(child: Text("data")),
//               Center(child: Text("data")),
//               Center(child: Text("data")),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _summaryTab({required HrLeaveProvider provider}) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(AppSize.verticalWidgetSpacing),
//       child: Column(
//         children: [
//           /// Leave Balance Cards
//           _leaveBalanceGrid(
//             provider.leaveSummaryModel?.data?.leaveBalance ?? [],
//           ),

//           /// Upcoming Leaves
//           leaveSection(
//             context: provider.context,
//             title: "Upcoming Leaves",
//             leaves: provider.dummyLeaves
//                 .where((e) => e.status == "Approved")
//                 .toList(),
//           ),

//           const SizedBox(height: AppSize.verticalWidgetSpacing),

//           /// Past Leaves
//           leaveSection(
//             context: provider.context,
//             title: "Past Leaves",
//             leaves: provider.dummyLeaves
//                 .where((e) => e.status == "Approved")
//                 .toList(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _leaveBalanceGrid(List<LeaveBalance> leaveBalances) {
//     return Column(
//       children: [
//         for (int i = 0; i < leaveBalances.length; i += 2) ...[
//           Row(
//             children: [
//               /// First Item
//               Expanded(
//                 child: LeaveCard(
//                   title: leaveBalances[i].leaveType ?? "",
//                   available: "${leaveBalances[i].balance ?? 0}",
//                   used: "${leaveBalances[i].usedLeaves ?? 0}",
//                 ),
//               ),

//               /// Second Item OR Spacer
//               if (i + 1 < leaveBalances.length) ...[
//                 const SizedBox(width: AppSize.verticalWidgetSpacing),
//                 Expanded(
//                   child: LeaveCard(
//                     title: leaveBalances[i + 1].leaveType ?? "",
//                     available: "${leaveBalances[i + 1].balance ?? 0}",
//                     used: "${leaveBalances[i + 1].usedLeaves ?? 0}",
//                   ),
//                 ),
//               ],
//             ],
//           ),

//           const SizedBox(height: AppSize.verticalWidgetSpacing),
//         ],
//       ],
//     );
//   }

//   Widget leaveSection({
//     required BuildContext context,
//     required String title,
//     required List<LeaveRequest> leaves,
//   }) {
//     return Card(
//       margin: EdgeInsets.all(0),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: ExpansionTile(
//         tilePadding: const EdgeInsets.symmetric(
//           horizontal: AppSize.verticalWidgetSpacing,
//         ),
//         childrenPadding: const EdgeInsets.symmetric(horizontal: 12),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         title: Text(
//           title,
//           style: AppTextStyle().titleTextStyle(context: context),
//         ),
//         children: [
//           if (leaves.isEmpty)
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 vertical: AppSize.verticalWidgetSpacing * 1.5,
//               ),
//               child: Center(
//                 child: Text(
//                   "No Data Found",
//                   style: AppTextStyle().lableTextStyle(context: context),
//                 ),
//               ),
//             )
//           else
//             ...leaves.map((leave) => LeaveApprovalCard(leave: leave)),

//           SizedBox(height: AppSize.verticalWidgetSpacing),
//         ],
//       ),
//     );
//   }
// }

// class LeaveApprovalCard extends StatelessWidget {
//   final LeaveRequest leave;
//   const LeaveApprovalCard({super.key, required this.leave});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(0),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(AppSize.verticalWidgetSpacing),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// HEADER
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 /// EMPLOYEE INFO
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       leave.employeeName,
//                       style: AppTextStyle().titleTextStyle(context: context),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       leave.department,
//                       style: AppTextStyle().lableTextStyle(context: context),
//                     ),
//                   ],
//                 ),

//                 /// STATUS CHIP
//                 _statusChip(context),
//               ],
//             ),

//             const SizedBox(height: 14),

//             /// LEAVE DETAILS
//             _detailRow(context, "Leave Type", leave.leaveType),
//             _detailRow(context, "Dates", leave.dates),
//             _detailRow(context, "Days", leave.days),

//             const SizedBox(height: 12),

//             /// REASON
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: AppColors.holidayColor.withValues(alpha: 0.2),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Text(
//                 "Reason: ${leave.reason}",
//                 style: AppTextStyle().subTitleTextStyle(context: context),
//               ),
//             ),

//             const SizedBox(height: 12),

//             /// HR NOTES
//             if (leave.hrNotes != null)
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: AppColors.successPrimary.withValues(alpha: 0.12),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Text(
//                   "HR Notes: ${leave.hrNotes}",
//                   style: AppTextStyle().subTitleTextStyle(context: context),
//                 ),
//               ),

//             const SizedBox(height: 10),

//             /// APPLIED DATE
//             Text(
//               "Applied: ${leave.appliedDate}",
//               style: AppTextStyle().lableTextStyle(context: context),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// STATUS CHIP
//   Widget _statusChip(BuildContext context) {
//     Color color;

//     switch (leave.status.toLowerCase()) {
//       case "approved":
//         color = AppColors.successPrimary;
//         break;

//       case "rejected":
//         color = AppColors.errorColor;
//         break;

//       default:
//         color = AppColors.warningColor;
//     }

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
//       decoration: BoxDecoration(
//         color: color.withValues(alpha: 0.2),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Text(
//         leave.status,
//         style: AppTextStyle().lableTextStyle(context: context),
//       ),
//     );
//   }

//   /// DETAIL ROW
//   Widget _detailRow(BuildContext context, String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: AppTextStyle().subTitleTextStyle(context: context),
//           ),
//           Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
//         ],
//       ),
//     );
//   }
// }

// class LeaveCard extends StatelessWidget {
//   final String title;
//   final String available;
//   final String used;

//   const LeaveCard({
//     super.key,
//     required this.title,
//     required this.available,
//     required this.used,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(0),
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         height: 120,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 const CircleAvatar(
//                   radius: 14,
//                   child: Icon(Icons.assignment_outlined, size: 18),
//                 ),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: Text(
//                     title,
//                     style: AppTextStyle().titleTextStyle(
//                       context: context,
//                       fontSize: 14,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 2,
//                   ),
//                 ),
//               ],
//             ),

//             Spacer(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Available",
//                   style: AppTextStyle().subTitleTextStyle(context: context),
//                 ),
//                 Text(
//                   available,
//                   style: AppTextStyle().subTitleTextStyle(
//                     context: context,
//                     color: AppColors.successPrimary,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 4),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Used",
//                   style: AppTextStyle().subTitleTextStyle(context: context),
//                 ),
//                 Text(
//                   used,
//                   style: AppTextStyle().subTitleTextStyle(
//                     context: context,
//                     color: AppColors.errorColor,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SectionCard extends StatelessWidget {
//   final String title;
//   const SectionCard({super.key, required this.title});
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(0),
//       child: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.all(AppSize.verticalWidgetSpacing),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   title,
//                   style: AppTextStyle().titleTextStyle(
//                     context: context,
//                     fontSize: 14,
//                   ),
//                 ),
//                 const Icon(Icons.keyboard_arrow_up),
//               ],
//             ),
//             const SizedBox(height: AppSize.verticalWidgetSpacing),
//             Text(
//               "No Data Found",
//               style: AppTextStyle().subTitleTextStyle(
//                 context: context,
//                 fontSize: 12,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/leave/hr_leave_provider.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/leave/tab_widget/all_team_leaves_tab/all_team_leaves_tab_screen.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/leave/tab_widget/leave_summary_tab/leave_summary_tab_screen.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/leave/tab_widget/my_requests_tab/my_leave_requests_tab_screen.dart';
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
                LeaveSummaryTabScreen(),
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
