import 'package:flutter/material.dart';

class AllTeamLeavesTabProvider extends ChangeNotifier {
  final BuildContext context;

  AllTeamLeavesTabProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  void _init() {
    notifyListeners();
  }
}
