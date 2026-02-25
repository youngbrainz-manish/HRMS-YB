import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/holiday/emp_holiday_provider.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/holiday/hr_holiday_screen.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:provider/provider.dart';

class HolidayScreen extends StatelessWidget {
  const HolidayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EmpHolidayProvider(context: context),
      child: Consumer<EmpHolidayProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              leading: CommonWidget().backButton(onTap: () => context.pop()),
              title: Text("Holiday List"),
            ),
            body: _buildBody(context: context, provider: provider),
          );
        },
      ),
    );
  }

  Widget _buildBody({required BuildContext context, required EmpHolidayProvider provider}) {
    if (provider.isLoading) {
      return CommonWidget().defaultLoader();
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
            itemCount: provider.holidays.length + (provider.isPaginationLoading ? 1 : 0),
            itemBuilder: (context, index) {
              /// bottom pagination loader
              if (index >= provider.holidays.length) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              return HolidayCard(holiday: provider.holidays[index]);
            },
          ),
        ),

        /// deleting overlay loader
        if (provider.isDeleting)
          Container(
            color: AppColors.primaryColor.withValues(alpha: 0.1),
            child: Center(child: CommonWidget().defaultLoader()),
          ),
      ],
    );
  }
}
