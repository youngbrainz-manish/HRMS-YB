import 'package:flutter/widgets.dart';
import 'package:hrms_yb/shared/utils/app_extensions.dart';

class AppTextStyle {
  headingTextStyle({
    required BuildContext context,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    bool? underline,
    Color? underLineColor,
  }) {
    return context.textTheme.displayLarge?.medium.copyWith(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      decoration: underline == true ? TextDecoration.underline : null,
      decorationColor: underLineColor ?? color,
    );
  }

  subHeadingTextStyle({
    required BuildContext context,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    bool? underline,
    Color? underLineColor,
  }) {
    return context.textTheme.titleLarge?.medium.copyWith(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      decoration: underline == true ? TextDecoration.underline : null,
      decorationColor: underLineColor ?? color,
    );
  }

  titleTextStyle({
    required BuildContext context,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    bool? underline,
    Color? underLineColor,
  }) {
    return context.textTheme.titleLarge?.medium.copyWith(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      decoration: underline == true ? TextDecoration.underline : null,
      decorationColor: underLineColor ?? color,
    );
  }

  subTitleTextStyle({
    required BuildContext context,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? height,
    bool? underline,
    Color? underLineColor,
  }) {
    return context.textTheme.titleMedium?.regular.copyWith(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height ?? 1.3,
      decoration: underline == true ? TextDecoration.underline : null,
      decorationColor: underLineColor ?? color,
    );
  }

  lableTextStyle({
    required BuildContext context,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? height,
    bool? underline,
    Color? underLineColor,
  }) {
    return context.textTheme.labelLarge?.regular.copyWith(
      color: color,
      fontSize: fontSize ?? 12,
      fontWeight: fontWeight,
      height: height ?? 1.1,
      decoration: underline == true ? TextDecoration.underline : null,
      decorationColor: underLineColor ?? color,
    );
  }
}
