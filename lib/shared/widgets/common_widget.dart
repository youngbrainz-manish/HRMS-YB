import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/core/theme/app_theme_provider.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:provider/provider.dart';

enum SnackbarType { success, error, other }

class CommonWidget {
  static buildSvgImage({required String path, required Color color, double? height, double? width}) {
    return SvgPicture.asset(
      path,
      height: height ?? 22,
      width: width ?? 22,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  static backButton({required void Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        child: CircleAvatar(
          backgroundColor: AppColors.lightGrey.withValues(alpha: 0.3),
          child: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: AppColors.whiteColor),
        ),
      ),
    );
  }

  AppBar customAppBar({required BuildContext context, Widget? leftWidgetList}) {
    return AppBar(
      backgroundColor: context.read<AppThemeProvider>().isDarkMode
          ? AppColors.primaryDarkColor
          : AppColors.primaryColor,
      leading: Container(
        padding: EdgeInsets.all(2),
        margin: EdgeInsets.only(bottom: 8, top: 8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.read<AppThemeProvider>().isDarkMode ? AppColors.blackColor : AppColors.whiteColor,
        ),
        child: Image.asset("assets/images/transparant_logo.png"),
      ),
      centerTitle: false,
      titleSpacing: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [leftWidgetList ?? SizedBox()],
      ),
      actions: [
        GestureDetector(
          onTap: () {
            context.read<AppThemeProvider>().toggleTheme();
          },
          child: Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.read<AppThemeProvider>().isDarkMode ? AppColors.blackColor : AppColors.whiteColor,
            ),
            child: Icon(context.read<AppThemeProvider>().isDarkMode ? Icons.light_mode : Icons.dark_mode, size: 21),
          ),
        ),
        SizedBox(width: 8),
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.read<AppThemeProvider>().isDarkMode ? AppColors.blackColor : AppColors.whiteColor,
          ),
          child: Icon(Icons.notifications_none_sharp, size: 20),
        ),
        SizedBox(width: 8),
      ],
    );
  }

  static defaultLoader({Color? color}) {
    return Center(
      child: CircularProgressIndicator(padding: EdgeInsets.all(0), color: color ?? AppColors.primaryColor),
    );
  }

  static Future<bool?> showConfirmDialog({
    required BuildContext context,
    String title = "Confirmation",
    String message = "Are you sure?",
    String confirmText = "Yes",
    String cancelText = "Cancel",
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          iconPadding: EdgeInsets.all(0),
          insetPadding: EdgeInsets.all(0),
          titlePadding: EdgeInsets.all(0),
          buttonPadding: EdgeInsets.all(0),
          actionsPadding: EdgeInsets.all(0),
          contentPadding: EdgeInsets.all(0),
          content: Card(
            margin: EdgeInsets.all(0),
            elevation: 3,
            child: Container(
              padding: EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title, style: AppTextStyle().titleTextStyle(context: context)),
                  SizedBox(height: AppSize.verticalWidgetSpacing),
                  Text(message, style: AppTextStyle().subTitleTextStyle(context: context)),
                  SizedBox(height: AppSize.verticalWidgetSpacing * 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: () => Navigator.pop(context, false), child: Text(cancelText)),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => Navigator.pop(context, true),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(child: Text(confirmText)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static customSnackbar({
    required BuildContext context,
    String? title,
    required String description,
    required SnackbarType type,
    Widget? icon,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: AppSize.verticalWidgetSpacing / 2,
          left: AppSize.verticalWidgetSpacing / 2,
          right: AppSize.verticalWidgetSpacing / 2,
        ),
        backgroundColor: type == SnackbarType.success
            ? AppColors.successPrimary
            : type == SnackbarType.error
            ? AppColors.errorColor
            : AppColors.warningColor,
        content: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if ((title ?? "").isNotEmpty)
                    Text(
                      title!,
                      style: AppTextStyle().titleTextStyle(context: context, color: AppColors.whiteColor),
                    ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    style: AppTextStyle().subTitleTextStyle(context: context, color: AppColors.whiteColor),
                  ),
                ],
              ),
            ),
            icon ??
                Icon(
                  type == SnackbarType.success
                      ? Icons.check_circle_outline_rounded
                      : type == SnackbarType.error
                      ? Icons.nearby_error_rounded
                      : Icons.info,
                  color: AppColors.whiteColor,
                ),
          ],
        ),
      ),
    );
  }

  static butoonWithImageAndText({void Function()? onTap, Color? color, required Widget child}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        margin: EdgeInsets.all(0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          height: 46,
          width: double.infinity,
          child: child,
        ),
      ),
    );
  }
}
