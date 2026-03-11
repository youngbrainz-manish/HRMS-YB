import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/core/theme/app_theme_provider.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/hr_leave_management/leave_tracker/add_update_leave/add_update_leave_provider.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/hr_leave_management/leave_tracker/models/leave_plan_data_model.dart';
import 'package:hrms_yb/shared/common_method.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:hrms_yb/shared/widgets/app_multiline_textfield.dart';
import 'package:hrms_yb/shared/widgets/common_button.dart';
import 'package:hrms_yb/shared/widgets/common_text_field.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:provider/provider.dart';

class AddUpdateLeaveScreen extends StatelessWidget {
  const AddUpdateLeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddUpdateLeaveProvider(context: context),
      child: Consumer<AddUpdateLeaveProvider>(
        builder: (context, provider, child) {
          return Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  leading: CommonWidget.backButton(onTap: () => GoRouter.of(context).pop()),
                  title: Text("Add Update Leave"),
                ),
                body: SafeArea(
                  child: _buildBody(context: context, provider: provider),
                ),
              ),
              if (provider.isSubmittingLeave) ...[CommonWidget.fullScreenLoader()],
            ],
          );
        },
      ),
    );
  }

  Widget _buildBody({required BuildContext context, required AddUpdateLeaveProvider provider}) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: provider.isLoading
          ? CommonWidget.defaultLoader()
          : Padding(
              padding: const EdgeInsets.all(AppSize.verticalWidgetSpacing),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: AppSize.verticalWidgetSpacing),
                  Card(
                    margin: EdgeInsets.all(0),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSize.verticalWidgetSpacing),
                      child: Column(
                        children: [
                          /// Leave Type
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              SizedBox(
                                height: 47,
                                child: DropdownButtonFormField<LeaveType>(
                                  padding: EdgeInsets.zero,
                                  initialValue: provider.selectedLeaveType,
                                  hint: const Text("Select Leave Type"),
                                  validator: (value) {
                                    if (value == null) {
                                      return ""; // triggers red border but hides text
                                    }
                                    return null;
                                  },
                                  decoration: CommonMethod.dropDownDecoration(),
                                  items: provider.leaveTypes
                                      .map((e) => DropdownMenuItem(value: e, child: Text(e.leaveType ?? '')))
                                      .toList(),
                                  onChanged: (v) {
                                    provider.selectedLeaveType = v;
                                    provider.updateState();
                                  },
                                ),
                              ),
                              Positioned(
                                top: -6,
                                left: 10,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                    color: context.read<AppThemeProvider>().isDarkMode
                                        ? AppColors.blackColor
                                        : AppColors.whiteColor,
                                  ),
                                  child: Text(
                                    "Select Leave Type *",
                                    style: AppTextStyle().lableTextStyle(
                                      context: provider.context,
                                      color: context.read<AppThemeProvider>().isDarkMode
                                          ? AppColors.lightGrey
                                          : AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: AppSize.verticalWidgetSpacing),

                          ///Start and End Date
                          Row(
                            children: [
                              Expanded(
                                child: CommonTextField(
                                  isEnable: false,
                                  controller: provider.startDateController,
                                  hintText: "Start Date *",
                                  labelText: "Start Date *",
                                  suffixIcon: Icons.date_range_outlined,
                                  onTap: () async {
                                    await provider.selectDate(
                                      context: context,
                                      controller: provider.startDateController,
                                      initialDate: provider.startDateController.text.isNotEmpty
                                          ? DateTime.parse(provider.startDateController.text)
                                          : DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2035),
                                    );
                                    provider.endDateController.text = '';
                                    provider.updateState();
                                  },
                                ),
                              ),
                              SizedBox(width: AppSize.verticalWidgetSpacing),
                              Expanded(
                                child: CommonTextField(
                                  isEnable: false,
                                  controller: provider.endDateController,
                                  hintText: "End Date *",
                                  labelText: "End Date *",
                                  suffixIcon: Icons.date_range_outlined,
                                  onTap: () {
                                    provider.selectEndDate();
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: AppSize.verticalWidgetSpacing),
                          AppMultilineTextField(
                            hint: "Describe reason for leave.....",
                            controller: provider.descriptionTextController,
                          ),
                          SizedBox(height: AppSize.verticalWidgetSpacing),
                          Row(
                            children: [
                              Text(
                                "Leave applying for : ${provider.totalDays} days",
                                style: AppTextStyle().lableTextStyle(context: context),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: AppSize.verticalWidgetSpacing * 2),
                  Row(
                    children: [
                      Expanded(
                        child: CommonButton(
                          title: "Cancel",
                          onTap: () => GoRouter.of(context).pop(),
                          color: AppColors.transparantColor,
                          titleColor: context.read<AppThemeProvider>().isDarkMode
                              ? AppColors.whiteColor
                              : AppColors.blackColor,
                        ),
                      ),
                      SizedBox(width: AppSize.verticalWidgetSpacing),
                      Expanded(
                        child: CommonButton(
                          title: "Submit",
                          onTap: () {
                            provider.submitLeave();
                          },
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
