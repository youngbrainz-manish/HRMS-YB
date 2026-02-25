import 'package:flutter/material.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';

class CustomToolBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const CustomToolBar({super.key, required this.title, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.menu, color: AppColors.whiteColor),
        onPressed: () => scaffoldKey.currentState?.openDrawer(),
      ),
      centerTitle: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Patel Manish Kumar",
            style: AppTextStyle().titleTextStyle(context: context, color: AppColors.whiteColor),
          ),
          Text(
            "Employee Id - EMP0002",
            style: AppTextStyle().lableTextStyle(context: context, color: AppColors.whiteColor),
          ),
        ],
      ),
      actions: [
        // ... your existing actions (Theme toggle, Profile, Notifications)
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
