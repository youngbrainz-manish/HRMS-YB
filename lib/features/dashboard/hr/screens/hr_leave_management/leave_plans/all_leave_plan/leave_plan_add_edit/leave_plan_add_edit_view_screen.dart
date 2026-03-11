import 'package:flutter/material.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/shared/common_method.dart';
import 'package:hrms_yb/shared/models/user_category_model.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:hrms_yb/shared/widgets/common_text_field.dart';
import 'package:provider/provider.dart';
import 'package:hrms_yb/shared/widgets/common_button.dart';
import 'leave_plan_add_edit_view_provider.dart';

class LeavePlanAddEditViewScreen extends StatelessWidget {
  const LeavePlanAddEditViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LeavePlanAddEditViewProvider(context: context),
      child: Consumer<LeavePlanAddEditViewProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(title: Text(provider.leavePlanId == null ? "Add Leave Plan" : "Edit Leave Plan")),
            body: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSize.verticalWidgetSpacing),
                    child: Column(
                      children: [
                        SizedBox(height: AppSize.verticalWidgetSpacing),
                        Expanded(
                          child: Form(
                            key: provider.formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// PLAN NAME
                                  CommonTextField(
                                    controller: provider.planNameController,
                                    hintText: "Enter Plan Name",
                                    headingText: "Plan Name",
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Plan name required";
                                      }
                                      return null;
                                    },
                                  ),

                                  const SizedBox(height: 16),

                                  /// START DATE
                                  CommonTextField(
                                    controller: provider.startDateController,
                                    hintText: "Select Start Date",
                                    headingText: "Start Date",
                                    isEnable: false,
                                    onTap: () {
                                      provider.selectDate(context, provider.startDateController);
                                    },
                                  ),

                                  const SizedBox(height: 16),

                                  /// END DATE
                                  CommonTextField(
                                    controller: provider.endDateController,
                                    hintText: "Select End Date",
                                    headingText: "End Date",
                                    isEnable: false,
                                    onTap: () {
                                      provider.selectDate(context, provider.endDateController);
                                    },
                                  ),

                                  const SizedBox(height: 16),

                                  /// USER CATEGORY
                                  Text(
                                    "User Category",
                                    style: AppTextStyle().lableTextStyle(context: context, fontSize: 11),
                                  ),
                                  SizedBox(height: 4),
                                  SizedBox(
                                    height: 47,
                                    child: DropdownButtonFormField<UserCategoryModel>(
                                      padding: EdgeInsets.zero,
                                      initialValue: provider.selectedUserCategory,
                                      hint: const Text("Select Category"),
                                      validator: (value) {
                                        if (value == null) {
                                          return ""; // triggers red border but hides text
                                        }
                                        return null;
                                      },
                                      decoration: CommonMethod.dropDownDecoration(),
                                      items: provider.userCategoryList
                                          .map((e) => DropdownMenuItem(value: e, child: Text(e.categoryName ?? "")))
                                          .toList(),
                                      onChanged: (v) {
                                        provider.selectedUserCategory = v;
                                        provider.updateState();
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: AppSize.verticalWidgetSpacing),

                                  /// LEAVE TYPES HEADER
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Leave Types",
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                      IconButton(onPressed: provider.addLeaveType, icon: const Icon(Icons.add_circle)),
                                    ],
                                  ),

                                  const SizedBox(height: 10),

                                  /// LEAVE TYPES LIST
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: provider.leaveTypes.length,
                                    itemBuilder: (context, index) {
                                      final item = provider.leaveTypes[index];

                                      return Card(
                                        margin: const EdgeInsets.only(bottom: AppSize.verticalWidgetSpacing),
                                        child: Padding(
                                          padding: const EdgeInsets.all(AppSize.verticalWidgetSpacing),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              /// LEAVE TYPE
                                              CommonTextField(
                                                controller: item.leaveTypeController,
                                                hintText: "Leave Type (CASUAL, SICK)",
                                                headingText: "Leave Type",
                                              ),

                                              const SizedBox(height: AppSize.verticalWidgetSpacing),

                                              /// LEAVE COUNT
                                              CommonTextField(
                                                controller: item.leaveCountController,
                                                hintText: "Leave Count",
                                                headingText: "Leave Count",
                                                keyboardType: TextInputType.number,
                                              ),
                                              SizedBox(height: AppSize.verticalWidgetSpacing),
                                              Row(
                                                children: [
                                                  Checkbox(
                                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                    visualDensity: VisualDensity.compact,
                                                    value: item.carryForward,
                                                    onChanged: (val) {
                                                      item.carryForward = val ?? false;
                                                      provider.updateState();
                                                    },
                                                  ),
                                                  Text("Carry Forward"),
                                                  SizedBox(width: AppSize.verticalWidgetSpacing),
                                                  if (item.carryForward)
                                                    Expanded(
                                                      child: CommonTextField(
                                                        controller: item.maxCarryForwardController,
                                                        hintText: "Max Carry Forward",
                                                        labelText: "Max Carry Forward",
                                                        keyboardType: TextInputType.number,
                                                      ),
                                                    ),
                                                ],
                                              ),
                                              SizedBox(height: AppSize.verticalWidgetSpacing / 2),

                                              /// IS PAID
                                              Row(
                                                children: [
                                                  Checkbox(
                                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                    visualDensity: VisualDensity.compact,
                                                    value: item.isPaid,
                                                    onChanged: (val) {
                                                      item.isPaid = val ?? false;
                                                      provider.updateState();
                                                    },
                                                  ),
                                                  Text("Is Paid Leave"),
                                                ],
                                              ),

                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    provider.removeLeaveType(index);
                                                  },
                                                  child: Card(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadiusGeometry.circular(6),
                                                    ),
                                                    color: AppColors.hintColor,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8),
                                                      child: Icon(Icons.delete, color: Colors.red),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),

                                  const SizedBox(height: 30),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: AppSize.verticalWidgetSpacing / 2),

                        /// SUBMIT BUTTON
                        CommonButton(
                          title: provider.leavePlanId == null ? "Create Plan" : "Update Plan",
                          isLoading: provider.isLoading,
                          onTap: () {
                            provider.saveLeavePlan();
                          },
                        ),
                        SizedBox(height: AppSize.verticalWidgetSpacing / 2),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
