import 'package:flutter/material.dart';

class EditAdvanceProvider extends ChangeNotifier {
  final BuildContext context;

  String designation = "All Employee";

  TextEditingController amountController = TextEditingController();

  EditAdvanceProvider({required this.context}) {
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
