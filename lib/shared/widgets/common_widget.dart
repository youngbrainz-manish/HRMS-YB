import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hrms_yb/core/theme/app_theme_screen.dart';

class CommonWidget {
  Widget buildSvgImage({required String path, required Color color, double? height, double? width}) {
    return SvgPicture.asset(
      path,
      height: height ?? 22,
      width: width ?? 22,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  Widget backButton({required void Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: AppThemeScreen.lightGrey.withValues(alpha: 0.3),
          child: Icon(Icons.arrow_back_ios_new_rounded, size: 24),
        ),
      ),
    );
  }
}
