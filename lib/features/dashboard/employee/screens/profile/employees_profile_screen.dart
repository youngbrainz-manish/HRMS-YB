import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/network/authentication_data.dart';
import 'package:hrms_yb/core/router/app_router.dart';
import 'package:hrms_yb/core/theme/app_theme_provider.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/features/dashboard/employee/dashboard/employee_dashboard_provider.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/profile/employees_profile_provider.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/profile/info_tile.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/profile/section_dard.dart';
import 'package:hrms_yb/shared/common_method.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:provider/provider.dart';

class EmployeesProfileScreen extends StatefulWidget {
  const EmployeesProfileScreen({super.key});

  @override
  State<EmployeesProfileScreen> createState() => _EmployeesProfileScreenState();
}

class _EmployeesProfileScreenState extends State<EmployeesProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EmployeesProfileProvider(context: context),
      child: Consumer<EmployeesProfileProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: SafeArea(child: _buildBody(provider: provider)),
          );
        },
      ),
    );
  }

  Widget _buildBody({required EmployeesProfileProvider provider}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: provider.isLoading
          ? CommonWidget.defaultLoader()
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: AppSize.verticalWidgetSpacing),

                  ///===== PROFILE HEADER =====
                  Card(
                    margin: EdgeInsets.all(0),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: AppColors.lightGrey,
                            backgroundImage: NetworkImage(
                              AuthenticationData.userModel?.profilePhoto ??
                                  "https://i.pravatar.cc/300",
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${AuthenticationData.userModel?.firstName} ${AuthenticationData.userModel?.lastName}",
                                style: AppTextStyle().titleTextStyle(
                                  context: context,
                                ),
                              ),
                              Text(
                                AuthenticationData
                                        .userModel
                                        ?.department
                                        ?.designation ??
                                    'N/A',
                                style: AppTextStyle().lableTextStyle(
                                  context: context,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(height: 70),
                              GestureDetector(
                                onTap: () async {
                                  var data = await GoRouter.of(
                                    context,
                                  ).push(AppRouter.editProfileScreenRoute);
                                  if (data == true) {
                                    provider.getProfileData();
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 9),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.primaryColor,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.edit_note_outlined,
                                        color: AppColors.primaryColor,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "Edit",
                                        style: AppTextStyle().subTitleTextStyle(
                                          context: context,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: AppSize.verticalWidgetSpacing),

                  /// PERSONAL DETAILS
                  SectionCard(
                    title: "Personal Details",
                    children: [
                      InfoTile(
                        icon: Icons.person_outline,
                        bgColor: AppColors.primaryColor.withValues(alpha: 0.1),
                        iconColor: AppColors.primaryColor,
                        title: "Full Name",
                        value:
                            "${provider.employee?.firstName ?? ''} ${provider.employee?.lastName ?? ''}",
                      ),
                      InfoTile(
                        icon: Icons.cake,
                        bgColor: AppColors.primaryColor.withValues(alpha: 0.1),
                        iconColor: AppColors.primaryColor,
                        title: "Birth Date",
                        value: provider.employee?.birthday ?? '--',
                      ),
                      InfoTile(
                        icon: Icons.transgender_outlined,
                        bgColor: AppColors.primaryColor.withValues(alpha: 0.1),
                        iconColor: AppColors.primaryColor,
                        title: "Gender",
                        value: (provider.employee?.gender ?? '--')
                            .toUpperCase(),
                      ),
                      InfoTile(
                        icon: Icons.wc_outlined,
                        bgColor: AppColors.primaryColor.withValues(alpha: 0.1),
                        iconColor: AppColors.primaryColor,
                        title: "Maritial Status",
                        value: provider.employee?.maritialStatus ?? '--',
                      ),
                      InfoTile(
                        icon: Icons.bloodtype,
                        bgColor: AppColors.primaryColor.withValues(alpha: 0.1),
                        iconColor: AppColors.primaryColor,
                        title: "Blood Group",
                        value: provider.employee?.bloodGroup ?? '--',
                      ),
                    ],
                  ),
                  SizedBox(height: AppSize.verticalWidgetSpacing),

                  /// ===== Education INFO =====
                  SectionCard(
                    title: "Education Details",
                    children: [
                      InfoTile(
                        icon: Icons.account_balance_outlined,
                        bgColor: AppColors.primaryColor.withValues(alpha: 0.1),
                        iconColor: AppColors.primaryColor,
                        title: "Institution Name",
                        value:
                            provider
                                .employee!
                                .education
                                ?.first
                                .institutionName ??
                            "NA",
                      ),
                      InfoTile(
                        icon: Icons.school_outlined,
                        bgColor: AppColors.primaryColor.withValues(alpha: 0.1),
                        iconColor: AppColors.primaryColor,
                        title: "Institution Type",
                        value:
                            provider
                                .employee!
                                .education
                                ?.first
                                .typeOfInstitution ??
                            "NA",
                      ),
                      InfoTile(
                        icon: Icons.menu_book_outlined,
                        bgColor: AppColors.primaryColor.withValues(alpha: 0.1),
                        iconColor: AppColors.primaryColor,
                        title: "Degree",
                        value:
                            provider.employee!.education?.first.degree ?? "NA",
                      ),
                      InfoTile(
                        icon: Icons.workspace_premium_outlined,
                        bgColor: AppColors.primaryColor.withValues(alpha: 0.1),
                        iconColor: AppColors.primaryColor,
                        title: "Specialization",
                        value:
                            provider
                                .employee!
                                .education
                                ?.first
                                .specialization ??
                            "NA",
                      ),
                      InfoTile(
                        icon: Icons.percent,
                        bgColor: AppColors.primaryColor.withValues(alpha: 0.1),
                        iconColor: AppColors.primaryColor,
                        title: "Grade",
                        value:
                            provider.employee!.education?.first.grade ?? "NA",
                      ),
                    ],
                  ),
                  SizedBox(height: AppSize.verticalWidgetSpacing),

                  /// ===== CONTACT INFO =====
                  SectionCard(
                    title: "Contact Details",
                    children: [
                      InfoTile(
                        icon: Icons.call_outlined,
                        bgColor: AppColors.primaryColor.withValues(alpha: 0.1),
                        iconColor: AppColors.primaryColor,
                        title: "Mobile",
                        value: provider.employee?.mobileNo ?? "NA",
                      ),
                      InfoTile(
                        icon: Icons.email_outlined,
                        bgColor: AppColors.primaryColor.withValues(alpha: 0.1),
                        iconColor: AppColors.primaryColor,
                        title: "Email",
                        value: provider.employee?.email ?? "NA",
                      ),
                      InfoTile(
                        icon: Icons.pin_drop,
                        bgColor: AppColors.primaryColor.withValues(alpha: 0.1),
                        iconColor: AppColors.primaryColor,
                        title: "Current Address",
                        value: provider.currentAddress ?? "NA",
                      ),
                      InfoTile(
                        icon: Icons.location_city,
                        bgColor: AppColors.primaryColor.withValues(alpha: 0.1),
                        iconColor: AppColors.primaryColor,
                        title: "Permanent Address",
                        value: provider.permanentAddress ?? "NA",
                      ),
                    ],
                  ),
                  SizedBox(height: AppSize.verticalWidgetSpacing),

                  /// ===== DEPARTMENT INFO =====
                  SectionCard(
                    title: "Work Details",
                    children: [
                      InfoTile(
                        icon: Icons.apartment_outlined,
                        bgColor: AppColors.primaryColor.withValues(alpha: 0.1),
                        iconColor: AppColors.primaryColor,
                        title: "Dept Name",
                        value: provider.employee!.department?.deptName ?? "NA",
                      ),
                      InfoTile(
                        icon: Icons.badge_outlined,
                        bgColor: AppColors.primaryColor.withValues(alpha: 0.1),
                        iconColor: AppColors.primaryColor,
                        title: "Designation",
                        value:
                            provider.employee!.department?.designation ?? "NA",
                      ),
                      InfoTile(
                        icon: Icons.work_outline,
                        bgColor: AppColors.primaryColor.withValues(alpha: 0.1),
                        iconColor: AppColors.primaryColor,
                        title: "Employement Type",
                        value:
                            provider.employee?.department?.employmentType ??
                            "NA",
                      ),
                      InfoTile(
                        icon: Icons.groups_outlined,
                        bgColor: AppColors.primaryColor.withValues(alpha: 0.1),
                        iconColor: AppColors.primaryColor,
                        title: "Employement Category",
                        value:
                            provider.employee?.department?.categoryName ?? "NA",
                      ),
                      InfoTile(
                        icon: Icons.currency_bitcoin,
                        bgColor: AppColors.primaryColor.withValues(alpha: 0.1),
                        iconColor: AppColors.primaryColor,
                        title: "Salary",
                        value: (provider.employee?.department?.salary ?? "NA")
                            .toString(),
                      ),
                      InfoTile(
                        icon: Icons.calendar_month,
                        bgColor: AppColors.primaryColor.withValues(alpha: 0.1),
                        iconColor: AppColors.primaryColor,
                        title: "Joining Date",
                        value:
                            (provider.employee?.department?.joiningDate ?? "NA")
                                .toString(),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSize.verticalWidgetSpacing),

                  /// Holiday List
                  CommonWidget.butoonWithImageAndText(
                    onTap: () async {
                      GoRouter.of(context).push(AppRouter.holidayScreenRoute);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.beach_access, color: AppColors.primaryColor),
                        SizedBox(width: 10),
                        Text(
                          "View All Holidays",
                          style: AppTextStyle().titleTextStyle(
                            context: context,
                            fontSize: 14,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 20,
                          color: AppColors.primaryColor,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSize.verticalWidgetSpacing),

                  /// Company Structure
                  CommonWidget.butoonWithImageAndText(
                    onTap: () async {
                      await GoRouter.of(
                        context,
                      ).push(AppRouter.hierarchyScreenRoute);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.account_tree, color: AppColors.primaryColor),
                        SizedBox(width: 10),
                        Text(
                          "Company Structure",
                          style: AppTextStyle().titleTextStyle(
                            context: context,
                            fontSize: 14,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 20,
                          color: AppColors.primaryColor,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSize.verticalWidgetSpacing),

                  /// UPDATE THEME
                  CommonWidget.butoonWithImageAndText(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          context.read<AppThemeProvider>().isDarkMode
                              ? Icons.light_mode
                              : Icons.dark_mode,
                          size: 26,
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Dark Theme",
                          style: AppTextStyle().titleTextStyle(
                            context: context,
                            fontSize: 14,
                          ),
                        ),
                        Spacer(),
                        Switch(
                          padding: EdgeInsets.all(0),
                          key: context
                              .read<EmployeeDashboardProvider>()
                              .themeSwitchKey,
                          value: context.watch<AppThemeProvider>().isDarkMode,
                          onChanged: (v) {
                            context
                                .read<EmployeeDashboardProvider>()
                                .toggleThemeMode();
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSize.verticalWidgetSpacing),

                  /// LOGOUT
                  CommonWidget.butoonWithImageAndText(
                    onTap: () async {
                      if (context.mounted) {
                        await CommonMethod().errageAllDataAndGotoLogin(
                          context: context,
                        );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.logout, color: AppColors.primaryColor),
                        SizedBox(width: 10),
                        Text(
                          "Logout",
                          style: AppTextStyle().titleTextStyle(
                            context: context,
                            fontSize: 14,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 20,
                          color: AppColors.primaryColor,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSize.verticalWidgetSpacing),
                ],
              ),
            ),
    );
  }
}
