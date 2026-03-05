import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/shared/models/role_model.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:provider/provider.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/employee/add_employee_provider.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:hrms_yb/shared/widgets/common_button.dart';
import 'package:hrms_yb/shared/widgets/common_text_field.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';

class AddEmployeeScreen extends StatelessWidget {
  const AddEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddEmployeeProvider(context: context),
      child: Consumer<AddEmployeeProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              leading: CommonWidget.backButton(
                onTap: () => GoRouter.of(context).pop(),
              ),
              title: Text(
                "Add Employee",
                style: AppTextStyle().titleTextStyle(
                  context: context,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            body: provider.isLoading
                ? CommonWidget.defaultLoader()
                : _body(context, provider),
          );
        },
      ),
    );
  }

  Widget _body(BuildContext context, AddEmployeeProvider provider) {
    return Form(
      key: provider.formKey,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(
                      AppSize.verticalWidgetSpacing,
                    ),
                    child: Column(
                      children: [
                        Card(
                          margin: EdgeInsets.all(0),
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: AppSize.verticalWidgetSpacing,
                            ),
                            width: double.infinity,
                            child: GestureDetector(
                              onTap: provider.pickImage,
                              child: CircleAvatar(
                                radius: 45,
                                backgroundColor: AppColors.borderGrey,
                                backgroundImage: provider.profilePhoto != null
                                    ? FileImage(provider.profilePhoto!)
                                    : null,
                                child: provider.profilePhoto == null
                                    ? const Icon(Icons.camera_alt)
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSize.verticalWidgetSpacing),

                        _personalDetailsWidget(provider),
                        const SizedBox(height: AppSize.verticalWidgetSpacing),

                        _contactDetailsWidget(provider),
                        const SizedBox(height: AppSize.verticalWidgetSpacing),

                        _currentAddressDetailsWidget(provider),
                        const SizedBox(height: AppSize.verticalWidgetSpacing),

                        Row(
                          children: [
                            Checkbox(
                              side: const BorderSide(
                                color: AppColors.primaryColor,
                                width: 2,
                              ),
                              value: provider.isAddressSame,
                              onChanged: (v) {
                                provider.isAddressSame = v ?? false;
                                provider.updateState();
                              },
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              visualDensity: VisualDensity.compact,
                            ),
                            Expanded(
                              child: Text(
                                "Permanent Address is same as current address.",
                                style: AppTextStyle().lableTextStyle(
                                  context: context,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (provider.isAddressSame != true) ...[
                          const SizedBox(height: AppSize.verticalWidgetSpacing),
                          _permanentAddressDetailsWidget(provider),
                        ],
                        const SizedBox(height: AppSize.verticalWidgetSpacing),

                        _educationDetailsWidget(provider),
                        const SizedBox(height: AppSize.verticalWidgetSpacing),

                        _departmentDetailsWidget(provider),
                        const SizedBox(height: AppSize.verticalWidgetSpacing),

                        _accountDetailsWidget(provider),
                      ],
                    ),
                  ),
                ),
              ),

              _buildButton(context, provider),
            ],
          ),
          if (provider.isAddingUser) CommonWidget.fullScreenLoader(),
        ],
      ),
    );
  }

  Card _personalDetailsWidget(AddEmployeeProvider provider) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(AppSize.verticalWidgetSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// PERSONAL DETAILS
            _sectionTitle("Personal Details"),

            CommonTextField(
              onChanged: (v) => provider.onChanged(),
              headingText: "First Name *",
              controller: provider.firstName,
              hintText: "Enter first name",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "";
                }
                return null;
              },
            ),

            const SizedBox(height: AppSize.verticalWidgetSpacing),

            CommonTextField(
              onChanged: (v) => provider.onChanged(),
              headingText: "Last Name *",
              controller: provider.lastName,
              hintText: "Enter last name",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "";
                }
                return null;
              },
            ),

            const SizedBox(height: AppSize.verticalWidgetSpacing),

            CommonTextField(
              onChanged: (v) => provider.onChanged(),
              headingText: "Email *",
              controller: provider.email,
              hintText: "Enter email",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "";
                }
                return null;
              },
            ),
            const SizedBox(height: AppSize.verticalWidgetSpacing),

            /// Gender
            Text(
              "Select Gender *",
              style: AppTextStyle().lableTextStyle(context: provider.context),
            ),
            SizedBox(height: 4),
            SizedBox(
              height: 47,
              child: DropdownButtonFormField<String>(
                padding: EdgeInsets.zero,
                initialValue: provider.gender,
                hint: const Text("Select Gender"),
                validator: (value) {
                  if (value == null) {
                    return ""; // triggers red border but hides text
                  }
                  return null;
                },
                decoration: provider.dropDownDecoration(),
                items: ["Male", "Female", "Other"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) {
                  provider.gender = v;
                  provider.updateState();
                },
              ),
            ),
            const SizedBox(height: AppSize.verticalWidgetSpacing),

            CommonTextField(
              onChanged: (v) => provider.onChanged(),
              headingText: "Birthday *",
              controller: provider.birthday,
              hintText: "YYYY-MM-DD",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "";
                }
                return null;
              },
              isEnable: false,
              onTap: () async {
                await provider.selectDate(
                  controller: provider.birthday,
                  initialDate: provider.birthday.text.trim().isEmpty
                      ? DateTime(
                          DateTime.now().year - 18,
                          DateTime.now().month,
                          DateTime.now().day,
                        )
                      : DateTime.parse(provider.birthday.text.trim()),
                  firstDate: DateTime(1935),
                  lastDate: DateTime(
                    DateTime.now().year - 18,
                    DateTime.now().month,
                    DateTime.now().day,
                  ),
                );
                if (provider.birthday.text.isNotEmpty) {
                  provider.age.text = getAge(provider.birthday.text).toString();
                  provider.updateState();
                }
              },
            ),
            const SizedBox(height: AppSize.verticalWidgetSpacing),

            CommonTextField(
              isEnable: false,
              onChanged: (v) => provider.onChanged(),
              headingText: "Age *",
              controller: provider.age,
              hintText: "Enter age",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "";
                }
                return null;
              },
            ),
            const SizedBox(height: AppSize.verticalWidgetSpacing),

            CommonTextField(
              onChanged: (v) => provider.onChanged(),
              headingText: "Blood Group *",
              controller: provider.bloodGroup,
              hintText: "B+ / O+",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Card _contactDetailsWidget(AddEmployeeProvider provider) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(AppSize.verticalWidgetSpacing),
        child: Column(
          children: [
            /// CONTACT DETAILS
            _sectionTitle("Contact Details"),

            CommonTextField(
              onChanged: (v) => provider.onChanged(),
              headingText: "Country Code",
              controller: provider.countryCode,
              hintText: "+91",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "";
                }
                return null;
              },
            ),

            const SizedBox(height: AppSize.verticalWidgetSpacing),

            CommonTextField(
              onChanged: (v) => provider.onChanged(),
              headingText: "Mobile Number *",
              controller: provider.mobile,
              hintText: "Enter mobile number",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Card _currentAddressDetailsWidget(AddEmployeeProvider provider) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(AppSize.verticalWidgetSpacing),
        child: Column(
          children: [
            /// CURRENT ADDRESS
            _sectionTitle("Current Address"),

            CommonTextField(
              onChanged: (v) => provider.onChanged(),
              headingText: "Street *",
              controller: provider.currentStreet,
              hintText: "Street",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "";
                }
                return null;
              },
            ),

            const SizedBox(height: AppSize.verticalWidgetSpacing),

            CommonTextField(
              onChanged: (v) => provider.onChanged(),
              headingText: "City *",
              controller: provider.currentCity,
              hintText: "City",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "";
                }
                return null;
              },
            ),

            const SizedBox(height: AppSize.verticalWidgetSpacing),

            CommonTextField(
              onChanged: (v) => provider.onChanged(),
              headingText: "State *",
              controller: provider.currentState,
              hintText: "State",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "";
                }
                return null;
              },
            ),

            const SizedBox(height: AppSize.verticalWidgetSpacing),

            CommonTextField(
              onChanged: (v) => provider.onChanged(),
              headingText: "Pincode *",
              controller: provider.currentPincode,
              hintText: "Pincode",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "";
                }
                return null;
              },
            ),

            const SizedBox(height: AppSize.verticalWidgetSpacing),

            CommonTextField(
              onChanged: (v) => provider.onChanged(),
              headingText: "Emergency Contact",
              controller: provider.currentEmergencyContact,
              hintText: "Phone number",
            ),

            const SizedBox(height: AppSize.verticalWidgetSpacing),

            CommonTextField(
              onChanged: (v) => provider.onChanged(),
              headingText: "Emergency Contact Name",
              controller: provider.currentEmergencyName,
              hintText: "Name",
            ),
          ],
        ),
      ),
    );
  }

  Card _permanentAddressDetailsWidget(AddEmployeeProvider provider) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(AppSize.verticalWidgetSpacing),
        child: Column(
          children: [
            /// CURRENT ADDRESS
            _sectionTitle("Permanent Address"),

            CommonTextField(
              onChanged: (v) => provider.onChanged(),
              headingText: "Street *",
              controller: provider.permanentStreet,
              hintText: "Street",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "";
                }
                return null;
              },
            ),

            const SizedBox(height: AppSize.verticalWidgetSpacing),

            CommonTextField(
              onChanged: (v) => provider.onChanged(),
              headingText: "City *",
              controller: provider.permanentCity,
              hintText: "City",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "";
                }
                return null;
              },
            ),

            const SizedBox(height: AppSize.verticalWidgetSpacing),

            CommonTextField(
              onChanged: (v) => provider.onChanged(),
              headingText: "State *",
              controller: provider.permanentState,
              hintText: "State",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "";
                }
                return null;
              },
            ),

            const SizedBox(height: AppSize.verticalWidgetSpacing),

            CommonTextField(
              onChanged: (v) => provider.onChanged(),
              headingText: "Pincode *",
              controller: provider.permanentPincode,
              hintText: "Pincode",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "";
                }
                return null;
              },
            ),

            const SizedBox(height: AppSize.verticalWidgetSpacing),

            CommonTextField(
              onChanged: (v) => provider.onChanged(),
              headingText: "Emergency Contact",
              controller: provider.permanentEmergencyContact,
              hintText: "Phone number",
            ),

            const SizedBox(height: AppSize.verticalWidgetSpacing),

            CommonTextField(
              onChanged: (v) => provider.onChanged(),
              headingText: "Emergency Contact Name",
              controller: provider.permanentEmergencyName,
              hintText: "Name",
            ),
          ],
        ),
      ),
    );
  }

  Card _educationDetailsWidget(AddEmployeeProvider provider) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(AppSize.verticalWidgetSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// EDUCATION
            _sectionTitle("Education"),

            CommonTextField(
              onChanged: (v) => provider.onChanged(),
              controller: provider.institutionName,
              headingText: "Institution Name *",
              hintText: "Enter Institution Name",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "";
                }
                return null;
              },
            ),
            const SizedBox(height: AppSize.verticalWidgetSpacing),
            Text(
              "Institution Type *",
              style: AppTextStyle().lableTextStyle(context: provider.context),
            ),
            SizedBox(height: 4),
            SizedBox(
              height: 47,
              child: DropdownButtonFormField<String>(
                padding: EdgeInsets.zero,
                initialValue: provider.selectedInstitutionType,
                hint: const Text("Select Institution Type"),
                validator: (value) {
                  if (value == null) {
                    return ""; // triggers red border but hides text
                  }
                  return null;
                },
                decoration: provider.dropDownDecoration(),
                items: provider.institutionType
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) {
                  provider.selectedInstitutionType = v;
                  provider.updateState();
                },
              ),
            ),

            const SizedBox(height: AppSize.verticalWidgetSpacing),

            CommonTextField(
              onChanged: (v) => provider.onChanged(),
              headingText: "Degree",
              controller: provider.degree,
              hintText: "BCA",
            ),

            const SizedBox(height: AppSize.verticalWidgetSpacing),

            CommonTextField(
              onChanged: (v) => provider.onChanged(),
              headingText: "Specialization",
              controller: provider.specialization,
              hintText: "Android Dev",
            ),

            const SizedBox(height: AppSize.verticalWidgetSpacing),

            CommonTextField(
              onChanged: (v) => provider.onChanged(),
              headingText: "Grade *",
              controller: provider.grade,
              hintText: "8.5",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "";
                }
                return null;
              },
            ),
            const SizedBox(height: AppSize.verticalWidgetSpacing),

            CommonTextField(
              onChanged: (v) => provider.onChanged(),
              headingText: "Passing Year *",
              controller: provider.yearOfPassing,
              hintText: "2018",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Card _departmentDetailsWidget(AddEmployeeProvider provider) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(AppSize.verticalWidgetSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// DEPARTMENT
            _sectionTitle("Department Details"),

            CommonTextField(
              onChanged: (v) => provider.onChanged(),
              headingText: "Department *",
              controller: provider.department,
              hintText: "IT",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "";
                }
                return null;
              },
            ),
            const SizedBox(height: AppSize.verticalWidgetSpacing),

            CommonTextField(
              onChanged: (v) => provider.onChanged(),
              headingText: "Designation *",
              controller: provider.designation,
              hintText: "Software Developer",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "";
                }
                return null;
              },
            ),
            const SizedBox(height: AppSize.verticalWidgetSpacing),

            CommonTextField(
              onChanged: (v) => provider.onChanged(),
              headingText: "Joining Date *",
              controller: provider.joiningDate,
              hintText: "YYYY-MM-DD",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "";
                }
                return null;
              },
              isEnable: false,
              onTap: () => provider.selectDate(
                controller: provider.joiningDate,
                initialDate: provider.joiningDate.text.trim().isEmpty
                    ? DateTime.now()
                    : DateTime.parse(provider.joiningDate.text.trim()),
                firstDate: DateTime(1935),
                lastDate: DateTime.now(),
              ),
            ),
            const SizedBox(height: AppSize.verticalWidgetSpacing),

            CommonTextField(
              onChanged: (v) => provider.onChanged(),
              headingText: "Salary *",
              controller: provider.salary,
              hintText: "Enter salary",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "";
                }
                return null;
              },
            ),
            const SizedBox(height: AppSize.verticalWidgetSpacing),

            Text(
              "Employement Type *",
              style: AppTextStyle().lableTextStyle(context: provider.context),
            ),
            SizedBox(height: 4),
            SizedBox(
              height: 47,
              child: DropdownButtonFormField<String>(
                padding: EdgeInsets.all(0),
                initialValue: provider.selectedEmploymentType,
                hint: const Text("Select Employement Type"),
                validator: (value) {
                  if (value == null) {
                    return ""; // triggers red border but hides text
                  }
                  return null;
                },
                decoration: provider.dropDownDecoration(),
                items: provider.employmentType
                    .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                    .toList(),
                onChanged: (v) {
                  provider.selectedEmploymentType = v;
                  provider.updateState();
                },
              ),
            ),
            const SizedBox(height: AppSize.verticalWidgetSpacing),

            Row(
              children: [
                Expanded(
                  child: CommonTextField(
                    onChanged: (v) => provider.onChanged(),
                    headingText: "Probation Start",
                    controller: provider.probationStart,
                    hintText: "YYYY-MM-DD",
                    isEnable: false,
                    onTap: () => provider.selectDate(
                      controller: provider.probationStart,
                      initialDate: provider.probationStart.text.trim().isEmpty
                          ? DateTime.now()
                          : DateTime.parse(provider.probationStart.text.trim()),
                      firstDate: DateTime(1935),
                      lastDate: DateTime.now(),
                    ),
                  ),
                ),
                const SizedBox(width: AppSize.verticalWidgetSpacing),

                ///Probasion End
                Expanded(
                  child: CommonTextField(
                    onChanged: (v) => provider.onChanged(),
                    headingText: "Probation End",
                    controller: provider.probationEnd,
                    hintText: "YYYY-MM-DD",
                    isEnable: false,
                    onTap: () => provider.selectDate(
                      controller: provider.probationEnd,
                      initialDate: provider.probationEnd.text.trim().isEmpty
                          ? DateTime.now()
                          : DateTime.parse(provider.probationEnd.text.trim()),
                      firstDate: DateTime(1935),
                      lastDate: DateTime.now(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Card _accountDetailsWidget(AddEmployeeProvider provider) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(AppSize.verticalWidgetSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ACCOUNT DETAILS
            _sectionTitle("Account Details"),

            /// Select Role
            Text(
              "Select Role *",
              style: AppTextStyle().lableTextStyle(context: provider.context),
            ),
            SizedBox(height: 4),
            SizedBox(
              height: 47,
              child: DropdownButtonFormField<RoleModel>(
                padding: EdgeInsets.zero,
                initialValue: provider.selectedRole,
                hint: const Text("Select Role"),
                validator: (value) {
                  if (value == null) {
                    return ""; // triggers red border but hides text
                  }
                  return null;
                },
                decoration: provider.dropDownDecoration(),
                items: provider.roles
                    .map(
                      (role) => DropdownMenuItem(
                        value: role,
                        child: Text(role.roleName ?? ''),
                      ),
                    )
                    .toList(),

                onChanged: (role) {
                  provider.selectedRole = role;
                  provider.updateState();
                },
              ),
            ),
            const SizedBox(height: AppSize.verticalWidgetSpacing),
            CommonTextField(
              onChanged: (v) => provider.onChanged(),
              headingText: "Create Temporary Password *",
              controller: provider.password,
              hintText: "Enter password",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, AddEmployeeProvider provider) {
    return Card(
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(0),
      ),
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.only(
          left: AppSize.verticalWidgetSpacing,
          top: 8,
          right: AppSize.verticalWidgetSpacing,
          bottom: AppSize.verticalWidgetSpacing,
        ),
        width: MediaQuery.of(context).size.width,
        child: CommonButton(
          title: "Create Employee",
          onTap: provider.createEmployee,
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  int getAge(String bDate) {
    DateTime birthDate = DateTime.parse(bDate);
    final today = DateTime.now();

    int age = today.year - birthDate.year;

    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    return age;
  }
}
