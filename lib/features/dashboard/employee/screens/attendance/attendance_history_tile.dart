import 'package:flutter/material.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/attendance/attendance_history_model.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/attendance/attendance_model.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:intl/intl.dart';

class AttendanceHistoryTile extends StatelessWidget {
  final AttendanceHistoryModel model;
  final bool? isLastItem;
  final bool isDarkMode;

  const AttendanceHistoryTile({super.key, required this.model, this.isLastItem, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final dateText = DateFormat('MMM d, yyyy').format(model.date);

    return Card(
      color: isDarkMode ? AppColors.darkGrey.withValues(alpha: 0.5) : AppColors.lightGrey.withValues(alpha: 0.5),
      child: Container(
        height: 80,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// LEFT CONTENT
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(dateText, style: AppTextStyle().subTitleTextStyle(context: context)),
                      const SizedBox(height: 4),
                      Text(
                        "In: ${_formatTime(model.checkIn)}   "
                        "Out: ${_formatTime(model.checkOut)}",
                        style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                ),

                /// RIGHT SIDE
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _statusBadge(model.status),
                    if (model.workedHours != null) ...[
                      SizedBox(height: 6),
                      Text("${model.workedHours} hrs", style: AppTextStyle().lableTextStyle(context: context)),
                    ],
                  ],
                ),
              ],
            ),
            // if (!(isLastItem == true)) ...[
            //   Padding(
            //     padding: const EdgeInsets.symmetric(vertical: 4),
            //     child: Divider(color: AppColors.borderGrey),
            //   ),
            // ],
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime? time) {
    if (time == null) return "-";
    return DateFormat('HH:mm').format(time);
  }

  Widget _statusBadge(AttendanceStatus status) {
    Color bg;
    Color text;
    String label;

    switch (status) {
      case AttendanceStatus.present:
        bg = AppColors.presentColor;
        text = AppColors.successPrimary;
        label = "P";
        break;

      case AttendanceStatus.holiday:
        bg = AppColors.holidayColor.withValues(alpha: 0.5);
        text = AppColors.holidayColor;
        label = "H";
        break;

      case AttendanceStatus.absent:
        bg = AppColors.absentColor.withValues(alpha: 0.5);
        text = AppColors.absentColor;
        label = "A";
        break;

      case AttendanceStatus.leave:
        bg = AppColors.leaveColor.withValues(alpha: 0.5);
        text = AppColors.leaveColor;
        label = "L";
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
      child: Text(
        label,
        style: TextStyle(color: text, fontWeight: FontWeight.bold),
      ),
    );
  }
}
