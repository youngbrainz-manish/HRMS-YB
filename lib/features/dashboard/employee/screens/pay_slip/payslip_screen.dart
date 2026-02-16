import 'package:flutter/material.dart';
import 'package:hrms_yb/core/theme/app_theme_provider.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:hrms_yb/shared/widgets/common_button.dart';
import 'package:provider/provider.dart';

class PayslipScreen extends StatelessWidget {
  final PayslipModel data;

  const PayslipScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// HEADER CARD
              _headerCard(context: context),
              const SizedBox(height: 16),

              /// EARNINGS
              _salaryCard(
                title: "Earnings",
                items: data.earnings,
                totalTitle: "Gross Salary",
                totalAmount: data.grossSalary,
                context: context,
              ),
              const SizedBox(height: 16),

              /// DEDUCTIONS
              _salaryCard(
                title: "Deductions",
                items: data.deductions,
                totalTitle: "Total Deductions",
                totalAmount: data.totalDeductions,
                amountColor: Colors.red,
                context: context,
              ),
              const SizedBox(height: 16),

              /// NET PAY
              _netPayCard(context: context),
              const SizedBox(height: 16),

              /// BUTTONS
              Row(
                children: [
                  Expanded(
                    child: CommonButton(
                      borderColor: AppColors.primaryColor,
                      color: AppColors.transparantColor,
                      title: "Download",
                      titleColor: context.watch<AppThemeProvider>().isDarkMode
                          ? AppColors.whiteColor
                          : AppColors.blackColor,
                      icon: Icon(
                        Icons.download,
                        color: context.watch<AppThemeProvider>().isDarkMode
                            ? AppColors.whiteColor
                            : AppColors.blackColor,
                      ),
                      onTap: () {},
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: CommonButton(
                      icon: Icon(Icons.share, color: AppColors.whiteColor),
                      title: "Share",
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // ================= HEADER =================

  Widget _headerCard({required BuildContext context}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: context.watch<AppThemeProvider>().isDarkMode
              ? [AppColors.dartButtonColor, AppColors.dartButtonColor.withValues(alpha: 0.5)]
              : [AppColors.primaryColor, AppColors.primaryColor.withValues(alpha: 0.5)],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payslip for",
            style: AppTextStyle().titleTextStyle(context: context, color: AppColors.whiteColor),
          ),
          const SizedBox(height: 8),
          Text(
            data.month,
            style: AppTextStyle().titleTextStyle(context: context, fontSize: 24, color: AppColors.whiteColor),
          ),
          const SizedBox(height: 8),
          Text(
            data.employeeName,
            style: AppTextStyle().lableTextStyle(context: context, color: AppColors.whiteColor),
          ),
        ],
      ),
    );
  }

  // ================= SALARY CARD =================

  Widget _salaryCard({
    required String title,
    required List<SalaryItem> items,
    required String totalTitle,
    required double totalAmount,
    Color? amountColor,
    required BuildContext context,
  }) {
    return Card(
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyle().titleTextStyle(context: context)),
            const SizedBox(height: 12),

            ...items.map(
              (e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(e.title, style: AppTextStyle().lableTextStyle(context: context)),
                    Text(
                      e.amount.rupee,
                      style: AppTextStyle().titleTextStyle(context: context, color: amountColor),
                    ),
                  ],
                ),
              ),
            ),

            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(totalTitle, style: AppTextStyle().titleTextStyle(context: context, fontSize: 18)),
                Text(
                  totalAmount.rupee,
                  style: AppTextStyle().titleTextStyle(context: context, fontSize: 18, color: amountColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ================= NET PAY =================

  Widget _netPayCard({required BuildContext context}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.watch<AppThemeProvider>().isDarkMode ? AppColors.successSecondary : AppColors.successPrimary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Net Pay",
            style: AppTextStyle().titleTextStyle(
              context: context,
              color: context.watch<AppThemeProvider>().isDarkMode ? AppColors.blackColor : AppColors.whiteColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            data.netPay.rupee,
            style: AppTextStyle().titleTextStyle(
              context: context,
              fontSize: 24,
              color: context.watch<AppThemeProvider>().isDarkMode ? AppColors.blackColor : AppColors.whiteColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Amount credited to your account",
            style: AppTextStyle().subTitleTextStyle(context: context, color: AppColors.greyColor),
          ),
        ],
      ),
    );
  }
}

class SalaryItem {
  final String title;
  final double amount;

  SalaryItem({required this.title, required this.amount});
}

class PayslipModel {
  final String month;
  final String employeeName;
  final List<SalaryItem> earnings;
  final List<SalaryItem> deductions;

  PayslipModel({required this.month, required this.employeeName, required this.earnings, required this.deductions});

  double get grossSalary => earnings.fold(0, (sum, e) => sum + e.amount);

  double get totalDeductions => deductions.fold(0, (sum, d) => sum + d.amount);

  double get netPay => grossSalary - totalDeductions;
}

extension CurrencyFormat on num {
  String get rupee => "₹${toStringAsFixed(0)}";
}
