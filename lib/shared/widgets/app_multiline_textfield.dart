import 'package:flutter/material.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';

class AppMultilineTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? hint;
  final int minLines;
  final int maxLines;
  final String? Function(String?)? validator;
  final bool enabled;
  final String? headingText;

  const AppMultilineTextField({
    super.key,
    required this.controller,
    this.label,
    this.hint,
    this.minLines = 3,
    this.maxLines = 6,
    this.validator,
    this.enabled = true,
    this.headingText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (headingText != null) ...[Text(headingText!), SizedBox(height: 4)],
        TextFormField(
          controller: controller,
          minLines: minLines,
          maxLines: maxLines,
          enabled: enabled,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,

          decoration: InputDecoration(
            hintStyle: AppTextStyle().lableTextStyle(context: context, fontSize: 16, color: AppColors.greyColor),
            labelText: label,
            hintText: hint,
            alignLabelWithHint: true,

            contentPadding: const EdgeInsets.all(16),

            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColors.borderGrey),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
            ),
          ),

          validator: validator,
        ),
      ],
    );
  }
}
