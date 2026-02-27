import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hrms_yb/core/constants/app_constants.dart';
import 'package:hrms_yb/core/network/authentication_data.dart';
import 'package:hrms_yb/core/network/common_response.dart';
import 'package:hrms_yb/core/network/dio_api_request.dart';
import 'package:hrms_yb/core/network/dio_api_services.dart';
import 'package:hrms_yb/models/user_model.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  final BuildContext context;

  UserModel? userModel;
  bool isLoading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  bool hidePass = true;

  LoginProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  void _init() {}

  Future<bool?> login({required String email, required String password}) async {
    isLoading = true;
    notifyListeners();
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var response = await DioApiRequest().postCommonApiCall({
        "email": email,
        "password": password,
      }, DioApiServices.login);

      CommonResponse commonResponse = CommonResponse.fromJson(response.data);

      if (commonResponse.success == true) {
        AuthenticationData.token = response.data['data']['token'];

        List<Role> roles = (response.data['data']['role'] as List).map((e) => Role.fromJson(e)).toList();
        AuthenticationData.userModel = UserModel(
          userId: response.data['data']['user_id'],
          firstName: response.data['data']['first_name'],
          lastName: response.data['data']['last_name'],
          email: response.data['data']['email'],
          role: roles.first,
          profilePhoto: response.data['data']['profile_photo'],
          // roleId: response.data['data']['role_id'],
        );

        userModel = AuthenticationData.userModel;
        String userJson = jsonEncode(AuthenticationData.userModel?.toJson());
        await sharedPreferences.setString(AppConstants.userDetails, userJson);
        await sharedPreferences.setString(AppConstants.token, AuthenticationData.token);
        notifyListeners();
        isLoading = false;
        notifyListeners();
        return true;
      } else {
        CommonWidget.customSnackbar(
          context: context, // ignore: use_build_context_synchronously
          description: commonResponse.message ?? "Something went wronge!",
          type: SnackbarType.error,
        );
        isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void logout() {
    userModel = null;
    notifyListeners();
  }

  void updateState() {
    notifyListeners();
  }
}
