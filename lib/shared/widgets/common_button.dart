import 'package:flutter/material.dart';
import 'package:hrms_yb/core/theme/app_theme_screen.dart';
import 'package:hrms_yb/core/theme/app_theme_provider.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:provider/provider.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final double height;
  final double borderRadius;
  final bool isLoading;
  final Color? color;
  final Color? borderColor;
  final TextStyle? style;
  final Widget? icon;
  final Color? titleColor;
  final double? fontSize;

  const CommonButton({
    super.key,
    required this.title,
    required this.onTap,
    this.height = 50,
    this.borderRadius = 12,
    this.isLoading = false,
    this.color,
    this.borderColor,
    this.style,
    this.icon,
    this.titleColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<AppThemeProvider>().isDarkMode;
    return Material(
      color: color ?? (isDark ? AppThemeScreen.dartButtonColor : AppThemeScreen.lightButtonColor),
      shadowColor: Colors.white,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        splashColor: isDark
            ? AppThemeScreen.primaryColor.withValues(alpha: 0.05)
            : AppThemeScreen.primaryDarkColor.withValues(alpha: 0.05),
        onTap: isLoading ? null : onTap,
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor ?? Colors.transparent, width: 1),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Center(
            child: isLoading
                ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null) ...[icon!, SizedBox(width: 12)],
                      Text(
                        title,
                        style:
                            style ??
                            AppTextStyle().titleTextStyle(
                              context: context,
                              color: titleColor ?? AppThemeScreen.whiteColor,
                              fontSize: fontSize,
                            ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
