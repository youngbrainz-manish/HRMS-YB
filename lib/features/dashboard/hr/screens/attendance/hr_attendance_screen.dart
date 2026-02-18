import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/router/app_router.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/attendance/hr_attendance_provider.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:hrms_yb/shared/widgets/common_button.dart';
import 'package:hrms_yb/shared/widgets/common_text_field.dart';
import 'package:provider/provider.dart';

class HrAttendanceScreen extends StatelessWidget {
  const HrAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HrAttendanceProvider(context: context),
      child: Consumer<HrAttendanceProvider>(
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

  Widget _buildBody({required BuildContext context, required HrAttendanceProvider provider}) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          /// Select Date
          _dateSelector(provider: provider),
          SizedBox(height: AppSize().verticalWidgetSpacing),

          /// Status Cards
          Row(
            children: const [
              Expanded(child: StatusCard("1", "Present", AppColors.successPrimary)),
              SizedBox(width: 12),
              Expanded(child: StatusCard("0", "Absent", AppColors.errorColor)),
              SizedBox(width: 12),
              Expanded(child: StatusCard("0", "On Leave", AppColors.warningColor)),
            ],
          ),

          SizedBox(height: AppSize().verticalWidgetSpacing),

          /// Buttons
          Row(
            children: [
              Expanded(
                child: CommonButton(
                  icon: Icon(Icons.edit, color: AppColors.whiteColor),
                  title: "Mark Correction",
                  onTap: () async {
                    await GoRouter.of(context).push(AppRouter.attendanceCorrectionScreenRoute);
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CommonButton(
                  icon: Icon(Icons.more_time_sharp),
                  title: "Audit Log",
                  style: AppTextStyle().subTitleTextStyle(context: context),
                  onTap: () async {
                    await GoRouter.of(context).push(AppRouter.attendanceAuditLogScreenRoute);
                  },
                  color: AppColors.transparantColor,
                  borderColor: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSize().verticalWidgetSpacing),

          /// List
          Card(
            margin: EdgeInsets.all(0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Attendance Records", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: provider.attendanceList.length,
                    itemBuilder: (_, index) {
                      return AttendanceCard(data: provider.attendanceList[index]);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Date Selector
  Widget _dateSelector({required HrAttendanceProvider provider}) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: CommonTextField(
          headingText: "Select Date",
          controller: provider.dateController,
          hintText: "Select Date",
          isEnable: false,
          onTap: () {
            provider.pickDate();
          },
        ),
      ),
    );
  }
}

class AttendanceCard extends StatelessWidget {
  final AttendanceModel data;

  const AttendanceCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.greyColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          /// Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.name, style: AppTextStyle().titleTextStyle(context: context)),
                  Text("${data.department} • ${data.empId}", style: AppTextStyle().lableTextStyle(context: context)),
                ],
              ),
              _statusChip(data.status),
            ],
          ),

          const SizedBox(height: 16),

          /// Punch Section
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.greyColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _timeColumn(context: context, title: "Punch In", value: data.punchIn),
                _timeColumn(context: context, title: "Punch Out", value: data.punchOut),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _timeColumn({required BuildContext context, required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyle().lableTextStyle(context: context)),
        const SizedBox(height: 4),
        Text(value, style: AppTextStyle().titleTextStyle(context: context)),
      ],
    );
  }

  Widget _statusChip(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.successPrimary.withValues(alpha: .15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(status, style: const TextStyle(color: AppColors.successPrimary)),
    );
  }
}

class StatusCard extends StatelessWidget {
  final String count;
  final String title;
  final Color color;

  const StatusCard(this.count, this.title, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(color: color.withValues(alpha: .15), borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Text(count, style: AppTextStyle().titleTextStyle(context: context)),
            const SizedBox(height: 4),
            Text(
              title,
              style: AppTextStyle().lableTextStyle(context: context, color: color),
            ),
          ],
        ),
      ),
    );
  }
}
