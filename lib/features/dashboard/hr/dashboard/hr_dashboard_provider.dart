import 'package:flutter/material.dart';

class HrDashboardProvider extends ChangeNotifier {
  final BuildContext context;

  HrDashboardProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  void _init() {
    notifyListeners();
  }
}
