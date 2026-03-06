import 'package:flutter/material.dart';

class MyLeaveRequestsTabProvider extends ChangeNotifier {
  final BuildContext context;

  MyLeaveRequestsTabProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  void _init() {
    notifyListeners();
  }
}
