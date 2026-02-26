import 'package:flutter/material.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/core/theme/app_theme_provider.dart';
import 'package:hrms_yb/shared/utils/app_extensions.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:provider/provider.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final VoidCallback? onSuffixTap;
  final void Function()? onTap;
  final bool? isEnable;
  final String? headingText;
  final double? height;

  const CommonTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onSuffixTap,
    this.onTap,
    this.isEnable = true,
    this.headingText,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (headingText != null) ...[Text(headingText!), SizedBox(height: 4)],
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: height ?? 45,
            color: Colors.transparent,
            child: TextFormField(
              style: AppTextStyle().subTitleTextStyle(context: context, fontSize: 13),
              enabled: isEnable,
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              validator: validator,
              decoration: InputDecoration(
                labelText: labelText,
                hintText: hintText,
                hintStyle: context.textTheme.bodyLarge?.copyWith(color: Colors.grey, height: 1.3, fontSize: 14),
                labelStyle: context.textTheme.bodyLarge?.copyWith(
                  color: context.read<AppThemeProvider>().isDarkMode ? AppColors.whiteColor : AppColors.primaryColor,
                  fontSize: 15,
                ),
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon != null ? GestureDetector(onTap: onSuffixTap, child: Icon(suffixIcon)) : null,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.borderGrey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.borderGrey),
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
