import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/network/dio_api_request.dart';
import 'package:hrms_yb/core/network/dio_api_services.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/shared/models/role_model.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:image_picker/image_picker.dart';

class AddEmployeeProvider extends ChangeNotifier {
  final BuildContext context;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AddEmployeeProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  bool isLoading = false;
  List<RoleModel> roles = [];
  RoleModel? selectedRole;
  List<String> institutionType = [
    "School",
    "College",
    "University",
    "Institute",
    "Other",
  ];
  String? selectedInstitutionType;

  List<String> employmentType = ["Full-Time", "Part-Time"];
  String? selectedEmploymentType;

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

  final reportingTo = TextEditingController();
  final probationStart = TextEditingController();
  final probationEnd = TextEditingController();

  /// ACCOUNT
  final password = TextEditingController();

  /// IMAGE
  File? profilePhoto;

  final ImagePicker picker = ImagePicker();

  bool isAddressSame = false;

  bool isAddingUser = false;

  void _init() {
    getRoles();
  }

  Future<void> getRoles() async {
    isLoading = true;
    notifyListeners();
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
    isLoading = false;
    notifyListeners();
  }

  void updateState() {
    notifyListeners();
  }

  /// PICK IMAGE
  Future pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

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
    if (!(formKey.currentState?.validate() ?? false)) {
      CommonWidget.customSnackbar(
        context: context,
        description: "Please fill all required field",
        type: SnackbarType.error,
      );
      return;
    }
    String url = DioApiServices.createEmployee;
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
        "reporting_to": reportingTo.text,
        "probation_start": probationStart.text,
        "probation_end": probationEnd.text,
        "user_category_id": 1,
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

        "password": password.text,
        "role_id": selectedRole?.roleId ?? '',

        if (profilePhoto != null)
          "profile_photo": await MultipartFile.fromFile(
            profilePhoto!.path,
            filename: profilePhoto!.path.split('/').last,
          ),
      });

      final response = await DioApiRequest().postCommonApiCall(formData, url);

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
    formKey.currentState?.validate();
  }
}
