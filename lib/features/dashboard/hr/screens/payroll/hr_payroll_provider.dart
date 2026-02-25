import 'package:flutter/material.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';

class HrPayrollProvider extends ChangeNotifier {
  final BuildContext context;

  final List<Employee> employees = [
    Employee("Amit Kumar", "Sales", "EMP003", 60000, 5000, 200),
    Employee("Sneha Reddy", "Sales", "EMP004", 45000, 0, 200),
    Employee("Vikram Singh", "Accounts", "EMP005", 75000, 10000, 200),
  ];

  HrPayrollProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  void _init() {
    notifyListeners();
  }

  void selectMonth({required BuildContext context}) async {
    final date = await showDatePicker(
      barrierColor: AppColors.borderGrey.withValues(alpha: 0.3),
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );
    debugPrint("Selected Month: ${date?.month}/${date?.year}");
  }
}

class Employee {
  final String name;
  final String dept;
  final String id;
  final int gross;
  final int advance;
  final int tax;

  Employee(this.name, this.dept, this.id, this.gross, this.advance, this.tax);

  int get netPay => gross - advance - tax;
}
