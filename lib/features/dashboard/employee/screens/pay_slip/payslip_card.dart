import 'package:flutter/material.dart';
import 'package:hrms_yb/core/theme/app_theme_screen.dart';
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
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppThemeScreen.borderGrey),
        ),
        child: Row(
          children: [
            /// LEFT ICON BOX
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: AppThemeScreen.holidayColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.description_outlined, color: AppThemeScreen.holidayColor, size: 28),
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
                  style: AppTextStyle().titleTextStyle(context: context, color: AppThemeScreen.successPrimary),
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
