import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/employee/add_employee_provider.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:hrms_yb/shared/widgets/common_button.dart';
import 'package:hrms_yb/shared/widgets/common_text_field.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:provider/provider.dart';

class AddEmployeeScreen extends StatelessWidget {
  const AddEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddEmployeeProvider(context: context),
      child: Consumer<AddEmployeeProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              leading: CommonWidget().backButton(onTap: () => GoRouter.of(context).pop()),
              title: Text(
                "Add Employee",
                style: AppTextStyle().titleTextStyle(context: context, color: AppColors.whiteColor),
              ),
            ),
            body: _buildBody(context: context, provider: provider),
          );
        },
      ),
    );
  }

  SingleChildScrollView _buildBody({required BuildContext context, required AddEmployeeProvider provider}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Card(
        margin: EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTextField(
                headingText: "Full Name *",
                controller: TextEditingController(),
                hintText: "Enter full name",
              ),
              const SizedBox(height: 16),

              CommonTextField(
                headingText: "Mobile Number *",
                controller: TextEditingController(),
                hintText: "Enter mobile number",
              ),
              const SizedBox(height: 16),

              CommonTextField(
                headingText: "Email (Optional)",
                controller: TextEditingController(),
                hintText: "Enter email address",
              ),
              const SizedBox(height: 16),

              CommonTextField(
                headingText: "Department *",
                controller: TextEditingController(),
                hintText: "Select department",
              ),
              const SizedBox(height: 16),

              CommonTextField(
                headingText: "Designation *",
                controller: TextEditingController(),
                hintText: "Select designation",
              ),
              const SizedBox(height: 16),

              CommonTextField(
                headingText: "Joining Date *",
                controller: provider.fromDate,
                hintText: "dd/mm/yyyy",
                isEnable: false,
                onTap: () async {
                  final date = await showDatePicker(
                    barrierColor: AppColors.borderGrey.withValues(alpha: 0.3),
                    context: context,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                    initialDate: DateTime.now(),
                  );

                  if (date != null) {
                    provider.fromDate = TextEditingController(text: "${date.day}/${date.month}/${date.year}");
                  }
                  provider.updateState();
                },
              ),
              const SizedBox(height: 16),

              Text("Employee Type *"),
              const SizedBox(height: 4),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.borderGrey, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                initialValue: provider.leaveType,
                hint: Text(
                  "Select leave type",
                  style: AppTextStyle().subTitleTextStyle(
                    context: provider.context,
                    color: AppColors.greyColor,
                    fontSize: 16,
                  ),
                ),
                items: ["Full Time", "Part Time", "Permanent"]
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e, style: AppTextStyle().subTitleTextStyle(context: provider.context)),
                      ),
                    )
                    .toList(),
                onChanged: (v) {
                  provider.leaveType = v;
                  provider.updateState();
                },
              ),
              SizedBox(height: AppSize().verticalWidgetSpacing * 1.5),

              /// INFO BOX
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xffEAF1FF),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xffC9D8FF)),
                ),
                child: const Text(
                  "Employee Code and Access PIN will be auto-generated after submission",
                  style: TextStyle(color: Color(0xff2946A6), fontSize: 14),
                ),
              ),

              const SizedBox(height: 24),

              /// BUTTON
              CommonButton(title: "Add Employee", onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
