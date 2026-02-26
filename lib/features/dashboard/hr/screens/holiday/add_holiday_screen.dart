import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/network/dio_api_request.dart';
import 'package:hrms_yb/core/network/dio_api_services.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/widgets/app_filter_dropdown.dart';
import 'package:hrms_yb/shared/widgets/common_button.dart';
import 'package:hrms_yb/shared/widgets/common_text_field.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';

class AddHolidayScreen extends StatefulWidget {
  const AddHolidayScreen({super.key});

  @override
  State<AddHolidayScreen> createState() => _AddHolidayScreenState();
}

class _AddHolidayScreenState extends State<AddHolidayScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  String holidayType = "COMPANY";
  bool isLoading = false;

  List<String> holidayTypeOptions = ["COMPANY", "NATIONAL", "FESTIVAL"];

  /// Select Date
  Future<void> selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
    );

    if (date != null) {
      dateController.text =
          "${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}";
    }
  }

  /// Submit Form
  Future<void> submit() async {
    if (dateController.text.isEmpty || titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }
    setState(() => isLoading = true);
    Map<String, dynamic> requestData = {
      "holiday_date": dateController.text,
      "holiday_type": holidayType,
      "title": titleController.text,
    };

    var response = await DioApiRequest().postCommonApiCall(requestData, DioApiServices.addHoliday);

    if (response?.data != null && response?.data['success'] == true) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context, // ignore: use_build_context_synchronously
        ).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.successPrimary,
            content: Text(response?.data['message'] ?? "Holiday Added Successfully"),
          ),
        );
        // ignore: use_build_context_synchronously
        context.pop(true);
      } else {
        ScaffoldMessenger.of(
          context, // ignore: use_build_context_synchronously
        ).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.errorColor,
            content: Text(response?.data['message'] ?? "Failed to add holiday"),
          ),
        );
      }
    }
    if (!context.mounted) return;
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: CommonWidget.backButton(onTap: () => context.pop()),
          title: const Text("Add Holiday"),
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: AppSize.verticalWidgetSpacing / 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSize.verticalWidgetSpacing),

              /// TITLE
              CommonTextField(
                controller: titleController,
                hintText: "Enter holiday title",
                headingText: "Holiday Title",
              ),

              const SizedBox(height: AppSize.verticalWidgetSpacing / 2),

              /// DATE
              CommonTextField(
                controller: dateController,
                hintText: "Select date",
                onTap: selectDate,
                headingText: "Holiday Date",
                suffixIcon: Icons.calendar_today,
                isEnable: false,
              ),
              const SizedBox(height: 16),

              /// TYPE DROPDOWN
              AppFilterDropdown(
                label: "Holiday Type",
                value: holidayType,
                options: holidayTypeOptions,
                onChanged: (value) {
                  setState(() => holidayType = value);
                },
              ),

              const SizedBox(height: 30),

              /// SUBMIT BUTTON
              CommonButton(title: "Save Holiday", onTap: submit, isLoading: isLoading),
            ],
          ),
        ),
      ),
    );
  }
}
