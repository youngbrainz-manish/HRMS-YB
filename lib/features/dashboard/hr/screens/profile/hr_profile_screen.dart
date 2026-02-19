import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/router/app_router.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';

class HrProfileScreen extends StatelessWidget {
  const HrProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CommonWidget().backButton(onTap: () => context.pop()),
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Amisha Patel",
                  style: AppTextStyle().titleTextStyle(context: context, color: AppColors.whiteColor),
                ),
                Text(
                  "HR Manager",
                  style: AppTextStyle().lableTextStyle(context: context, color: AppColors.whiteColor),
                ),
              ],
            ),
            Spacer(),
            const SizedBox(width: 16),
            const CircleAvatar(radius: 20, backgroundImage: NetworkImage("https://i.pravatar.cc/300")),
          ],
        ),
        elevation: 0,
      ),
      body: Scaffold(body: SafeArea(child: _buildBody(context))),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        /// ===== PERSONAL INFO =====
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _infoCard(
                    context: context,
                    title: "Personal Information",
                    children: const [
                      InfoTile(title: "Employee ID", value: "HR-1023"),
                      InfoTile(title: "Department", value: "Human Resources"),
                      InfoTile(title: "Joining Date", value: "12 Jan 2022"),
                    ],
                  ),
                  SizedBox(height: AppSize().verticalWidgetSpacing),

                  /// ===== CONTACT INFO =====
                  _infoCard(
                    context: context,
                    title: "Contact Information",
                    children: const [
                      InfoTile(title: "Email", value: "hr@company.com"),
                      InfoTile(title: "Phone", value: "+91 9876543210"),
                      InfoTile(title: "Location", value: "Ahmedabad"),
                    ],
                  ),
                  SizedBox(height: AppSize().verticalWidgetSpacing),

                  /// ===== COMPANY INFO =====
                  _infoCard(
                    context: context,
                    title: "Company Details",
                    children: const [
                      InfoTile(title: "Company", value: "Your Business Pvt Ltd"),
                      InfoTile(title: "Branch", value: "Head Office"),
                    ],
                  ),
                  SizedBox(height: AppSize().verticalWidgetSpacing),

                  /// ===== ACTIONS =====
                  _actionTile(
                    Icons.edit,
                    "Edit Profile",
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.editProfileScreenRoute);
                    },
                  ),
                  SizedBox(height: AppSize().verticalWidgetSpacing),
                  _actionTile(Icons.lock, "Change Password"), SizedBox(height: AppSize().verticalWidgetSpacing),
                  _actionTile(Icons.logout, "Logout"), SizedBox(height: AppSize().verticalWidgetSpacing),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// ---------- INFO CARD ----------
  static Widget _infoCard({required BuildContext context, required String title, required List<Widget> children}) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyle().titleTextStyle(context: context)),
            const Divider(),
            ...children,
          ],
        ),
      ),
    );
  }

  /// ---------- ACTION TILE ----------
  static Widget _actionTile(IconData icon, String title, {VoidCallback? onTap}) {
    return Card(
      margin: EdgeInsets.all(0),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primaryColor),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

/// ---------- INFO TILE ----------
class InfoTile extends StatelessWidget {
  final String title;
  final String value;

  const InfoTile({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyle().lableTextStyle(context: context)),
          Text(value, style: AppTextStyle().titleTextStyle(context: context, fontSize: 15)),
        ],
      ),
    );
  }
}
