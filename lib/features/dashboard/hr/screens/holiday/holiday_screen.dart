import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/network/authentication_data.dart';
import 'package:hrms_yb/core/router/app_router.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/holiday/holiday_model.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/holiday/holiday_provider.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:provider/provider.dart';

class HolidayScreen extends StatelessWidget {
  const HolidayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HolidayProvider(context: context),
      child: Consumer<HolidayProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              leading: CommonWidget.backButton(
                onTap: () => GoRouter.of(context).pop(),
              ),
              title: Text("Holidays"),
            ),
            body: SafeArea(child: _buildBody(provider)),
            floatingActionButton:
                (provider.isLoading ||
                    (AuthenticationData.userModel?.department?.deptName
                            ?.toLowerCase() !=
                        "hr"))
                ? const SizedBox()
                : FloatingActionButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onPressed: () async {
                      HolidayModel? ret = await GoRouter.of(
                        context,
                      ).push(AppRouter.addHolidayScreenRoute);
                      if (ret != null) {
                        provider.holidays.add(ret);
                        provider.updateState();
                      }
                    },
                    child: const Icon(Icons.add, color: AppColors.whiteColor),
                  ),
          );
        },
      ),
    );
  }

  /// ================= BODY =================

  Widget _buildBody(HolidayProvider provider) {
    if (provider.isLoading) {
      return CommonWidget.defaultLoader();
    }

    if (provider.holidays.isEmpty) {
      return const Center(child: Text("No Holidays Found"));
    }

    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () => provider.getHolidays(),
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 16),
            physics: AlwaysScrollableScrollPhysics(),
            controller: provider.scrollController,
            itemCount:
                provider.holidays.length +
                (provider.isPaginationLoading ? 1 : 0),
            itemBuilder: (context, index) {
              /// bottom pagination loader
              if (index >= provider.holidays.length) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              return HolidayCard(
                provider: provider,
                holiday: provider.holidays[index],
              );
            },
          ),
        ),

        /// deleting overlay loader
        if (provider.isDeleting)
          Container(
            color: AppColors.primaryColor.withValues(alpha: 0.1),
            child: Center(child: CommonWidget.defaultLoader()),
          ),
      ],
    );
  }
}

/// ===============================================================
/// HOLIDAY CARD
/// ===============================================================

class HolidayCard extends StatelessWidget {
  final HolidayModel holiday;
  final HolidayProvider provider;

  const HolidayCard({super.key, required this.holiday, required this.provider});

  @override
  Widget build(BuildContext context) {
    final date = DateTime.tryParse(holiday.holidayDate ?? "");

    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Card(
        margin: EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 0,
            top: 16,
            bottom: 14,
          ),
          child: Row(
            children: [
              /// DATE BOX
              Stack(
                clipBehavior: Clip.none,
                alignment: AlignmentGeometry.bottomCenter,
                children: [
                  Container(
                    width: 60,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: _typeColor().withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${date?.day ?? '--'}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _monthName(date),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: _typeColor().withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Text(
                        holiday.holidayType ?? "",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: _typeColor(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),

              /// DETAILS
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      holiday.title ?? "",
                      style: AppTextStyle().titleTextStyle(context: context),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.event, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          holiday.holidayDate ?? "",
                          style: AppTextStyle().lableTextStyle(
                            context: context,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              ///Menu
              Visibility(
                visible:
                    (AuthenticationData.userModel?.department?.deptName
                        ?.toLowerCase() ==
                    "hr"),
                child: CommonWidget.commonPopupMenu(
                  menuItem: const [
                    PopupMenuItem(value: 1, child: Text('Edit')),
                    PopupMenuItem(value: 2, child: Text('Delete')),
                  ],
                  onSelected: (value) async {
                    if (value == 1) {
                      HolidayModel? holidayModel = await GoRouter.of(context)
                          .push(
                            AppRouter.addHolidayScreenRoute,
                            extra: {"holiday": holiday},
                          );
                      if (holidayModel != null) {
                        provider.replaceHoliday(updatedHoliday: holidayModel);
                      }
                    } else if (value == 2) {
                      final confirm = await CommonWidget.showConfirmDialog(
                        context: context,
                        title: "Delete Holiday",
                        message: "Do you want to delete this holiday?",
                      );
                      if (confirm == true) {
                        provider.deleteHoliday(id: holiday.holidayId ?? 0);
                      }
                    }
                  },
                ),
              ),
              SizedBox(width: 12),
            ],
          ),
        ),
      ),
    );
  }

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

    const months = [
      "JAN",
      "FEB",
      "MAR",
      "APR",
      "MAY",
      "JUN",
      "JUL",
      "AUG",
      "SEP",
      "OCT",
      "NOV",
      "DEC",
    ];

    return months[date.month - 1];
  }
}
