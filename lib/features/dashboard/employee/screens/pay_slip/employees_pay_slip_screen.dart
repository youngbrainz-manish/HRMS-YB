import 'package:flutter/material.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/pay_slip/employees_pay_slip_provider.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/pay_slip/payslip_card.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/pay_slip/payslip_screen.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:provider/provider.dart';

class EmployeesPaySlipScreen extends StatelessWidget {
  const EmployeesPaySlipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EmployeesPaySlipProvider(context: context),
      child: Consumer<EmployeesPaySlipProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: SafeArea(child: _buildBody(provider: provider)),
          );
        },
      ),
    );
  }

  Widget _buildBody({required EmployeesPaySlipProvider provider}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      height: MediaQuery.of(provider.context).size.height,
      width: MediaQuery.of(provider.context).size.width,
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.all(0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text("Pay Slip History", style: AppTextStyle().titleTextStyle(context: provider.context)),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16),
                  itemCount: provider.dummyPayslips.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final payslip = provider.dummyPayslips[index];
                    return PayslipCard(
                      title: "${payslip.month} ${payslip.year}",
                      grossAmount: "Gross: ₹${payslip.grossSalary}",
                      netAmount: "₹${payslip.netPay}",
                      onTap: () {
                        // PayslipScreen(data: payslip)
                        // GoRouter.of(context).push(location)
                        final payslip = PayslipModel(
                          month: "October 2024",
                          employeeName: "Amit Kumar",
                          earnings: [
                            SalaryItem(title: "Basic Salary", amount: 35000),
                            SalaryItem(title: "HRA", amount: 14000),
                            SalaryItem(title: "Conveyance", amount: 1600),
                            SalaryItem(title: "Special Allowance", amount: 9400),
                          ],
                          deductions: [
                            SalaryItem(title: "Advance", amount: 0),
                            SalaryItem(title: "Professional Tax", amount: 200),
                          ],
                        );

                        Navigator.of(
                          context,
                        ).push(MaterialPageRoute(builder: (context) => PayslipScreen(data: payslip)));
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
