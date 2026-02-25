import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/network/authentication_data.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/widgets/common_button.dart';
import 'package:hrms_yb/shared/widgets/common_text_field.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final TextEditingController firstNameController = TextEditingController(
    text: AuthenticationData.userModel?.firstName ?? "Manish Patel",
  );
  final TextEditingController lastNameController = TextEditingController(
    text: AuthenticationData.userModel?.lastName ?? "Patel",
  );
  final TextEditingController emailController = TextEditingController(
    text: AuthenticationData.userModel?.email ?? "manish@company.com",
  );
  final TextEditingController phoneController = TextEditingController(
    text: AuthenticationData.userModel?.mobileNo ?? "9876543210",
  );
  final TextEditingController departmentController = TextEditingController(
    text: AuthenticationData.userModel?.department?.deptName ?? "Development",
  );
  final TextEditingController designationController = TextEditingController(
    text: AuthenticationData.userModel?.department?.designation ?? "Flutter Developer",
  );
  final TextEditingController dobController = TextEditingController(
    text: AuthenticationData.userModel?.birthday ?? "12 Aug 1998",
  );
  final TextEditingController addressController = TextEditingController(
    text: AuthenticationData.userModel!.addresses?.first.city ?? "Ahmedabad, Gujarat",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CommonWidget().backButton(onTap: () => context.pop()),
        title: const Text("Edit Profile"),
        centerTitle: true,
      ),
      body: SafeArea(child: _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          /// PROFILE IMAGE
          Center(
            child: Stack(
              children: [
                const CircleAvatar(radius: 50, backgroundImage: NetworkImage("https://i.pravatar.cc/300")),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.all(6),
                    child: const Icon(Icons.edit, size: 18, color: AppColors.whiteColor),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: AppSize.verticalWidgetSpacing),

          /// FORM
          CommonTextField(controller: firstNameController, hintText: "First Name", headingText: "First Name "),
          SizedBox(height: AppSize.verticalWidgetSpacing / 2),
          CommonTextField(controller: lastNameController, hintText: "Last Name", headingText: "Last Name "),
          SizedBox(height: AppSize.verticalWidgetSpacing / 2),
          CommonTextField(controller: emailController, hintText: "Email Address", headingText: "Email Address "),
          SizedBox(height: AppSize.verticalWidgetSpacing / 2),
          CommonTextField(controller: phoneController, hintText: "Phone Number", headingText: "Phone Number "),
          SizedBox(height: AppSize.verticalWidgetSpacing / 2),
          CommonTextField(controller: departmentController, hintText: "Department", headingText: "Department "),
          SizedBox(height: AppSize.verticalWidgetSpacing / 2),
          CommonTextField(controller: designationController, hintText: "Designation", headingText: "Designation "),
          SizedBox(height: AppSize.verticalWidgetSpacing / 2),

          /// DOB PICKER
          CommonTextField(
            controller: dobController,
            hintText: "Date of Birth",
            headingText: "Date of Birth ",
            isEnable: false,
            onTap: () async {
              DateTime? date = await showDatePicker(
                context: context,
                initialDate: DateTime(1998),
                firstDate: DateTime(1970),
                lastDate: DateTime.now(),
              );

              if (date != null) {
                dobController.text = "${date.day}-${date.month}-${date.year}";
              }
            },
          ),
          SizedBox(height: AppSize.verticalWidgetSpacing),

          CommonTextField(controller: addressController, hintText: "Address", headingText: "Address"),
          SizedBox(height: AppSize.verticalWidgetSpacing),
          SizedBox(height: AppSize.verticalWidgetSpacing),

          /// SAVE BUTTON
          CommonButton(
            title: "Save Changes",
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Profile Updated")));
            },
          ),
          SizedBox(height: AppSize.verticalWidgetSpacing),
        ],
      ),
    );
  }
}
