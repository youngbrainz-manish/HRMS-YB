import 'package:flutter/material.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/core/theme/app_theme_provider.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
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
  final MainAxisAlignment mainAxisAlignment;

  const CommonButton({
    super.key,
    required this.title,
    required this.onTap,
    this.height = 46,
    this.borderRadius = 12,
    this.isLoading = false,
    this.color,
    this.borderColor,
    this.style,
    this.icon,
    this.titleColor,
    this.fontSize = 14,
    this.mainAxisAlignment = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<AppThemeProvider>().isDarkMode;
    return Card(
      margin: EdgeInsets.all(0),
      elevation: 5,
      shadowColor: context.read<AppThemeProvider>().isDarkMode ? AppColors.dartButtonColor : AppColors.primaryColor,
      child: Material(
        color: color ?? (isDark ? AppColors.dartButtonColor : AppColors.lightButtonColor),
        shadowColor: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          splashColor: isDark
              ? AppColors.primaryColor.withValues(alpha: 0.05)
              : AppColors.primaryDarkColor.withValues(alpha: 0.05),
          onTap: isLoading ? null : onTap,
          child: Container(
            width: double.infinity,
            height: height,
            decoration: BoxDecoration(
              border: Border.all(color: borderColor ?? Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Center(
              child: isLoading
                  ? SizedBox(child: CommonWidget().defaultLoader(color: AppColors.whiteColor))
                  : Row(
                      mainAxisAlignment: mainAxisAlignment,
                      children: [
                        if (icon != null) ...[icon!, SizedBox(width: 8)],
                        Text(
                          title,
                          style:
                              style ??
                              AppTextStyle().titleTextStyle(
                                context: context,
                                color: titleColor ?? AppColors.whiteColor,
                                fontSize: fontSize,
                              ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
