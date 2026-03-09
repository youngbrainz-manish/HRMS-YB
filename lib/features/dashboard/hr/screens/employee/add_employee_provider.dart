import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/network/dio_api_request.dart';
import 'package:hrms_yb/core/network/dio_api_services.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/employee/employee_response_model.dart';
import 'package:hrms_yb/shared/models/reporting_user_model.dart';
import 'package:hrms_yb/shared/models/role_model.dart';
import 'package:hrms_yb/shared/models/user_category_model.dart';
import 'package:hrms_yb/shared/widgets/common_image_picker.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:image_picker/image_picker.dart';

class AddEmployeeProvider extends ChangeNotifier {
  final BuildContext context;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  EmployeeModel? employeeModel;
  EmployeeDetailsModel? employeeDetailsModel;

  AddEmployeeProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Map<String, dynamic>? data =
          GoRouter.of(context).state.extra as Map<String, dynamic>?;
      employeeModel = data?['employeeModel'];
      _init();
    });
  }

  bool isLoading = false;
  List<RoleModel> roles = [];
  List<ReportingUserModel> reportingUserList = [];
  List<UserCategoryModel> userCategoryList = [];

  final ExpansibleController personalController = ExpansibleController();
  final ExpansibleController educationController = ExpansibleController();
  final ExpansibleController addressController = ExpansibleController();
  final ExpansibleController employeementController = ExpansibleController();
  final ExpansibleController accountController = ExpansibleController();

  RoleModel? selectedRole;
  List<String> institutionType = [
    "School",
    "College",
    "University",
    "Institute",
    "Other",
  ];
  String? selectedInstitutionType;
  String? profileImagePath;
  List<String> employmentType = ["Full-Time", "Part-Time"];

  /// PERSONAL
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final age = TextEditingController();
  final birthday = TextEditingController();
  final bloodGroup = TextEditingController();

  String? gender;

  /// CONTACT
  final countryCode = TextEditingController(text: "+91");
  final mobile = TextEditingController();

  /// CURRENT ADDRESS
  final currentStreet = TextEditingController();
  final currentCity = TextEditingController();
  final currentState = TextEditingController();
  final currentPincode = TextEditingController();
  final currentEmergencyContact = TextEditingController();
  final currentEmergencyName = TextEditingController();

  /// PERMANENT ADDRESS
  final permanentStreet = TextEditingController();
  final permanentCity = TextEditingController();
  final permanentState = TextEditingController();
  final permanentPincode = TextEditingController();
  final permanentEmergencyContact = TextEditingController();
  final permanentEmergencyName = TextEditingController();

  /// EDUCATION
  final institutionName = TextEditingController();
  final degree = TextEditingController();
  final specialization = TextEditingController();
  final grade = TextEditingController();
  final yearOfPassing = TextEditingController();

  /// DEPARTMENT
  final department = TextEditingController();
  final designation = TextEditingController();
  final joiningDate = TextEditingController();
  final salary = TextEditingController();
  final probationStart = TextEditingController();
  final probationEnd = TextEditingController();
  String? selectedEmploymentType;
  ReportingUserModel? selectedReportingToUser;
  UserCategoryModel? selectedUserCategory;
  TextEditingController lastWorkingDayController = TextEditingController();

  /// ACCOUNT
  final password = TextEditingController(text: "Abc@1234");

  /// IMAGE
  File? profilePhoto;
  final ImagePicker picker = ImagePicker();
  bool isAddressSame = false;
  bool isAddingUser = false;

  Future<void> _init() async {
    isLoading = true;
    notifyListeners();
    await getRoles();
    await getReportingUsers();
    await getUserCategory();
    if (employeeModel?.userId != null) {
      await getEmployeeDetail(id: employeeModel?.userId ?? 0);
      setInitFormData();
    }
    Future.delayed(Duration(seconds: 2), () {
      isLoading = false;
      notifyListeners();
    });
  }

  Future<void> getRoles() async {
    String rolesUrl = DioApiServices.getRoles;
    try {
      var response = await DioApiRequest().getCommonApiCall(rolesUrl);
      roles = response?.data['data']['roles'] != null
          ? List<RoleModel>.from(
              response?.data['data']['roles'].map((x) => RoleModel.fromJson(x)),
            )
          : [];
    } catch (e) {
      debugPrint("object route => Eception Get Roles => $e");
    }
  }

  Future<void> getReportingUsers() async {
    String url = DioApiServices.getRoleForReporting;
    try {
      var response = await DioApiRequest().getCommonApiCall(url);
      reportingUserList = response?.data['data'] != null
          ? List<ReportingUserModel>.from(
              response?.data['data'].map((x) => ReportingUserModel.fromJson(x)),
            )
          : [];
    } catch (e) {
      debugPrint("object route => Eception Get ReportingUserModel => $e");
    }
  }

  Future<void> getUserCategory() async {
    String url = DioApiServices.getUserCategory;
    try {
      var response = await DioApiRequest().getCommonApiCall(url);
      userCategoryList = response?.data['data'] != null
          ? List<UserCategoryModel>.from(
              response?.data['data'].map((x) => UserCategoryModel.fromJson(x)),
            )
          : [];
    } catch (e) {
      debugPrint("object route => Eception Get UserCategoryModel => $e");
    }
  }

  void updateState() {
    notifyListeners();
  }

  /// PICK IMAGE
  Future pickImage() async {
    File? image = await CommonImagePicker.showImageSourcePicker(context);

    if (image != null) {
      profilePhoto = File(image.path);
      notifyListeners();
    }
  }

  /// Select Date
  Future<void> selectDate({
    required TextEditingController controller,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
  }) async {
    final date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (date != null) {
      controller.text =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    }
    notifyListeners();
  }

  /// CREATE EMPLOYEE API
  Future createEmployee() async {
    personalController.expand();
    addressController.expand();
    educationController.expand();
    employeementController.expand();
    await Future.delayed(Duration(seconds: 1), () {});
    if (!(formKey.currentState?.validate() ?? false)) {
      CommonWidget.customSnackbar(
        context: context, // ignore: use_build_context_synchronously
        description: "Please fill all required field",
        type: SnackbarType.error,
      );
      return;
    }
    personalController.collapse();
    addressController.collapse();
    educationController.collapse();
    employeementController.collapse();

    String url = employeeModel == null
        ? DioApiServices.createEmployee
        : "${DioApiServices.updateEmployee}/${employeeDetailsModel?.userId}";

    try {
      isAddingUser = true;
      notifyListeners();

      /// CURRENT ADDRESS JSON
      Map<String, dynamic> currentAddress = {
        "street": currentStreet.text,
        "city": currentCity.text,
        "state": currentState.text,
        "pincode": currentPincode.text,
        "emergency_contact": currentEmergencyContact.text,
        "emergency_contact_name": currentEmergencyName.text,
      };

      /// PERMANENT ADDRESS JSON
      Map<String, dynamic> permanentAddress = {
        "street": permanentStreet.text,
        "city": permanentCity.text,
        "state": permanentState.text,
        "pincode": permanentPincode.text,
        "emergency_contact": permanentEmergencyContact.text,
        "emergency_contact_name": permanentEmergencyName.text,
      };

      /// EDUCATION JSON
      List<Map<String, dynamic>> education = [
        {
          "institution_name": institutionName.text,
          "type_of_institution": selectedInstitutionType,
          "year_of_passing": int.tryParse(yearOfPassing.text),
          "grade": grade.text,
          "degree": degree.text,
          "specialization": specialization.text,
        },
      ];

      /// DEPARTMENT JSON
      Map<String, dynamic> departmentData = {
        "dept_name": department.text,
        "designation": designation.text,
        "joining_date": joiningDate.text,
        "salary": salary.text,
        "employement_type": selectedEmploymentType,
        "last_working_day": "",
        "reporting_to": selectedReportingToUser?.userId,
        "probation_start": probationStart.text,
        "probation_end": probationEnd.text,
        "user_category_id": selectedUserCategory?.userCategoryId ?? 1,
      };

      FormData formData = FormData.fromMap({
        "first_name": firstName.text,
        "last_name": lastName.text,
        "email": email.text,
        "gender": gender?.toLowerCase(),
        "age": age.text,
        "maritial_status": "Unmarried",
        "country_code": countryCode.text,
        "mobile_no": mobile.text,
        "birthday": birthday.text,
        "blood_group": bloodGroup.text,
        "status": "Active",

        "current_address": jsonEncode(currentAddress),
        "permanent_address": isAddressSame
            ? jsonEncode(currentAddress)
            : jsonEncode(permanentAddress),
        "education": jsonEncode(education),
        "department": jsonEncode(departmentData),
        "role_id": selectedRole?.roleId ?? '',
        if (profilePhoto != null) ...{
          "profile_photo": await MultipartFile.fromFile(
            profilePhoto!.path,
            filename: profilePhoto!.path.split('/').last,
          ),
        } else ...{
          "profile_photo": profileImagePath ?? '',
        },
      });
      if (employeeModel == null) {
        formData.fields.add(MapEntry("password", password.text));
      }

      dynamic response;
      if (employeeModel == null) {
        response = await DioApiRequest().postCommonApiCall(formData, url);
      } else {
        response = await DioApiRequest().putCommonApiCall(formData, url);
      }

      if (response.data['success'] == true) {
        CommonWidget.customSnackbar(
          context: context, // ignore: use_build_context_synchronously
          description: response.data['message'] ?? "User created suessfully!",
          type: SnackbarType.success,
        );
        // ignore: use_build_context_synchronously
        GoRouter.of(context).pop(true);
      } else {
        CommonWidget.customSnackbar(
          context: context, // ignore: use_build_context_synchronously
          description:
              response.data['message'] ?? "Something went wroge! Try again.",
          type: SnackbarType.error,
        );
      }
      isAddingUser = false;
      notifyListeners();
    } catch (e) {
      isAddingUser = false;
      notifyListeners();
      debugPrint(e.toString());
    }
  }

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    mobile.dispose();
    super.dispose();
  }

  InputDecoration dropDownDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),

      // hide error text
      errorStyle: const TextStyle(height: 2, fontSize: 0),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.borderGrey, width: 1),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.borderGrey, width: 1),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.primaryColor, width: 1),
      ),

      // red border when validation fails
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.errorColor, width: 1.5),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.errorColor, width: 1.5),
      ),
    );
  }

  void onChanged() {
    // formKey.currentState?.validate();
  }

  Future<void> getEmployeeDetail({required int id}) async {
    String url = "${DioApiServices.getUserById}/$id";

    try {
      var response = await DioApiRequest().getCommonApiCall(url);
      if (response?.data['data'] != null && response?.data['success'] == true) {
        employeeDetailsModel = EmployeeDetailsModel.fromJson(
          response?.data['data'],
        );
      }
    } catch (e) {
      debugPrint("object route => get employee exception $e");
    }
    notifyListeners();
  }

  void setInitFormData() {
    profileImagePath = employeeDetailsModel?.profilePhoto;
    firstName.text = employeeDetailsModel?.firstName ?? '';
    lastName.text = employeeDetailsModel?.lastName ?? '';
    email.text = employeeDetailsModel?.email ?? '';
    gender = employeeDetailsModel?.gender == "male"
        ? "Male"
        : employeeDetailsModel?.gender == 'female'
        ? "Female"
        : null;
    birthday.text = employeeDetailsModel?.birthday ?? '';
    age.text = (employeeDetailsModel?.age ?? "").toString();
    bloodGroup.text = employeeDetailsModel?.bloodGroup ?? '';
    countryCode.text = employeeDetailsModel?.countryCode ?? '+91';
    mobile.text = employeeDetailsModel?.mobileNo ?? '';
    if ((employeeDetailsModel?.addresses ?? []).isNotEmpty) {
      for (var address in employeeDetailsModel!.addresses!) {
        if (address.addressType?.toLowerCase() == "Current".toLowerCase()) {
          currentStreet.text = address.street ?? '';
          currentCity.text = address.city ?? '';
          currentState.text = address.state ?? '';
          currentPincode.text = address.pincode ?? '';
          currentEmergencyContact.text = address.emergencyContact ?? '';
          currentEmergencyName.text = address.emergencyContactName ?? '';
        }
        if (address.addressType?.toLowerCase() == "Permanent".toLowerCase()) {
          permanentStreet.text = address.street ?? '';
          permanentCity.text = address.city ?? '';
          permanentState.text = address.state ?? '';
          permanentPincode.text = address.pincode ?? '';
          permanentEmergencyContact.text = address.emergencyContact ?? '';
          permanentEmergencyName.text = address.emergencyContactName ?? '';
        }
      }
    }

    if ((employeeDetailsModel?.education ?? []).isNotEmpty) {
      Education education = employeeDetailsModel!.education!.first;
      institutionName.text = education.institutionName ?? '';
      selectedInstitutionType = education.typeOfInstitution ?? '';
      degree.text = education.degree ?? '';
      specialization.text = education.specialization ?? '';
      grade.text = education.grade ?? '';
      yearOfPassing.text = (education.yearOfPassing ?? '').toString();
    }

    if (employeeDetailsModel?.department != null) {
      Department dep = employeeDetailsModel!.department!;

      department.text = dep.deptName ?? '';
      designation.text = dep.designation ?? '';
      joiningDate.text = dep.joiningDate ?? '';
      salary.text = (dep.salary ?? '').toString();
      selectedEmploymentType = dep.employementType ?? '';
      probationStart.text = (dep.probationStart ?? '').toString();
      probationEnd.text = (dep.probationEnd ?? '').toString();
    }

    if (employeeDetailsModel?.role != null) {
      RoleModel relectedRole = RoleModel.fromJson(
        employeeDetailsModel!.role!.toJson(),
      );
      selectedRole =
          roles.where((data) => data.roleId == relectedRole.roleId).isNotEmpty
          ? roles.firstWhere((data) => data.roleId == relectedRole.roleId)
          : null;
      notifyListeners();
    }
  }
}
