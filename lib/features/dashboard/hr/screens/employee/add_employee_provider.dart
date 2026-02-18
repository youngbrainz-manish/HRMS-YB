import 'package:flutter/material.dart';

class AddEmployeeProvider extends ChangeNotifier {
  final BuildContext context;

  String? leaveType;
  TextEditingController fromDate = TextEditingController();

  AddEmployeeProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  void _init() {
    notifyListeners();
  }

  void updateState() {
    notifyListeners();
  }
}
