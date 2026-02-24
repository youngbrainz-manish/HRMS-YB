import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/core/theme/app_theme_provider.dart';
import 'package:provider/provider.dart';

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
        padding: const EdgeInsets.all(10.0),
        child: CircleAvatar(
          backgroundColor: AppColors.lightGrey.withValues(alpha: 0.3),
          child: Icon(Icons.arrow_back_ios_new_rounded, size: 22, color: AppColors.whiteColor),
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

  Widget defaultLoader({Color? color}) {
    return Center(child: CircularProgressIndicator(color: color ?? AppColors.primaryColor));
  }
}
