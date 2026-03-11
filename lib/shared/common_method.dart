import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/network/authentication_data.dart';
import 'package:hrms_yb/core/router/app_router.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonMethod {
  Future<void> errageAllDataAndGotoLogin({
    required BuildContext context,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    AuthenticationData.token = "";
    AuthenticationData.userModel = null;
    if (context.mounted) {
      GoRouter.of(context).go(AppRouter.loginScreenRoute);
    }
  }

  static String formatDate(String date) {
    final parsedDate = DateTime.parse(date).toLocal();
    return DateFormat('dd MMM yyyy, hh:mm a').format(parsedDate);
  }
}
