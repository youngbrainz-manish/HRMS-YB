import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/router/app_router.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/core/theme/app_theme_provider.dart';
import 'package:hrms_yb/shared/common_method.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:provider/provider.dart';
import 'all_leave_plan_provider.dart';

class AllLeavePlanScreen extends StatelessWidget {
  const AllLeavePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AllLeavePlanProvider(context: context),
      child: const _AllLeavePlanView(),
    );
  }
}

class _AllLeavePlanView extends StatelessWidget {
  const _AllLeavePlanView();

  @override
  Widget build(BuildContext context) {
    return Consumer<AllLeavePlanProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await GoRouter.of(
                context,
              ).push(AppRouter.leavePlanAddEditViewScreenRoute, extra: {"type": 0, "id": null});
            },
            child: Text("+"),
          ),
          body: SafeArea(
            child: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: provider.leavePlans.length,
                    padding: const EdgeInsets.all(AppSize.verticalWidgetSpacing),
                    itemBuilder: (context, index) {
                      final plan = provider.leavePlans[index];

                      return Card(
                        margin: const EdgeInsets.only(bottom: AppSize.verticalWidgetSpacing / 2),
                        child: ListTile(
                          contentPadding: EdgeInsets.only(
                            left: AppSize.verticalWidgetSpacing,
                            top: AppSize.verticalWidgetSpacing / 2,
                            right: AppSize.verticalWidgetSpacing,
                          ),
                          title: Text(plan.planName ?? "", style: AppTextStyle().titleTextStyle(context: context)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: AppSize.verticalWidgetSpacing / 2),
                              _rowWidget(
                                title: "Category",
                                context: context,
                                description: plan.userCategory?.categoryName ?? '',
                              ),
                              _rowWidget(title: "Start Date", context: context, description: "${plan.startDate}"),
                              _rowWidget(title: "End Date", context: context, description: " ${plan.endDate}"),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text("Created on : ", style: AppTextStyle().lableTextStyle(context: context)),
                                      Text(
                                        CommonMethod.formatDate(plan.createdAt ?? "", dateOnly: true),
                                        style: AppTextStyle().lableTextStyle(context: context),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () async {
                                      await GoRouter.of(context).push(
                                        AppRouter.leavePlanAddEditViewScreenRoute,
                                        extra: {"type": 1, "id": plan.leavePlanId},
                                      );
                                    },
                                    child: Card(
                                      shadowColor: AppColors.greyColor,
                                      margin: EdgeInsets.all(0),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(20)),
                                      color: context.read<AppThemeProvider>().isDarkMode
                                          ? AppColors.darkGrey
                                          : AppColors.lightGrey,
                                      child: Padding(
                                        padding: EdgeInsets.all(AppSize.verticalWidgetSpacing / 2),
                                        child: Icon(
                                          Icons.remove_red_eye_outlined,
                                          color: AppColors.primaryColor,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: AppSize.verticalWidgetSpacing / 2),
                                  GestureDetector(
                                    onTap: () async {
                                      await GoRouter.of(context).push(
                                        AppRouter.leavePlanAddEditViewScreenRoute,
                                        extra: {"type": 2, "id": plan.leavePlanId},
                                      );
                                    },
                                    child: Card(
                                      shadowColor: AppColors.greyColor,
                                      margin: EdgeInsets.all(0),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(20)),
                                      color: context.read<AppThemeProvider>().isDarkMode
                                          ? AppColors.darkGrey
                                          : AppColors.lightGrey,
                                      child: Padding(
                                        padding: EdgeInsets.all(AppSize.verticalWidgetSpacing / 2),
                                        child: Icon(Icons.edit_document, color: AppColors.primaryColor, size: 18),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: AppSize.verticalWidgetSpacing / 2),
                                  Card(
                                    shadowColor: AppColors.greyColor,
                                    color: context.read<AppThemeProvider>().isDarkMode
                                        ? AppColors.darkGrey
                                        : AppColors.lightGrey,
                                    margin: EdgeInsets.all(0),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(20)),
                                    child: Padding(
                                      padding: EdgeInsets.all(AppSize.verticalWidgetSpacing / 2),
                                      child: Icon(
                                        Icons.delete_forever_rounded,
                                        color: AppColors.primaryColor,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        );
      },
    );
  }

  Widget _rowWidget({required String title, required BuildContext context, required String description}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(title, style: AppTextStyle().subTitleTextStyle(context: context, fontSize: 12)),
          ),
          Expanded(flex: 1, child: Text(":")),
          Expanded(
            flex: 14,
            child: Text(description, style: AppTextStyle().titleTextStyle(context: context, fontSize: 12.5)),
          ),
        ],
      ),
    );
  }
}
