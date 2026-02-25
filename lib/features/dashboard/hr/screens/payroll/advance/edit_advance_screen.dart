import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/payroll/advance/edit_advance_provider.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/widgets/app_filter_dropdown.dart';
import 'package:hrms_yb/shared/widgets/common_button.dart';
import 'package:hrms_yb/shared/widgets/common_text_field.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:provider/provider.dart';

class EditAdvanceScreen extends StatelessWidget {
  const EditAdvanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ChangeNotifierProvider(
        create: (_) => EditAdvanceProvider(context: context),
        child: Consumer<EditAdvanceProvider>(
          builder: (context, provider, child) {
            return Scaffold(
              appBar: AppBar(
                leading: CommonWidget().backButton(onTap: () => context.pop()),
                title: Text("Edit Advance"),
              ),
              body: SafeArea(
                child: _buildBody(context: context, provider: provider),
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget _buildBody({required BuildContext context, required EditAdvanceProvider provider}) {
  return Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.all(16),
    child: Column(
      children: [
        Card(
          margin: EdgeInsets.all(0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  AppFilterDropdown(
                    label: "Employee *",
                    value: provider.designation,
                    options: const ["All Employee", "Manish", "Ram", "Shyam", "Seeta"],
                    onChanged: (v) {
                      provider.designation = v;
                      provider.updateState();
                    },
                  ),
                  SizedBox(height: AppSize.verticalWidgetSpacing),
                  CommonTextField(
                    headingText: "Amount *",
                    controller: provider.amountController,
                    hintText: "Enter Amount",
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: AppSize.verticalWidgetSpacing),
                  SizedBox(height: AppSize.verticalWidgetSpacing),
                  CommonButton(title: "Save Advance", onTap: () {}),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
