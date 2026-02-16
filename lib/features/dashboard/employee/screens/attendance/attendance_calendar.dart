import 'package:flutter/material.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/attendance/attendance_model.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:intl/intl.dart';

class AttendanceCalendar extends StatefulWidget {
  final List<AttendanceModel> attendanceList;
  final bool isDarkMode;

  const AttendanceCalendar({super.key, required this.attendanceList, required this.isDarkMode});

  @override
  State<AttendanceCalendar> createState() => _AttendanceCalendarState();
}

class _AttendanceCalendarState extends State<AttendanceCalendar> {
  late DateTime _selectedMonth;
  late Map<DateTime, AttendanceStatus> attendanceMap;

  @override
  void initState() {
    super.initState();
    _selectedMonth = DateTime(2025, 12);
    attendanceMap = buildAttendanceMap(widget.attendanceList);
  }

  void _changeMonth(int offset) {
    setState(() {
      _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month + offset);
    });
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateTime(_selectedMonth.year, _selectedMonth.month + 1, 0).day;

    final firstDayWeekday = DateTime(_selectedMonth.year, _selectedMonth.month, 1).weekday;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          /// Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: () => _changeMonth(-1), icon: const Icon(Icons.chevron_left)),
              Text(DateFormat('MMMM yyyy').format(_selectedMonth), style: Theme.of(context).textTheme.titleLarge),
              IconButton(onPressed: () => _changeMonth(1), icon: const Icon(Icons.chevron_right)),
            ],
          ),
          const SizedBox(height: 12),

          /// Week Labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const ["S", "M", "T", "W", "T", "F", "S"]
                .map(
                  (e) => Expanded(
                    child: Center(
                      child: Text(
                        e,
                        style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.grey),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 12),

          /// Calendar Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: daysInMonth + (firstDayWeekday % 7),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            itemBuilder: (context, index) {
              if (index < (firstDayWeekday % 7)) {
                return const SizedBox();
              }

              final day = index - (firstDayWeekday % 7) + 1;

              final currentDate = DateTime(_selectedMonth.year, _selectedMonth.month, day);

              final status = attendanceMap[currentDate];

              ///======================================================
              final now = DateTime.now();

              final today = DateTime(now.year, now.month, now.day);

              final cellDate = DateTime(currentDate.year, currentDate.month, currentDate.day);

              final bool isActiveDate = !cellDate.isAfter(today);

              ///======================================================

              return GestureDetector(
                onTap: () {
                  if (isActiveDate) {
                    debugPrint("Tapped = $today ::  cellDate = $cellDate");
                  } else {
                    // debugPrint("Tapped $currentDate");
                  }
                },
                child: _buildDayCard(
                  day: day,
                  status: status,
                  isActiveDate: isActiveDate,
                  isDarkMode: widget.isDarkMode,
                ),
              );
            },
          ),
          SizedBox(height: 16),

          ///Info
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              dayInfoWidget(context: context, color: AppColors.presentColor, title: "Present"),
              SizedBox(width: 16),
              dayInfoWidget(context: context, color: AppColors.absentColor, title: "Absent"),
              SizedBox(width: 16),
              dayInfoWidget(context: context, color: AppColors.holidayColor, title: "Holiday"),
              SizedBox(width: 16),
              dayInfoWidget(context: context, color: AppColors.leaveColor, title: "Leave"),
            ],
          ),
        ],
      ),
    );
  }

  Widget dayInfoWidget({required BuildContext context, required Color color, required String title}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(top: 3, right: 5),
          width: 15,
          height: 13,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
        ),
        Text(
          title,
          style: AppTextStyle().lableTextStyle(context: context, color: AppColors.greyColor),
        ),
      ],
    );
  }

  Widget _buildDayCard({
    required int day,
    AttendanceStatus? status,
    bool isActiveDate = false,
    required bool isDarkMode,
  }) {
    Color? bgColor = isDarkMode
        ? AppColors.darkGrey.withValues(alpha: 0.5)
        : AppColors.borderGrey.withValues(alpha: 0.8);
    Color? textColor = AppColors.greyColor;

    if (!isActiveDate) {
      bgColor = null;
      textColor = null;
    } else if (status != null && isActiveDate) {
      switch (status) {
        case AttendanceStatus.present:
          bgColor = AppColors.presentColor;
          textColor = AppColors.successPrimary;
          break;
        case AttendanceStatus.absent:
          bgColor = AppColors.absentColor.withValues(alpha: 0.4);
          textColor = AppColors.absentColor;
          break;
        case AttendanceStatus.holiday:
          bgColor = AppColors.holidayColor.withValues(alpha: 0.2);
          textColor = AppColors.holidayColor;
          break;
        case AttendanceStatus.leave:
          bgColor = AppColors.leaveColor.withValues(alpha: 0.3);
          textColor = AppColors.leaveColor;
          break;
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withValues(alpha: 0.2)),
      ),
      child: Center(
        child: Text(
          "$day",
          style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Map<DateTime, AttendanceStatus> buildAttendanceMap(List<AttendanceModel> list) {
    return {for (var item in list) DateTime(item.date.year, item.date.month, item.date.day): item.status};
  }
}
