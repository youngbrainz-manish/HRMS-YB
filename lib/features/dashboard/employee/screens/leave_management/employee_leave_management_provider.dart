import 'package:flutter/material.dart';

class EmployeeLeaveProvider extends ChangeNotifier {
  final BuildContext context;

  bool isLoading = false;

  EmployeeLeaveProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }
  void refreshPage() {
    _init();
  }

  Future<void> _init() async {
    notifyListeners();
  }
}
