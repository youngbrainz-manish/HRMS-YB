import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/router/app_router.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/holiday/holiday_model.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/holiday/hr_holiday_provider.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:provider/provider.dart';

class HrHolidayScreen extends StatelessWidget {
  const HrHolidayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HrHolidayProvider(context: context),
      child: Consumer<HrHolidayProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: SafeArea(child: _buildBody(provider: provider)),
            floatingActionButton: provider.isLoading
                ? SizedBox()
                : FloatingActionButton(
                    onPressed: () async {
                      bool? ret = await GoRouter.of(context).push(AppRouter.addHolidayScreenRoute);
                      if (ret == true) {
                        provider.getHolidays();
                      }
                    },
                    child: Icon(Icons.add, color: AppColors.whiteColor),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildBody({required HrHolidayProvider provider}) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: provider.isLoading
                  ? CommonWidget().defaultLoader()
                  : ListView.builder(
                      itemCount: provider.holidays.length,
                      itemBuilder: (context, index) {
                        return HolidayCard(
                          holiday: provider.holidays[index],
                          onTap: () async {
                            final confirm = await CommonWidget().showConfirmDialog(
                              context: context,
                              title: "Delete Holiday",
                              message: "Do you want to delete this holiday?",
                            );
                            if (confirm == true) {
                              provider.deleteHoliday(id: provider.holidays[index].holidayId ?? 0);
                            }
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
        Visibility(
          visible: provider.isDeleting,
          child: Container(
            color: AppColors.primaryColor.withValues(alpha: 0.1),
            height: double.infinity,
            width: double.infinity,
            child: Center(child: CommonWidget().defaultLoader()),
          ),
        ),
      ],
    );
  }
}

class HolidayCard extends StatelessWidget {
  final HolidayModel holiday;
  final VoidCallback? onTap;

  const HolidayCard({super.key, required this.holiday, this.onTap});

  @override
  Widget build(BuildContext context) {
    final date = DateTime.tryParse(holiday.holidayDate ?? "");

    return Container(
      margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Card(
        margin: EdgeInsets.all(0),
        child: Container(
          padding: EdgeInsets.only(left: 14, top: 14, bottom: 14),
          child: Row(
            children: [
              /// DATE BOX
              Container(
                width: 60,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: _typeColor().withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text("${date?.day ?? '--'}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(_monthName(date), style: TextStyle(fontSize: 12, color: AppColors.greyColor)),
                  ],
                ),
              ),

              const SizedBox(width: 16),

              /// DETAILS
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(holiday.title ?? "", style: AppTextStyle().titleTextStyle(context: context)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.event, size: 16, color: AppColors.greyColor),
                        const SizedBox(width: 6),
                        Text(holiday.holidayDate ?? "", style: TextStyle(color: AppColors.greyColor, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),

              /// TYPE BADGE
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: _typeColor().withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      holiday.holidayType ?? "",
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _typeColor()),
                    ),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: Container(
                      margin: EdgeInsets.only(right: 10, top: 10),
                      child: Row(
                        children: [
                          Text(
                            "Remove",
                            style: AppTextStyle().subTitleTextStyle(context: context, color: AppColors.errorColor),
                          ),
                          Icon(Icons.delete, size: 20, color: AppColors.errorColor),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Holiday Type Color
  Color _typeColor() {
    switch (holiday.holidayType) {
      case "NATIONAL":
        return AppColors.successPrimary;
      case "COMPANY":
        return AppColors.blueColor;
      default:
        return AppColors.warningColor;
    }
  }

  String _monthName(DateTime? date) {
    if (date == null) return "--";
    const months = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
    return months[date.month - 1];
  }
}
