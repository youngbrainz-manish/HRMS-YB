import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/holiday/add_holiday/add_holiday_provider.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/widgets/app_filter_dropdown.dart';
import 'package:hrms_yb/shared/widgets/common_button.dart';
import 'package:hrms_yb/shared/widgets/common_text_field.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:provider/provider.dart';

class AddHolidayScreen extends StatefulWidget {
  const AddHolidayScreen({super.key});

  @override
  State<AddHolidayScreen> createState() => _AddHolidayScreenState();
}

class _AddHolidayScreenState extends State<AddHolidayScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddHolidayProvider(context: context),
      child: Consumer<AddHolidayProvider>(
        builder: (context, provider, child) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: AppBar(
                leading: CommonWidget.backButton(onTap: () => context.pop()),
                title: const Text("Add Holiday"),
              ),

              body: _buildBody(context: context, provider: provider),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody({required BuildContext context, required AddHolidayProvider provider}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: AppSize.verticalWidgetSpacing / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSize.verticalWidgetSpacing),

          /// TITLE
          CommonTextField(
            controller: provider.titleController,
            hintText: "Enter holiday title",
            headingText: "Holiday Title",
          ),

          const SizedBox(height: AppSize.verticalWidgetSpacing / 2),

          /// DATE
          CommonTextField(
            controller: provider.dateController,
            hintText: "Select date",
            onTap: () {
              provider.selectDate(initDate: provider.dateController.text);
            },
            headingText: "Holiday Date",
            suffixIcon: Icons.calendar_today,
            isEnable: false,
          ),
          const SizedBox(height: 16),

          /// TYPE DROPDOWN
          AppFilterDropdown(
            label: "Holiday Type",
            value: provider.holidayType,
            options: provider.holidayTypeOptions,
            onChanged: (value) {
              provider.holidayType = value;
              provider.updateState();
            },
          ),

          const SizedBox(height: 30),

          /// SUBMIT BUTTON
          CommonButton(
            title: "Save Holiday",
            onTap: provider.submitHoliday,
            isLoading: provider.isLoading,
            loadingWidget: CommonWidget.buttonLoader(),
          ),
        ],
      ),
    );
  }
}
