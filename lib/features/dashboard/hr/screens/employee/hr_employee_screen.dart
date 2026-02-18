import 'package:flutter/material.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/employee/hr_employee_provider.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:provider/provider.dart';

class HrEmployeeScreen extends StatefulWidget {
  const HrEmployeeScreen({super.key});

  @override
  State<HrEmployeeScreen> createState() => _HrEmployeeScreenState();
}

class _HrEmployeeScreenState extends State<HrEmployeeScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HrEmployeeProvider(context: context),
      child: Consumer<HrEmployeeProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: SafeArea(
              child: _buildBody(context: context, provider: provider),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody({required BuildContext context, required HrEmployeeProvider provider}) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        /// SEARCH
        _searchField(provider: provider),

        const SizedBox(height: 16),

        /// FILTER TOGGLE
        GestureDetector(
          onTap: () {
            provider.showFilters = !provider.showFilters;
            provider.updateState();
          },
          child: Row(
            children: [
              const Icon(Icons.filter_alt_outlined, color: AppColors.textButtonColor),
              const SizedBox(width: 6),
              Text(
                provider.showFilters ? "Hide Filters" : "Show Filters",
                style: const TextStyle(color: AppColors.textButtonColor, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),

        if (provider.showFilters) ...[const SizedBox(height: 16), _filterCard(provider: provider)],

        const SizedBox(height: 16),

        Text("${provider.employees.length} employees found", style: AppTextStyle().lableTextStyle(context: context)),

        const SizedBox(height: 16),

        ...provider.employees.map((e) {
          return EmployeeCard(employee: e);
        }),
      ],
    );
  }

  Widget _searchField({required HrEmployeeProvider provider}) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search by name or code...",
        prefixIcon: const Icon(Icons.search),
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _filterCard({required HrEmployeeProvider provider}) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            AppFilterDropdown(
              label: "Department",
              value: provider.department,
              options: const ["All Departments", "HR", "Sales", "Accounts", "Service", "Logistics"],
              onChanged: (v) {
                provider.department = v;
                provider.updateState();
              },
            ),
            const SizedBox(height: 16),

            AppFilterDropdown(
              label: "Designation",
              value: provider.designation,
              options: const ["All Designations", "Manager", "Executive", "Associate", "Intern"],
              onChanged: (v) {
                provider.designation = v;
                provider.updateState();
              },
            ),
            const SizedBox(height: 16),

            AppFilterDropdown(
              label: "Status",
              value: provider.status,
              options: const ["All Status", "Active", "Inactive"],
              onChanged: (v) {
                provider.status = v;
                provider.updateState();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class EmployeeCard extends StatelessWidget {
  final Employee employee;

  const EmployeeCard({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: AppColors.textButtonColor.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.person_outline, color: AppColors.textButtonColor),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(employee.name, style: AppTextStyle().titleTextStyle(context: context)),
                  const SizedBox(height: 4),
                  Text(employee.code, style: AppTextStyle().lableTextStyle(context: context)),
                  const SizedBox(height: 6),
                  Text(
                    "${employee.department}  •  ${employee.designation}",
                    style: AppTextStyle().lableTextStyle(context: context),
                  ),
                ],
              ),
            ),

            /// STATUS BADGE
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: employee.isActive ? AppColors.successSecondary : AppColors.errorColor.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                employee.isActive ? "Active" : "Inactive",
                style: AppTextStyle().lableTextStyle(
                  context: context,
                  color: employee.isActive ? AppColors.successPrimary : AppColors.errorColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppFilterDropdown extends StatelessWidget {
  final String label;
  final String value;
  final List<String> options;
  final ValueChanged<String> onChanged;

  const AppFilterDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle().subTitleTextStyle(context: context)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: value,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          items: options
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e, style: AppTextStyle().subTitleTextStyle(context: context)),
                ),
              )
              .toList(),
          onChanged: (v) => onChanged(v!),
        ),
      ],
    );
  }
}
