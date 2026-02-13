import 'package:flutter/widgets.dart';
import 'package:hrms_yb/shared/utils/app_extensions.dart';

class AppTextStyle {
  headingTextStyle({required BuildContext context, Color? color, double? fontSize, FontWeight? fontWeight}) {
    return context.textTheme.displayLarge?.medium.copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);
  }

  subHeadingTextStyle({required BuildContext context, Color? color, double? fontSize, FontWeight? fontWeight}) {
    return context.textTheme.titleLarge?.medium.copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);
  }

  titleTextStyle({required BuildContext context, Color? color, double? fontSize, FontWeight? fontWeight}) {
    return context.textTheme.titleLarge?.medium.copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);
  }

  subTitleTextStyle({required BuildContext context, Color? color, double? fontSize, FontWeight? fontWeight}) {
    return context.textTheme.titleMedium?.regular.copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);
  }

  lableTextStyle({
    required BuildContext context,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? height,
  }) {
    return context.textTheme.labelLarge?.regular.copyWith(
      color: color,
      fontSize: fontSize ?? 14,
      fontWeight: fontWeight,
      height: height ?? 1.1,
    );
  }
}
