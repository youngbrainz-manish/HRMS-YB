import 'package:flutter/material.dart';

class TeamRequestsTabProvider extends ChangeNotifier {
  final BuildContext context;

  TeamRequestsTabProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  void _init() {
    notifyListeners();
  }
}
