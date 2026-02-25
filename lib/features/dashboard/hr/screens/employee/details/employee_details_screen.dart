import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
              leading: CommonWidget().backButton(onTap: () => GoRouter.of(context).pop()),
              title: Text(
                "Employee Details",
                style: AppTextStyle().titleTextStyle(context: context, color: AppColors.whiteColor),
              ),
            ),
            body: _buildBody(context: context, provider: provider),
          );
        },
      ),
    );
  }

  Widget _buildBody({required BuildContext context, required EmployeeDetailsProvider provider}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _EmployeeHeaderCard(),
          const SizedBox(height: 16),
          _PersonalDetailsCard(),
          const SizedBox(height: 16),
          _EmploymentDetailsCard(),
          const SizedBox(height: 16),
          GestureDetector(onTap: () {}, child: _DeactivateButton()),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _EmployeeHeaderCard extends StatelessWidget {
  const _EmployeeHeaderCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: AppSize.verticalWidgetSpacing),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(colors: [AppColors.primaryColor, AppColors.primaryColor.withValues(alpha: 0.6)]),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 42,
            backgroundColor: Colors.white24,
            child: Icon(Icons.person_outline, size: 42, color: Colors.white),
          ),
          SizedBox(height: AppSize.verticalWidgetSpacing / 2),

          Text(
            "Kavita Nair",
            style: AppTextStyle().titleTextStyle(context: context, color: AppColors.whiteColor, fontSize: 20),
          ),

          const SizedBox(height: 4),
          Text(
            "EMP008",
            style: AppTextStyle().lableTextStyle(context: context, color: AppColors.whiteColor),
          ),

          // const SizedBox(height: 16),
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
          //   decoration: BoxDecoration(
          //     color: AppColors.whiteColor.withValues(alpha: 0.15),
          //     borderRadius: BorderRadius.circular(20),
          //     border: Border.all(color: AppColors.greyColor),
          //   ),
          //   child: Text("Active", style: AppTextStyle().subTitleTextStyle(context: context)),
          // ),
        ],
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyle().titleTextStyle(context: context)),
            const SizedBox(height: 16),
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
      padding: const EdgeInsets.symmetric(vertical: AppSize.verticalWidgetSpacing / 2),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.label, style: AppTextStyle().lableTextStyle(context: context)),
              const SizedBox(height: 2),
              Text(item.value, style: AppTextStyle().titleTextStyle(context: context)),
            ],
          ),
        ],
      ),
    );
  }
}

class _PersonalDetailsCard extends StatelessWidget {
  const _PersonalDetailsCard();

  @override
  Widget build(BuildContext context) {
    return DetailCard(
      title: "Personal Details",
      items: [
        DetailItem(icon: Icons.person_outline, color: AppColors.holidayColor, label: "Full Name", value: "Kavita Nair"),
        DetailItem(icon: Icons.phone_outlined, color: AppColors.successPrimary, label: "Mobile", value: "9876543217"),
        DetailItem(
          icon: Icons.email_outlined,
          color: AppColors.primaryPurpleColor,
          label: "Email",
          value: "kavita@company.com",
        ),
      ],
    );
  }
}

class _EmploymentDetailsCard extends StatelessWidget {
  const _EmploymentDetailsCard();

  @override
  Widget build(BuildContext context) {
    return DetailCard(
      title: "Employment Details",
      items: [
        DetailItem(icon: Icons.apartment_outlined, color: Colors.orange, label: "Department", value: "Service"),
        DetailItem(icon: Icons.work_outline, color: Colors.pink, label: "Designation", value: "Associate"),
        DetailItem(
          icon: Icons.calendar_month_outlined,
          color: Colors.teal,
          label: "Joining Date",
          value: "February 14, 2023",
        ),
        DetailItem(icon: Icons.badge_outlined, color: Colors.indigo, label: "Employee Type", value: "Permanent"),
      ],
    );
  }
}

class _DeactivateButton extends StatelessWidget {
  const _DeactivateButton();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.errorColor.withValues(alpha: 0.25),
              child: Icon(Icons.toggle_off, color: AppColors.errorColor),
            ),
            SizedBox(width: 14),
            Text(
              "Deactivate Employee",
              style: AppTextStyle().titleTextStyle(context: context, color: AppColors.errorColor),
            ),
          ],
        ),
      ),
    );
  }
}
