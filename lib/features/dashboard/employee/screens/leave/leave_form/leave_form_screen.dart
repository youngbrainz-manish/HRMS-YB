import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/theme/app_theme_provider.dart';
import 'package:hrms_yb/core/theme/app_theme_screen.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/leave/leave_form/leave_form_provider.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:hrms_yb/shared/widgets/common_button.dart';
import 'package:hrms_yb/shared/widgets/common_text_field.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:provider/provider.dart';

class LeaveFormScreen extends StatelessWidget {
  const LeaveFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: ChangeNotifierProvider(
        create: (_) => LeaveFormProvider(context: context),
        child: Consumer<LeaveFormProvider>(
          builder: (context, provider, child) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Apply for leave"),
                centerTitle: false,
                leading: CommonWidget().backButton(onTap: () => GoRouter.of(context).pop()),
              ),
              body: SafeArea(child: _buildBody(provider: provider)),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody({required LeaveFormProvider provider}) {
    bool isDarkMode = provider.context.watch<AppThemeProvider>().isDarkMode;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Card(
        margin: EdgeInsets.all(0),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Leave Type
              Text("Leave Type *", style: AppTextStyle().titleTextStyle(context: provider.context)),
              const SizedBox(height: 4),

              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    // borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppThemeScreen.borderGrey, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppThemeScreen.primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                initialValue: provider.leaveType,
                hint: Text(
                  "Select leave type",
                  style: AppTextStyle().subTitleTextStyle(
                    context: provider.context,
                    color: AppThemeScreen.greyColor,
                    fontSize: 16,
                  ),
                ),
                items: ["Casual", "Sick", "Earned"]
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

              /// Dates
              Row(
                children: [
                  Expanded(
                    child: CommonTextField(
                      labelText: "From Date *",
                      controller: provider.fromDate,
                      hintText: "dd/mm/yyyy",
                      isEnable: false,
                      onTap: () async {
                        FocusScope.of(provider.context).requestFocus(FocusNode());
                        await provider.pickDate(provider.fromDate);
                      },
                    ),
                  ),
                  SizedBox(width: AppSize().verticalWidgetSpacing),
                  Expanded(
                    child: CommonTextField(
                      labelText: "To Date *",
                      controller: provider.toDate,
                      hintText: "dd/mm/yyyy",
                      isEnable: false,
                      onTap: () async {
                        FocusScope.of(provider.context).requestFocus(FocusNode());
                        await provider.pickDate(provider.toDate);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSize().verticalWidgetSpacing),

              /// Reason
              // Text("Reason *", style: AppTextStyle().titleTextStyle(context: provider.context)),
              // const SizedBox(height: 4),
              // CommonTextField(controller: provider.reason, hintText: "Enter reason for leave"),
              SizedBox(height: AppSize().verticalWidgetSpacing),

              /// Attachment (Optional)
              Text("Attachment (Optional)", style: AppTextStyle().titleTextStyle(context: provider.context)),
              const SizedBox(height: 4),

              CommonButton(
                icon: Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Icon(
                    Icons.attach_file_rounded,
                    color: isDarkMode ? AppThemeScreen.lightGrey : AppThemeScreen.darkGrey,
                  ),
                ),
                title: "Upload Document",
                onTap: () async {
                  provider.pickFile();
                },
                borderColor: AppThemeScreen.greyColor,
                borderRadius: 12,
                color: AppThemeScreen.transparantColor,
                titleColor: isDarkMode ? AppThemeScreen.lightGrey : AppThemeScreen.darkGrey,
                fontSize: 14,
              ),
              Visibility(
                visible: provider.pickedFile.isNotEmpty,
                child: Container(
                  margin: EdgeInsets.only(top: 12),
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.pickedFile.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(right: 6),
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                        clipBehavior: Clip.antiAlias,
                        child: Image.file(provider.pickedFile[index], height: 90, width: 90, fit: BoxFit.cover),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: AppSize().verticalWidgetSpacing),
              SizedBox(height: AppSize().verticalWidgetSpacing),

              /// Submit Button
              CommonButton(title: "Submit Leave Application", onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
