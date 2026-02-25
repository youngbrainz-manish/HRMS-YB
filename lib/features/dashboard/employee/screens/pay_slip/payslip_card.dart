import 'package:flutter/material.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';

class PayslipCard extends StatelessWidget {
  final String title;
  final String grossAmount;
  final String netAmount;
  final VoidCallback? onTap;

  const PayslipCard({super.key, required this.title, required this.grossAmount, required this.netAmount, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.borderGrey),
        ),
        child: Row(
          children: [
            /// LEFT ICON BOX
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: AppColors.holidayColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.description_outlined, color: AppColors.holidayColor, size: 28),
            ),

            const SizedBox(width: 16),

            /// TITLE + GROSS
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyle().titleTextStyle(context: context)),
                  const SizedBox(height: 4),
                  Text(grossAmount, style: AppTextStyle().subTitleTextStyle(context: context)),
                ],
              ),
            ),

            /// NET PAY
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  netAmount,
                  style: AppTextStyle().titleTextStyle(context: context, color: AppColors.successPrimary),
                ),
                const SizedBox(height: 4),
                Text("Net Pay", style: AppTextStyle().lableTextStyle(context: context)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
