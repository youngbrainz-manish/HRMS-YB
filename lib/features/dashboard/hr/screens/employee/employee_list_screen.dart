import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/network/authentication_data.dart';
import 'package:hrms_yb/core/router/app_router.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/core/theme/app_theme_provider.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/employee/employee_list_provider.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/employee/employee_response_model.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:hrms_yb/shared/widgets/app_filter_dropdown.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:provider/provider.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EmployeeListProvider(context: context),
      child: Consumer<EmployeeListProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: SafeArea(
              child: _buildBody(context: context, provider: provider),
            ),
            floatingActionButton: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onPressed: () async {
                bool? retvalue = await GoRouter.of(
                  context,
                ).push(AppRouter.addEmployeeScreenRoute);
                if (retvalue == true) {
                  provider.getEmployeeData(isInitial: true);
                }
              },
              child: Icon(Icons.add, color: AppColors.whiteColor),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody({
    required BuildContext context,
    required EmployeeListProvider provider,
  }) {
    return Stack(
      children: [
        SizedBox(
          child: provider.isLoading && provider.loadFullScreen
              ? CommonWidget.defaultLoader()
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      /// SEARCH
                      _searchField(provider: provider),
                      SizedBox(height: AppSize.verticalWidgetSpacing),

                      /// FILTER TOGGLE
                      // GestureDetector(
                      //   onTap: () {
                      //     provider.showFilters = !provider.showFilters;
                      //     provider.updateState();
                      //   },
                      //   child: Row(
                      //     children: [
                      //       const Icon(Icons.filter_alt_outlined, color: AppColors.textButtonColor),
                      //       const SizedBox(width: 6),
                      //       Text(
                      //         provider.showFilters ? "Hide Filters" : "Show Filters",
                      //         style: const TextStyle(color: AppColors.textButtonColor, fontWeight: FontWeight.w500),
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      // if (provider.showFilters) ...[const SizedBox(height: 16), _filterCard(provider: provider)],
                      // SizedBox(height: AppSize.verticalWidgetSpacing),

                      ///Employee List
                      Expanded(
                        child: provider.loadFullScreen == false
                            ? CommonWidget.defaultLoader()
                            : RefreshIndicator(
                                onRefresh: () =>
                                    provider.getEmployeeData(isInitial: true),
                                child: ListView.builder(
                                  controller: provider.scrollController,
                                  padding: EdgeInsets.zero,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount:
                                      provider.employeesList.length +
                                      (provider.isPaginationLoading ? 1 : 0),
                                  itemBuilder: (context, index) {
                                    if (index ==
                                        provider.employeesList.length) {
                                      return const Padding(
                                        padding: EdgeInsets.all(16),
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    }

                                    EmployeeDetailsModel employeeModel =
                                        provider.employeesList[index];

                                    return GestureDetector(
                                      onTap: () async {
                                        await GoRouter.of(context).push(
                                          AppRouter.employeeDetailsScreenRoute,
                                        );
                                      },
                                      child: EmployeeCard(
                                        employeeModel: employeeModel,
                                        provider: provider,
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
        ),

        if (provider.isLoadingFullScreen == true)
          CommonWidget.fullScreenLoader(),
      ],
    );
  }

  Widget _searchField({required EmployeeListProvider provider}) {
    return TextField(
      onChanged: provider.onSearchChanged,
      decoration: InputDecoration(
        hintText: "Search by name or code...",
        prefixIcon: const Icon(Icons.search),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // ignore: unused_element
  Widget _filterCard({required EmployeeListProvider provider}) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          children: [
            AppFilterDropdown(
              label: "Department",
              value: provider.department,
              options: provider.departmentList,
              // onChanged: (v) {
              //   provider.department = v;
              //   provider.updateState();
              // },
              onChanged: (v) {
                provider.department = v;
                provider.applyFilters();
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: AppFilterDropdown(
                    label: "Designation",
                    value: provider.designation,
                    options: provider.designationList,
                    // onChanged: (v) {
                    //   provider.designation = v;
                    //   provider.updateState();
                    // },
                    onChanged: (v) {
                      provider.designation = v;
                      provider.applyFilters();
                    },
                  ),
                ),
                const SizedBox(width: 8),

                Expanded(
                  flex: 2,
                  child: AppFilterDropdown(
                    label: "Status",
                    value: provider.status,
                    options: provider.statusList,
                    // onChanged: (v) {
                    //   provider.status = v;
                    //   provider.updateState();
                    // },
                    onChanged: (v) {
                      provider.status = v;
                      provider.applyFilters();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EmployeeCard extends StatelessWidget {
  final EmployeeDetailsModel employeeModel;
  final EmployeeListProvider provider;

  const EmployeeCard({
    super.key,
    required this.employeeModel,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Container(
        padding: const EdgeInsets.only(
          left: 12,
          top: 10,
          right: 12,
          bottom: 16,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: AlignmentGeometry.bottomCenter,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: context.watch<AppThemeProvider>().isDarkMode
                        ? AppColors.darkGrey
                        : AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.person_outline,
                    color: AppColors.primaryColor,
                  ),
                ),

                /// STATUS BADGE
                Positioned(
                  bottom: -10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color:
                          (employeeModel.status ?? "").toLowerCase() == "active"
                          ? AppColors.successPrimary.withValues(alpha: 0.43)
                          : AppColors.errorColor.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      employeeModel.status ?? '',
                      style: AppTextStyle().lableTextStyle(
                        context: context,
                        color:
                            (employeeModel.status ?? "").toLowerCase() ==
                                "active"
                            ? AppColors.blackColor
                            : AppColors.errorColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${(employeeModel.firstName ?? '')} ${(employeeModel.lastName ?? '')}",
                    style: AppTextStyle().titleTextStyle(context: context),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "EMP000${employeeModel.userId ?? ''}",
                    style: AppTextStyle().lableTextStyle(context: context),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "${employeeModel.deptName}  •  ${employeeModel.designation}",
                    style: AppTextStyle().lableTextStyle(context: context),
                  ),
                ],
              ),
            ),

            ///Popup Menu
            Visibility(
              visible:
                  (AuthenticationData.userModel?.department?.deptName
                      ?.toLowerCase() ==
                  "hr"),
              child: CommonWidget.commonPopupMenu(
                menuItem: const [
                  PopupMenuItem(value: 1, child: Text('Edit')),
                  PopupMenuItem(value: 2, child: Text('Delete')),
                ],
                onSelected: (value) async {
                  if (value == 1) {
                    // HolidayModel? holidayModel = await GoRouter.of(
                    //   context,
                    // ).push(AppRouter.addHolidayScreenRoute, extra: {"holiday": holiday});
                    // if (holidayModel != null) {
                    //   // provider.replaceHoliday(updatedHoliday: holidayModel);
                    // }
                  } else if (value == 2) {
                    final confirm = await CommonWidget.showConfirmDialog(
                      context: context,
                      title: "Delete Holiday",
                      message: "Do you want to delete this holiday?",
                    );
                    if (confirm == true) {
                      await provider.deleteUser(id: employeeModel.userId);
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
