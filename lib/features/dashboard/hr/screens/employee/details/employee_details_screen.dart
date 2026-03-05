import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/router/app_router.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/employee/details/employee_details_provider.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:provider/provider.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  const EmployeeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EmployeeDetailsProvider(context: context),
      child: Consumer<EmployeeDetailsProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              leading: CommonWidget.backButton(
                onTap: () => GoRouter.of(context).pop(),
              ),
              title: Text(
                "Employee Details",
                style: AppTextStyle().titleTextStyle(
                  context: context,
                  color: AppColors.whiteColor,
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () async {
                    var value = await GoRouter.of(context).push(
                      AppRouter.addEmployeeScreenRoute,
                      extra: {"employeeModel": provider.employeeModel},
                    );
                    if (value == true) {
                      // ignore: use_build_context_synchronously
                      GoRouter.of(context).pop(true);
                    }
                  },
                  child: Card(
                    margin: EdgeInsets.only(right: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(4),
                    ),
                    child: SizedBox(
                      height: 30,
                      width: 60,
                      child: Center(child: Text("Edit")),
                    ),
                  ),
                ),
              ],
            ),
            body: _buildBody(context: context, provider: provider),
          );
        },
      ),
    );
  }

  Widget _buildBody({
    required BuildContext context,
    required EmployeeDetailsProvider provider,
  }) {
    return SizedBox(
      child: provider.isLoading
          ? CommonWidget.defaultLoader()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(AppSize.verticalWidgetSpacing),
              child: Column(
                children: [
                  _EmployeeHeaderCard(provider: provider),
                  const SizedBox(height: AppSize.verticalWidgetSpacing),

                  _PersonalDetailsCard(provider: provider),
                  const SizedBox(height: AppSize.verticalWidgetSpacing),

                  _EmploymentDetailsCard(provider: provider),
                  const SizedBox(height: AppSize.verticalWidgetSpacing),

                  _AddressDetailsCard(provider: provider),
                  const SizedBox(height: AppSize.verticalWidgetSpacing),

                  _EducationDetailsCard(provider: provider),
                  const SizedBox(height: AppSize.verticalWidgetSpacing),

                  GestureDetector(
                    onTap: () {},
                    child: _deactivateButton(
                      context: context,
                      provider: provider,
                    ),
                  ),
                  const SizedBox(height: AppSize.verticalWidgetSpacing),
                ],
              ),
            ),
    );
  }

  Widget? _deactivateButton({
    required BuildContext context,
    required EmployeeDetailsProvider provider,
  }) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSize.verticalWidgetSpacing,
          horizontal: AppSize.verticalWidgetSpacing,
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.errorColor.withValues(alpha: 0.25),
              child: Icon(Icons.toggle_off, color: AppColors.errorColor),
            ),
            SizedBox(width: 14),
            Text(
              "Deactivate Employee",
              style: AppTextStyle().titleTextStyle(
                context: context,
                color: AppColors.errorColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddressDetailsCard extends StatelessWidget {
  final EmployeeDetailsProvider provider;

  const _AddressDetailsCard({required this.provider});

  @override
  Widget build(BuildContext context) {
    String formatAddress(String type) {
      final addr = provider.employeeDetailsModel?.addresses
          ?.where((e) => e.addressType == type)
          .firstOrNull;

      if (addr == null) return "NA";

      return "${addr.street}, ${addr.city}, ${addr.state} - ${addr.pincode}";
    }

    return DetailCard(
      title: "Address Details",
      items: [
        DetailItem(
          icon: Icons.location_on_outlined,
          color: Colors.orange,
          label: "Current Address",
          value: formatAddress("Current"),
        ),
        DetailItem(
          icon: Icons.home_outlined,
          color: Colors.blue,
          label: "Permanent Address",
          value: formatAddress("Permanent"),
        ),
      ],
    );
  }
}

class _EducationDetailsCard extends StatelessWidget {
  final EmployeeDetailsProvider provider;

  const _EducationDetailsCard({required this.provider});

  @override
  Widget build(BuildContext context) {
    final edu = provider.employeeDetailsModel?.education?.first;

    return DetailCard(
      title: "Education",
      items: [
        DetailItem(
          icon: Icons.school_outlined,
          color: Colors.indigo,
          label: "Institution",
          value: edu?.institutionName ?? "NA",
        ),
        DetailItem(
          icon: Icons.menu_book_outlined,
          color: Colors.orange,
          label: "Degree",
          value: edu?.degree ?? "NA",
        ),
        DetailItem(
          icon: Icons.code_outlined,
          color: Colors.green,
          label: "Specialization",
          value: edu?.specialization ?? "NA",
        ),
        DetailItem(
          icon: Icons.date_range_outlined,
          color: Colors.teal,
          label: "Year Of Passing",
          value: "${edu?.yearOfPassing ?? "NA"}",
        ),
        DetailItem(
          icon: Icons.grade_outlined,
          color: Colors.pink,
          label: "Grade",
          value: edu?.grade ?? "NA",
        ),
      ],
    );
  }
}

class _EmployeeHeaderCard extends StatelessWidget {
  final EmployeeDetailsProvider provider;
  const _EmployeeHeaderCard({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: AppSize.verticalWidgetSpacing / 2,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // gradient: LinearGradient(
          //   colors: [
          //     AppColors.primaryColor,
          //     AppColors.primaryColor.withValues(alpha: 0.6),
          //   ],
          // ),
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 55,
              backgroundColor: Colors.white24,
              backgroundImage:
                  (provider.employeeDetailsModel?.profilePhoto ?? "").isNotEmpty
                  ? NetworkImage(provider.employeeDetailsModel!.profilePhoto!)
                  : null,
              child: (provider.employeeDetailsModel?.profilePhoto ?? "").isEmpty
                  ? Icon(Icons.person_outline, size: 42, color: Colors.white)
                  : SizedBox(),
            ),
            // SizedBox(height: AppSize.verticalWidgetSpacing / 2),

            // Text(
            //   "${provider.employeeDetailsModel?.lastName ?? "NA"} ${provider.employeeDetailsModel?.lastName ?? "NA"}",
            //   style: AppTextStyle().titleTextStyle(
            //     context: context,
            //     color: AppColors.whiteColor,
            //     fontSize: 20,
            //   ),
            // ),
            const SizedBox(height: AppSize.verticalWidgetSpacing / 2),
            Text(
              "EMP000${provider.employeeDetailsModel?.userId}",
              style: AppTextStyle().lableTextStyle(
                context: context,
                color: AppColors.whiteColor,
              ),
            ),

            // const SizedBox(height: AppSize.verticalWidgetSpacing),
            // Container(
            //   padding: const EdgeInsets.symmetric(horizontal: AppSize.verticalWidgetSpacing, vertical: 6),
            //   decoration: BoxDecoration(
            //     color: AppColors.whiteColor.withValues(alpha: 0.15),
            //     borderRadius: BorderRadius.circular(20),
            //     border: Border.all(color: AppColors.greyColor),
            //   ),
            //   child: Text("Active", style: AppTextStyle().subTitleTextStyle(context: context)),
            // ),
          ],
        ),
      ),
    );
  }
}

