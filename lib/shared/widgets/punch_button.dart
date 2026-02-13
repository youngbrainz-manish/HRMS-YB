import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hrms_yb/core/theme/app_theme_screen.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';

class PunchButton extends StatelessWidget {
  final double size;
  final double progress; // 0 → 1
  final VoidCallback? onTap;
  final bool? isDarkMode;
  final Widget icon;
  final String title;
  final String lable;
  final Color titleColor;

  const PunchButton({
    super.key,
    this.size = 160,
    this.progress = 0.75,
    this.onTap,
    this.isDarkMode,
    required this.icon,
    required this.title,
    required this.lable,
    required this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: (isDarkMode ?? false) ? AppThemeScreen.blackColor : AppThemeScreen.greyColor.withValues(alpha: 0.2),
          shape: BoxShape.circle,
        ),
        height: size,
        width: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            /// Progress Ring
            CustomPaint(size: Size(size, size), painter: _ProgressPainter(progress)),

            /// Main Circle (Neumorphism)
            Container(
              height: size * .80,
              width: size * .80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xffE6E7EB),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 10, offset: const Offset(4, 4)),
                  BoxShadow(color: Colors.white, blurRadius: 10, offset: Offset(-4, -4)),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 16),
                  Text(
                    title,
                    style: AppTextStyle().titleTextStyle(context: context, color: AppThemeScreen.blackColor),
                  ),
                  SizedBox(height: 8),
                  Text(
                    lable,
                    style: AppTextStyle().titleTextStyle(context: context, color: titleColor, fontSize: 15),
                  ),
                  icon,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressPainter extends CustomPainter {
  final double progress;

  _ProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.width / 2) - 2;

    /// Background circle
    final bgPaint = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;

    canvas.drawCircle(center, radius, bgPaint);

    /// Progress arc
    final progressPaint = Paint()
      // ..color = const Color(0xffE89B1B)
      ..color = AppThemeScreen.primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    const startAngle = -pi / 2; // start from top
    final sweepAngle = 2 * pi * progress;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
