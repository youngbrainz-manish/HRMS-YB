import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReplyLeaveProvider extends ChangeNotifier {
  final BuildContext context;

  String title = "";
  String buttonTitle = "";
  Color? color;
  TextEditingController descriptionController = TextEditingController();

  ReplyLeaveProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var data = GoRouter.of(context).state.extra as Map;
      title = data['title'];
      buttonTitle = data['buttonTitle'];
      color = data['color'];
      _init();
    });
  }

  void _init() {
    notifyListeners();
  }
}
