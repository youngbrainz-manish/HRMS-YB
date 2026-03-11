import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/network/authentication_data.dart';
import 'package:hrms_yb/core/router/app_router.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonMethod {
  Future<void> errageAllDataAndGotoLogin({required BuildContext context}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    AuthenticationData.token = "";
    AuthenticationData.userModel = null;
    if (context.mounted) {
      GoRouter.of(context).go(AppRouter.loginScreenRoute);
    }
  }

  static String formatDate(String date, {bool? dateOnly}) {
    final parsedDate = DateTime.parse(date).toLocal();
    if (dateOnly == true) {
      return DateFormat('dd MMM yyyy').format(parsedDate);
    } else {
      return DateFormat('dd MMM yyyy, hh:mm a').format(parsedDate);
    }
  }

  static InputDecoration dropDownDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),

      // hide error text
      errorStyle: const TextStyle(height: 2, fontSize: 0),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.borderGrey, width: 1),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.borderGrey, width: 1),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.primaryColor, width: 1),
      ),

      // red border when validation fails
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.errorColor, width: 1.5),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.errorColor, width: 1.5),
      ),
    );
  }
}
