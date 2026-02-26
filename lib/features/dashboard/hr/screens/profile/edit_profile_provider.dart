import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hrms_yb/core/network/authentication_data.dart';
import 'package:hrms_yb/core/network/dio_api_request.dart';
import 'package:hrms_yb/core/network/dio_api_services.dart';
import 'package:hrms_yb/shared/widgets/common_image_picker.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';

class EditProfileProvider extends ChangeNotifier {
  final BuildContext context;
  bool isLoading = false;
  bool updatingProfile = false;
  File? imageFile;
  String? imagePath;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  ///Address
  final TextEditingController cAddStreet = TextEditingController();
  final TextEditingController cAddCity = TextEditingController();
  final TextEditingController cAddState = TextEditingController();
  final TextEditingController cAddPincode = TextEditingController();
  final TextEditingController cAddEmergContact = TextEditingController();
  final TextEditingController cAddEmergContactName = TextEditingController();

  final TextEditingController pAddStreet = TextEditingController();
  final TextEditingController pAddCity = TextEditingController();
  final TextEditingController pAddState = TextEditingController();
  final TextEditingController pAddPincode = TextEditingController();
  final TextEditingController pAddEmergContact = TextEditingController();
  final TextEditingController pAddEmergContactName = TextEditingController();

  bool checkBoxStatus = false;
  bool isProfileUpdated = false;

  EditProfileProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  void _init() {
    isLoading = true;
    notifyListeners();
    setInitialData();
    notifyListeners();
  }

  void setInitialData() {
    firstNameController.text = AuthenticationData.userModel?.firstName ?? '';
    lastNameController.text = AuthenticationData.userModel?.lastName ?? '';
    emailController.text = AuthenticationData.userModel?.email ?? '';
    phoneController.text = AuthenticationData.userModel?.mobileNo ?? '';
    departmentController.text = AuthenticationData.userModel?.department?.deptName ?? '';
    designationController.text = AuthenticationData.userModel?.department?.designation ?? '';
    dobController.text = AuthenticationData.userModel?.birthday ?? '';
    imagePath = AuthenticationData.userModel?.profilePhoto;
    if ((AuthenticationData.userModel?.addresses ?? []).isNotEmpty) {
      for (var address in AuthenticationData.userModel!.addresses!) {
        if (address.addressType == 'Current') {
          cAddStreet.text = address.street ?? '';
          cAddCity.text = address.city ?? '';
          cAddState.text = address.state ?? '';
          cAddPincode.text = address.pincode ?? '';
          cAddEmergContact.text = address.emergencyContact ?? '';
          cAddEmergContactName.text = address.emergencyContactName ?? '';
        } else {
          pAddStreet.text = address.street ?? '';
          pAddCity.text = address.city ?? '';
          pAddState.text = address.state ?? '';
          pAddPincode.text = address.pincode ?? '';
          pAddEmergContact.text = address.emergencyContact ?? '';
          pAddEmergContactName.text = address.emergencyContactName ?? '';
        }
      }
    }
    Future.delayed(Duration(milliseconds: 300), () {
      isLoading = false;
      notifyListeners();
    });
  }

  void updateState() {
    notifyListeners();
  }

  Future<void> picImage() async {
    File? image = await CommonImagePicker.showImageSourcePicker(context);

    if (image != null) {
      imageFile = image;
      imagePath = image.path;
    }
    notifyListeners();
  }

  Future<void> validateAndUpdate() async {
    updatingProfile = true;
    isProfileUpdated = true;
    notifyListeners();

    Map<String, dynamic> cAdress = {
      "street": cAddStreet.text.trim(),
      "city": cAddCity.text.trim(),
      "state": cAddState.text.trim(),
      "pincode": cAddPincode.text.trim().toString(),
      "emergency_contact": cAddEmergContact.text.trim(),
      "emergency_contact_name": cAddEmergContactName.text.trim(),
    };
    Map<String, dynamic> pAdress = {
      "street": pAddStreet.text.trim(),
      "city": pAddCity.text.trim(),
      "state": pAddState.text.trim(),
      "pincode": pAddPincode.text.trim().toString(),
      "emergency_contact": pAddEmergContact.text.trim(),
      "emergency_contact_name": pAddEmergContactName.text.trim(),
    };

    Map<String, dynamic> data = {
      "first_name": firstNameController.text.trim(),
      "last_name": lastNameController.text.trim(),
      "email": emailController.text.trim(),
      "gender": "male",
      "age": "23",
      "mobile_no": phoneController.text.trim(),
      "birthday": dobController.text.trim(),
      "maritial_status": "Married",
      "current_address": jsonEncode(cAdress),
      "permanent_address": jsonEncode(checkBoxStatus ? cAdress : pAdress),
      if (imageFile != null) ...{
        if ((imageFile?.path ?? '').isNotEmpty)
          "profile_photo": await MultipartFile.fromFile(imageFile!.path, filename: imageFile!.path.split('/').last),
      } else if ((imagePath ?? "").isNotEmpty) ...{
        "profile_photo": imagePath,
      },
    };

    FormData formData = FormData.fromMap(data);

    String url = DioApiServices.updateProfile;
    try {
      var response = await DioApiRequest().putCommonApiCall(formData, url);
      if (response.data['success'] == true) {
        if (!context.mounted) return;
        CommonWidget.customSnackbar(
          context: context, // ignore: use_build_context_synchronously
          title: "Congratulations!",
          description: response.data['message'] ?? "Please fill all fields",
          type: SnackbarType.success,
        );
      } else {
        if (!context.mounted) return;
        CommonWidget.customSnackbar(
          context: context, // ignore: use_build_context_synchronously
          title: "Oops!",
          description: response.data['message'] ?? "Please fill all fields",
          type: SnackbarType.error,
        );
      }
    } catch (e) {
      debugPrint("object route => $e");
    }
    updatingProfile = false;
    notifyListeners();
  }

  void updatePermanentAddress() {
    if (checkBoxStatus == true) {
      pAddStreet.text = cAddStreet.text;
      pAddCity.text = cAddCity.text;
      pAddState.text = cAddState.text;
      pAddPincode.text = cAddPincode.text;
      pAddEmergContact.text = cAddEmergContact.text;
      pAddEmergContactName.text = cAddEmergContactName.text;
    } else {
      for (var address in AuthenticationData.userModel!.addresses!) {
        if (address.addressType == "Permanent") {
          pAddStreet.text = address.street ?? '';
          pAddCity.text = address.city ?? '';
          pAddState.text = address.state ?? '';
          pAddPincode.text = address.pincode ?? '';
          pAddEmergContact.text = address.emergencyContact ?? '';
          pAddEmergContactName.text = address.emergencyContactName ?? '';
        }
      }
    }
    notifyListeners();
  }
}
