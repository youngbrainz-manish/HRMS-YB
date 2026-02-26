import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/router/app_router.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/core/theme/app_theme_provider.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/payroll/hr_payroll_provider.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:hrms_yb/shared/widgets/common_button.dart';
import 'package:hrms_yb/shared/widgets/common_text_field.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:provider/provider.dart';

class HrPayrollScreen extends StatelessWidget {
  const HrPayrollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HrPayrollProvider(context: context),
      child: Consumer<HrPayrollProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: SafeArea(
              child: _buildBody(context: context, provider: provider),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody({required BuildContext context, required HrPayrollProvider provider}) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Month Selector
            _selectMonth(provider: provider),
            SizedBox(height: AppSize.verticalWidgetSpacing),

            _buildSummaryCard(context: context),
            SizedBox(height: AppSize.verticalWidgetSpacing),

            _anctionButtons(context),
            SizedBox(height: AppSize.verticalWidgetSpacing),

            _employeeList(context, provider),
          ],
        ),
      ),
    );
  }

  Widget _selectMonth({required HrPayrollProvider provider}) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: CommonTextField(
          headingText: "Select Month",
          controller: TextEditingController(),
          hintText: "Select Month",
          isEnable: false,
          onTap: () {
            provider.selectMonth(context: provider.context);
            // Show Month Picker
          },
        ),
      ),
    );
  }

  Widget _employeeList(BuildContext context, HrPayrollProvider provider) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Payroll Details", style: AppTextStyle().titleTextStyle(context: context)),
            ...provider.employees.map((e) => _buildEmployeeCard(context: context, emp: e)),
          ],
        ),
      ),
    );
  }

  Widget _anctionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CommonButton(
            icon: Icon(Icons.currency_rupee_sharp),
            title: "Edit Advance",
            onTap: () async {
              await GoRouter.of(context).push(AppRouter.editAdvanceScreenRoute);
            },
            color: AppColors.transparantColor,
            titleColor: context.read<AppThemeProvider>().isDarkMode ? AppColors.whiteColor : AppColors.blackColor,
            borderColor: context.read<AppThemeProvider>().isDarkMode
                ? AppColors.dartButtonColor
                : AppColors.primaryColor,
            fontSize: 16,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: CommonButton(
            icon: CommonWidget.buildSvgImage(
              path: "assets/svg-icons/dashboard-icons/pay-slip-icon.svg",
              color: AppColors.whiteColor,
            ),
            title: "Generate All",
            onTap: () {},
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard({required BuildContext context}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: context.read<AppThemeProvider>().isDarkMode ? AppColors.dartButtonColor : AppColors.primaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Total Payroll for December 2024",
            style: AppTextStyle().subTitleTextStyle(context: context, color: AppColors.whiteColor),
          ),
          SizedBox(height: 8),
          Text(
            "₹164,400",
            style: AppTextStyle().headingTextStyle(context: context, color: AppColors.whiteColor),
          ),
          SizedBox(height: 4),
          Text(
            "3 employees",
            style: AppTextStyle().lableTextStyle(context: context, color: AppColors.whiteColor),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeCard({required BuildContext context, required Employee emp}) {
    return Card(
      margin: EdgeInsets.only(top: 16),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.hintColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(emp.name, style: AppTextStyle().subTitleTextStyle(context: context)),
            Text("${emp.dept} • ${emp.id}", style: AppTextStyle().lableTextStyle(context: context, fontSize: 12)),
            SizedBox(height: AppSize.verticalWidgetSpacing),
            _payRow("Gross Salary", "₹${emp.gross}", context: context),
            _payRow("Advance", "-₹${emp.advance}", color: AppColors.errorColor, context: context),
            _payRow("Professional Tax", "-₹${emp.tax}", color: AppColors.errorColor, context: context),
            Divider(height: 24),
            _payRow("Net Pay", "₹${emp.netPay}", color: AppColors.successPrimary, isBold: true, context: context),
            SizedBox(height: AppSize.verticalWidgetSpacing),
            CommonButton(title: "View Payslip Preview", onTap: () {}, height: 40, fontSize: 15),
          ],
        ),
      ),
    );
  }

  Widget _payRow(String label, String value, {Color? color, bool isBold = false, required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyle().lableTextStyle(context: context)),
          Text(
            value,
            style: TextStyle(color: color, fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
            // style: AppTextStyle().lableTextStyle(context: context),
          ),
        ],
      ),
    );
  }
}
