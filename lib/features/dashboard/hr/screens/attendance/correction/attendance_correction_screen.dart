import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/attendance/correction/attendance_correction_provider.dart';
import 'package:hrms_yb/shared/widgets/app_multiline_textfield.dart';
import 'package:hrms_yb/shared/widgets/common_button.dart';
import 'package:hrms_yb/shared/widgets/common_text_field.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:provider/provider.dart';

class AttendanceCorrectionScreen extends StatelessWidget {
  const AttendanceCorrectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AttendanceCorrectionProvider(context: context),
      child: Consumer<AttendanceCorrectionProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              leading: CommonWidget().backButton(onTap: () => GoRouter.of(context).pop()),
              title: Text("Attendance Correction"),
            ),
            body: SafeArea(
              child: _buildbody(context: context, provider: provider),
            ),
          );
        },
      ),
    );
  }

  Widget _buildbody({required BuildContext context, required AttendanceCorrectionProvider provider}) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            margin: EdgeInsets.all(0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Employee *"),
                  const SizedBox(height: 4),
                  _employeeDropdown(provider: provider),
                  const SizedBox(height: 16),
                  CommonTextField(
                    headingText: "Date *",
                    controller: provider.dateController,
                    hintText: provider.dateController.text,
                    isEnable: false,
                    onTap: () {
                      provider.pickDate();
                    },
                  ),
                  const SizedBox(height: 16),

                  /// Punch Row
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonTextField(
                              headingText: "New Punch In",
                              controller: provider.punchInController,
                              hintText: "--:--",
                              isEnable: false,
                              onTap: () {
                                provider.selectTime(controller: provider.punchInController);
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CommonTextField(
                          headingText: "New Punch Out",
                          controller: provider.punchOutController,
                          hintText: "--:--",
                          isEnable: false,
                          onTap: () {
                            provider.selectTime(controller: provider.punchOutController);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  AppMultilineTextField(
                    headingText: "Reason for Correction *",
                    controller: provider.reasonController,
                    hint: "Enter reason for correction",
                  ),
                  SizedBox(height: 24),
                  CommonButton(title: "Save Correction", onTap: () {}),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _employeeDropdown({required AttendanceCorrectionProvider provider}) {
    return DropdownButtonFormField<String>(
      initialValue: provider.selectedEmployee,
      items: provider.employees.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: (value) {
        provider.selectedEmployee = value;
        provider.updateState();
      },
    );
  }
}
