import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/leave/reply/reply_leave_provider.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:hrms_yb/shared/widgets/app_multiline_textfield.dart';
import 'package:hrms_yb/shared/widgets/common_button.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:provider/provider.dart';

class ReplyLeaveScreen extends StatelessWidget {
  const ReplyLeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ChangeNotifierProvider(
        create: (_) => ReplyLeaveProvider(context: context),
        child: Consumer<ReplyLeaveProvider>(
          builder: (context, provider, child) {
            return Scaffold(
              appBar: AppBar(
                leading: CommonWidget().backButton(onTap: () => context.pop()),
                title: Text(provider.title),
              ),
              body: SafeArea(
                child: _buildBody(context: context, provider: provider),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody({required BuildContext context, required ReplyLeaveProvider provider}) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: AppSize.verticalWidgetSpacing),
            Card(
              margin: EdgeInsets.all(0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Manish Patel", style: AppTextStyle().titleTextStyle(context: context)),
                        Spacer(),
                        Text("Pending"),
                      ],
                    ),
                    Text("Sales", style: AppTextStyle().lableTextStyle(context: context)),
                    SizedBox(height: AppSize.verticalWidgetSpacing),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(color: AppColors.hintColor, borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Leave Type", style: AppTextStyle().lableTextStyle(context: context)),
                              Spacer(),
                              Text("Casual Leave", style: AppTextStyle().subTitleTextStyle(context: context)),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Text("Duration", style: AppTextStyle().lableTextStyle(context: context)),
                              Spacer(),
                              Text("Dec 23 - Dec 24", style: AppTextStyle().subTitleTextStyle(context: context)),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Text("Days", style: AppTextStyle().lableTextStyle(context: context)),
                              Spacer(),
                              Text("2 days", style: AppTextStyle().subTitleTextStyle(context: context)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    Text("Reason:", style: AppTextStyle().lableTextStyle(context: context)),
                    SizedBox(height: 4),
                    Text("Family function", style: AppTextStyle().subTitleTextStyle(context: context)),
                  ],
                ),
              ),
            ),
            SizedBox(height: AppSize.verticalWidgetSpacing),
            Card(
              margin: EdgeInsets.all(0),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: AppMultilineTextField(
                  headingText: "Note (Optional)",
                  controller: provider.descriptionController,
                  hint: "Enter Reason",
                ),
              ),
            ),
            SizedBox(height: AppSize.verticalWidgetSpacing),
            CommonButton(title: provider.buttonTitle, onTap: () {}, color: provider.color?.withValues(alpha: 0.5)),
          ],
        ),
      ),
    );
  }
}
