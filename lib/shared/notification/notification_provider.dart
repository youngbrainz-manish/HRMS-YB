import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  final BuildContext context;

  List<HrNotification> notifications = [
    HrNotification(
      id: "1",
      title: "Leave Approved",
      message: "Your leave request has been approved by HR.",
      time: DateTime.now().subtract(Duration(minutes: 10)),
      type: "leave",
      isRead: false,
    ),
    HrNotification(
      id: "2",
      title: "Attendance Reminder",
      message: "Don't forget to check-in today.",
      time: DateTime.now().subtract(Duration(hours: 2)),
      type: "attendance",
      isRead: true,
    ),
    HrNotification(
      id: "3",
      title: "Salary Credited",
      message: "Your salary for February has been credited.",
      time: DateTime.now().subtract(Duration(days: 1)),
      type: "salary",
      isRead: false,
    ),
  ];

  NotificationProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  void _init() {
    notifyListeners();
  }
}

class HrNotification {
  final String id;
  final String title;
  final String message;
  final DateTime time;
  final String type;
  final bool isRead;

  HrNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    required this.isRead,
  });
}
