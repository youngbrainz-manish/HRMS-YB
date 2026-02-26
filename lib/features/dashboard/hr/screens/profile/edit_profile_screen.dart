import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/profile/edit_profile_provider.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:hrms_yb/shared/widgets/common_button.dart';
import 'package:hrms_yb/shared/widgets/common_text_field.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: ChangeNotifierProvider(
        create: (_) => EditProfileProvider(context: context),
        child: Consumer<EditProfileProvider>(
          builder: (context, provider, child) {
            return PopScope(
              canPop: false,
              // ignore: deprecated_member_use
              onPopInvoked: (didPop) {
                if (didPop) return;
                context.pop(provider.isProfileUpdated);
              },
              child: Scaffold(
                appBar: AppBar(
                  leading: CommonWidget.backButton(onTap: () => GoRouter.of(context).pop(provider.isProfileUpdated)),
                  title: const Text("Edit Profile"),
                  centerTitle: true,
                ),
                body: SafeArea(
                  child: provider.isLoading
                      ? CommonWidget.defaultLoader()
                      : _buildBody(context: context, provider: provider),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody({required BuildContext context, required EditProfileProvider provider}) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// PROFILE IMAGE
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: AppColors.greyColor,
                            backgroundImage: provider.imagePath != null
                                ? provider.imagePath!.startsWith("http")
                                      ? NetworkImage(provider.imagePath!)
                                      : FileImage(provider.imageFile!)
                                : AssetImage("assets/images/default_profile.png"),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () async {
                                var data = await imageActionDialog(context: context, provider: provider);
                                if (data == 1) {
                                  provider.imageFile = null;
                                  provider.imagePath = null;
                                  provider.updateState();
                                } else if (data == 2) {
                                  await provider.picImage();
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.all(6),
                                child: const Icon(Icons.edit, size: 18, color: AppColors.whiteColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSize.verticalWidgetSpacing),

                    /// FORM
                    CommonTextField(
                      controller: provider.firstNameController,
                      hintText: "First Name",
                      labelText: "First Name",
                    ),
                    SizedBox(height: AppSize.verticalWidgetSpacing),
                    CommonTextField(
                      controller: provider.lastNameController,
                      hintText: "Last Name",
                      labelText: "Last Name",
                    ),
                    SizedBox(height: AppSize.verticalWidgetSpacing),
                    CommonTextField(
                      controller: provider.emailController,
                      hintText: "Email Address",
                      labelText: "Email",
                    ),
                    SizedBox(height: AppSize.verticalWidgetSpacing),
                    CommonTextField(
                      controller: provider.phoneController,
                      hintText: "Phone Number",
                      labelText: "Phone Number",
                    ),
                    SizedBox(height: AppSize.verticalWidgetSpacing),
                    CommonTextField(
                      controller: provider.departmentController,
                      hintText: "Department",
                      labelText: "Department",
                    ),
                    SizedBox(height: AppSize.verticalWidgetSpacing),
                    CommonTextField(
                      controller: provider.designationController,
                      hintText: "Designation",
                      labelText: "Designation",
                    ),
                    SizedBox(height: AppSize.verticalWidgetSpacing),

                    /// DOB PICKER
                    CommonTextField(
                      controller: provider.dobController,
                      hintText: "Date of Birth",
                      isEnable: false,
                      onTap: () async {
                        DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: DateTime(1998),
                          firstDate: DateTime(1970),
                          lastDate: DateTime.now(),
                        );
                        //"2005-12-27"
                        if (date != null) {
                          provider.dobController.text = "${date.year}-${date.month}-${date.day}";
                        }
                      },
                      suffixIcon: Icons.calendar_month,
                      labelText: "DOB",
                    ),

                    const SizedBox(height: AppSize.verticalWidgetSpacing * 2),

                    Text("Current Address", style: AppTextStyle().subTitleTextStyle(context: context)),
                    SizedBox(height: AppSize.verticalWidgetSpacing),
                    CommonTextField(controller: provider.cAddStreet, hintText: "Street", labelText: "Street"),
                    SizedBox(height: AppSize.verticalWidgetSpacing),
                    CommonTextField(controller: provider.cAddCity, hintText: "City", labelText: "City"),
                    SizedBox(height: AppSize.verticalWidgetSpacing),
                    CommonTextField(controller: provider.cAddState, hintText: "State", labelText: "State"),
                    SizedBox(height: AppSize.verticalWidgetSpacing),
                    CommonTextField(controller: provider.cAddPincode, hintText: "Pincode", labelText: "Pincode"),
                    SizedBox(height: AppSize.verticalWidgetSpacing),
                    CommonTextField(
                      controller: provider.cAddEmergContact,
                      hintText: "Emergency Contact",
                      labelText: "Emergency Contact",
                    ),
                    SizedBox(height: AppSize.verticalWidgetSpacing),
                    CommonTextField(
                      controller: provider.cAddEmergContactName,
                      hintText: "Emergency Contact Name",
                      labelText: "Emergency Contact Name",
                    ),
                    const SizedBox(height: AppSize.verticalWidgetSpacing),
                    Row(
                      children: [
                        Text(
                          "Current Address is same as Permanent ",
                          style: AppTextStyle().titleTextStyle(
                            fontSize: 14,
                            context: context,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Spacer(),
                        Checkbox(
                          side: const BorderSide(color: AppColors.primaryColor, width: 2),
                          value: provider.checkBoxStatus,
                          onChanged: (v) {
                            provider.checkBoxStatus = v ?? false;
                            provider.updateState();
                            provider.updatePermanentAddress();
                          },
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                        ),
                      ],
                    ),
                    // if (provider.checkBoxStatus != true) ...[
                    const SizedBox(height: AppSize.verticalWidgetSpacing),
                    Text("Permanent Address", style: AppTextStyle().subTitleTextStyle(context: context)),
                    SizedBox(height: AppSize.verticalWidgetSpacing),
                    CommonTextField(controller: provider.pAddStreet, hintText: "Street", labelText: "Street"),
                    SizedBox(height: AppSize.verticalWidgetSpacing),
                    CommonTextField(controller: provider.pAddCity, hintText: "City", labelText: "City"),
                    SizedBox(height: AppSize.verticalWidgetSpacing),
                    CommonTextField(controller: provider.pAddState, hintText: "State", labelText: "State"),
                    SizedBox(height: AppSize.verticalWidgetSpacing),
                    CommonTextField(controller: provider.pAddPincode, hintText: "Pincode", labelText: "Pincode"),
                    SizedBox(height: AppSize.verticalWidgetSpacing),
                    CommonTextField(
                      controller: provider.pAddEmergContact,
                      hintText: "Emergency Contact",
                      labelText: "Emergency Contact",
                    ),
                    SizedBox(height: AppSize.verticalWidgetSpacing),
                    CommonTextField(
                      controller: provider.pAddEmergContactName,
                      hintText: "Emergency Contact Name",
                      labelText: "Emergency Contact Name",
                    ),
                    // ],
                  ],
                ),
              ),
            ),

            /// SAVE BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: CommonButton(
                title: "Save Changes",
                onTap: () {
                  provider.validateAndUpdate();
                },
              ),
            ),
          ],
        ),
        if (provider.updatingProfile == true) ...[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(color: AppColors.primaryColor.withValues(alpha: 0.4)),
            child: Center(child: CommonWidget.defaultLoader(color: AppColors.whiteColor)),
          ),
        ],
      ],
    );
  }

  imageActionDialog({required BuildContext context, required EditProfileProvider provider}) async {
    return await showDialog<int?>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          iconPadding: EdgeInsets.all(0),
          insetPadding: EdgeInsets.all(0),
          titlePadding: EdgeInsets.all(0),
          buttonPadding: EdgeInsets.all(0),
          actionsPadding: EdgeInsets.all(0),
          contentPadding: EdgeInsets.all(0),
          backgroundColor: AppColors.transparantColor,
          content: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: AppColors.borderGrey),
            ),
            margin: EdgeInsets.all(0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: AppSize.verticalWidgetSpacing / 2),
                  Row(
                    children: [
                      Spacer(),
                      GestureDetector(
                        onTap: () => GoRouter.of(context).pop(),
                        child: Card(
                          elevation: 2,
                          shadowColor: AppColors.whiteColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          child: Padding(padding: const EdgeInsets.all(4), child: Icon(Icons.close_rounded, size: 16)),
                        ),
                      ),
                    ],
                  ),
                  Text("Select one option", style: AppTextStyle().titleTextStyle(context: context, fontSize: 18)),
                  SizedBox(height: AppSize.verticalWidgetSpacing / 2),
                  SizedBox(height: AppSize.verticalWidgetSpacing),
                  Row(
                    children: [
                      Spacer(),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () => GoRouter.of(context).pop(1),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(color: AppColors.borderGrey),
                              ),
                              margin: EdgeInsets.all(0),
                              child: SizedBox(
                                height: 60,
                                width: 60,
                                child: Icon(Icons.delete_forever_rounded, size: 36, color: AppColors.primaryColor),
                              ),
                            ),
                          ),
                          SizedBox(height: AppSize.verticalWidgetSpacing),
                          Text("Remove Image", style: AppTextStyle().lableTextStyle(context: context)),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () => GoRouter.of(context).pop(2),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(color: AppColors.borderGrey),
                              ),
                              margin: EdgeInsets.all(0),
                              child: SizedBox(
                                height: 60,
                                width: 60,
                                child: Icon(Icons.add_photo_alternate_rounded, size: 36, color: AppColors.primaryColor),
                              ),
                            ),
                          ),
                          SizedBox(height: AppSize.verticalWidgetSpacing),
                          Text("Add Image", style: AppTextStyle().lableTextStyle(context: context)),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: AppSize.verticalWidgetSpacing),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
