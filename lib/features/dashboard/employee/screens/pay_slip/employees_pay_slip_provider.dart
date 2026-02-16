import 'package:flutter/material.dart';
import 'package:hrms_yb/models/payslip_model.dart';

class EmployeesPaySlipProvider extends ChangeNotifier {
  final BuildContext context;

  final List<PayslipModel> dummyPayslips = [
    PayslipModel(id: "1", month: "November", year: 2024, grossSalary: 60000, netPay: 54800),
    PayslipModel(id: "2", month: "October", year: 2024, grossSalary: 60000, netPay: 59800),
    PayslipModel(id: "3", month: "September", year: 2024, grossSalary: 60000, netPay: 56800),
  ];

  EmployeesPaySlipProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  void _init() {
    notifyListeners();
  }
}
