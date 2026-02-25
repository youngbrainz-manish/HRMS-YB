import 'package:flutter/material.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';

class InfoTile extends StatelessWidget {
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final String title;
  final String value;

  const InfoTile({
    super.key,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyle().subTitleTextStyle(context: context, color: AppColors.greyColor),
              ),
              const SizedBox(height: 2),
              Text(value, style: AppTextStyle().titleTextStyle(context: context)),
            ],
          ),
        ],
      ),
    );
  }
}