class DetailCard extends StatelessWidget {
  final String title;
  final List<DetailItem> items;

  const DetailCard({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Container(
        padding: const EdgeInsets.all(AppSize.verticalWidgetSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyle().titleTextStyle(context: context)),
            const SizedBox(height: AppSize.verticalWidgetSpacing),
            ...items.map((e) => _DetailTile(item: e)),
          ],
        ),
      ),
    );
  }
}

class _DetailTile extends StatelessWidget {
  final DetailItem item;

  const _DetailTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSize.verticalWidgetSpacing / 2,
      ),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: item.color.withValues(alpha: .15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(item.icon, color: item.color),
          ),
          const SizedBox(width: AppSize.verticalWidgetSpacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.label,
                  style: AppTextStyle().lableTextStyle(context: context),
                ),
                const SizedBox(height: 2),
                Text(
                  item.value,
                  style: AppTextStyle().titleTextStyle(context: context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PersonalDetailsCard extends StatelessWidget {
  final EmployeeDetailsProvider provider;
  const _PersonalDetailsCard({required this.provider});

  @override
  Widget build(BuildContext context) {
    return DetailCard(
      title: "Personal Details",
      items: [
        DetailItem(
          icon: Icons.person_outline,
          color: AppColors.holidayColor,
          label: "Full Name",
          value:
              "${provider.employeeDetailsModel?.firstName ?? "NA"} ${provider.employeeDetailsModel?.lastName ?? "NA"}",
        ),
        DetailItem(
          icon: Icons.phone_outlined,
          color: AppColors.successPrimary,
          label: "Mobile",
          value: provider.employeeDetailsModel?.mobileNo ?? "NA",
        ),
        DetailItem(
          icon: Icons.email_outlined,
          color: AppColors.primaryPurpleColor,
          label: "Email",
          value: provider.employeeDetailsModel?.email ?? "NA",
        ),
        DetailItem(
          icon: Icons.male,
          color: Colors.blue,
          label: "Gender",
          value: provider.employeeDetailsModel?.gender ?? "NA",
        ),
        DetailItem(
          icon: Icons.cake_outlined,
          color: Colors.orange,
          label: "Age",
          value: "${provider.employeeDetailsModel?.age ?? "NA"}",
        ),
        DetailItem(
          icon: Icons.calendar_today_outlined,
          color: Colors.green,
          label: "Birthday",
          value: provider.employeeDetailsModel?.birthday ?? "NA",
        ),
        DetailItem(
          icon: Icons.favorite_border,
          color: Colors.pink,
          label: "Marital Status",
          value: provider.employeeDetailsModel?.maritialStatus ?? "NA",
        ),
        DetailItem(
          icon: Icons.bloodtype_outlined,
          color: Colors.red,
          label: "Blood Group",
          value: provider.employeeDetailsModel?.bloodGroup ?? "NA",
        ),
        DetailItem(
          icon: Icons.verified_user_outlined,
          color: Colors.teal,
          label: "Status",
          value: provider.employeeDetailsModel?.status ?? "NA",
        ),
      ],
    );
  }
}

class _EmploymentDetailsCard extends StatelessWidget {
  final EmployeeDetailsProvider provider;
  const _EmploymentDetailsCard({required this.provider});

  @override
  Widget build(BuildContext context) {
    return DetailCard(
      title: "Employment Details",
      items: [
        DetailItem(
          icon: Icons.apartment_outlined,
          color: Colors.orange,
          label: "Department",
          value: provider.employeeDetailsModel?.department?.deptName ?? "NA",
        ),
        DetailItem(
          icon: Icons.work_outline,
          color: Colors.pink,
          label: "Designation",
          value: provider.employeeDetailsModel?.department?.designation ?? "NA",
        ),
        DetailItem(
          icon: Icons.calendar_month_outlined,
          color: Colors.teal,
          label: "Joining Date",
          value: provider.employeeDetailsModel?.department?.joiningDate ?? "NA",
        ),
        DetailItem(
          icon: Icons.badge_outlined,
          color: Colors.indigo,
          label: "Employee Type",
          value:
              provider.employeeDetailsModel?.department?.employementType ??
              "NA",
        ),
        DetailItem(
          icon: Icons.currency_rupee,
          color: Colors.green,
          label: "Salary",
          value: "${provider.employeeDetailsModel?.department?.salary ?? "NA"}",
        ),

        DetailItem(
          icon: Icons.supervisor_account_outlined,
          color: Colors.deepPurple,
          label: "Reporting To",
          value:
              "${provider.employeeDetailsModel?.department?.reportingTo?.firstName ?? ""} "
              "${provider.employeeDetailsModel?.department?.reportingTo?.lastName ?? ""}",
        ),

        DetailItem(
          icon: Icons.category_outlined,
          color: Colors.blueGrey,
          label: "Category",
          value:
              provider.employeeDetailsModel?.department?.categoryName ?? "NA",
        ),
      ],
    );
  }
}
