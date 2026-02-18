import 'package:flutter/material.dart';

class EmployeeDetailsProvider extends ChangeNotifier {
  final BuildContext context;

  EmployeeDetailsProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  void _init() {
    notifyListeners();
  }
}

class DetailItem {
  final IconData icon;
  final Color color;
  final String label;
  final String value;

  DetailItem({required this.icon, required this.color, required this.label, required this.value});
}
