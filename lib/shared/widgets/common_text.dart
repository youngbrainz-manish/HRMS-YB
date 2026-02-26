import 'package:flutter/material.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';

class CommonTextWidget {
  buildButtonText({required BuildContext context, required String title, TextStyle? textStyle}) {
    return Text(
      title,
      style: textStyle ?? AppTextStyle().titleTextStyle(context: context, fontSize: 14, color: AppColors.whiteColor),
    );
  }
}
