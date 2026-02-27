import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/network/authentication_data.dart';
import 'package:hrms_yb/core/router/app_router.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/profile/hr_profile_provider.dart';
import 'package:hrms_yb/shared/common_method.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:provider/provider.dart';

class HrProfileScreen extends StatelessWidget {
  const HrProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HrProfileProvider(context: context),
      child: Consumer<HrProfileProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: Scaffold(
              body: SafeArea(
                child: _buildBody(context: context, provider: provider),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody({required BuildContext context, required HrProfileProvider provider}) {
    return provider.isLoading
        ? CommonWidget.defaultLoader()
        : Column(
            children: [
              /// ===== PERSONAL INFO =====
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: AppSize.verticalWidgetSpacing),

                        ///===== PROFILE HEADER =====
                        Card(
                          margin: EdgeInsets.all(0),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 16),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: AppColors.lightGrey,
                                  backgroundImage: NetworkImage(
                                    AuthenticationData.userModel?.profilePhoto ?? "https://i.pravatar.cc/300",
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${AuthenticationData.userModel?.firstName} ${AuthenticationData.userModel?.lastName}",
                                      style: AppTextStyle().titleTextStyle(context: context),
                                    ),
                                    Text(
                                      AuthenticationData.userModel?.department?.designation ?? 'N/A',
                                      style: AppTextStyle().lableTextStyle(context: context),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: AppSize.verticalWidgetSpacing),

                        /// ===== PERSONAL INFO =====
                        _infoCard(
                          context: context,
                          title: "Personal Information",
                          children: [
                            InfoTile(title: "Employee ID", value: "HR-000${AuthenticationData.userModel?.userId}"),
                            InfoTile(title: "Department", value: "${AuthenticationData.userModel?.department}"),
                            InfoTile(
                              title: "Joining Date",
                              value: AuthenticationData.userModel!.department?.joiningDate ?? "N/A",
                            ),
                          ],
                        ),
                        SizedBox(height: AppSize.verticalWidgetSpacing),

                        /// ===== CONTACT INFO =====
                        _infoCard(
                          context: context,
                          title: "Contact Information",
                          children: [
                            InfoTile(title: "Email", value: AuthenticationData.userModel?.email ?? "N/A"),
                            InfoTile(title: "Phone", value: "+91 ${AuthenticationData.userModel?.mobileNo}"),
                            InfoTile(
                              title: "Location",
                              value: AuthenticationData.userModel?.addresses?.first.city ?? "N/A",
                            ),
                          ],
                        ),
                        SizedBox(height: AppSize.verticalWidgetSpacing),

                        /// ===== ACTIONS =====
                        _actionTile(
                          Icons.edit,
                          "Edit Profile",
                          onTap: () async {
                            var data = await GoRouter.of(context).push(AppRouter.editProfileScreenRoute);
                            if (data == true) {
                              provider.getProfileData();
                            }
                          },
                        ),
                        SizedBox(height: AppSize.verticalWidgetSpacing),
                        _actionTile(Icons.lock, "Change Password"), SizedBox(height: AppSize.verticalWidgetSpacing),
                        _actionTile(
                          Icons.logout,
                          "Logout",
                          onTap: () async {
                            if (context.mounted) {
                              await CommonMethod().errageAllDataAndGotoLogin(context: context);
                            }
                          },
                        ),
                        SizedBox(height: AppSize.verticalWidgetSpacing),
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
