import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hrms_yb/core/constants/app_constants.dart';
import 'package:hrms_yb/core/network/authentication_data.dart';
import 'package:hrms_yb/core/network/common_response.dart';
import 'package:hrms_yb/core/network/dio_api_request.dart';
import 'package:hrms_yb/core/network/dio_api_services.dart';
import 'package:hrms_yb/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  final BuildContext context;

  UserModel? _user;
  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _user != null;

  TextEditingController emailController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  LoginProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  void _init() {}

  Future<bool?> login({required String email, required String password}) async {
    _isLoading = true;
    notifyListeners();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var response = await DioApiRequest().postCommonApiCall({
      "email": email,
      "password": password,
    }, DioApiServices.login);

    CommonResponse commonResponse = CommonResponse.fromJson(response.data);
    if (commonResponse.success == true) {
      AuthenticationData.token = response.data['data']['token'];
      AuthenticationData.userModel = UserModel.fromJson(response.data['data']);
      _user = AuthenticationData.userModel;
      String userJson = jsonEncode(AuthenticationData.userModel?.toJson());
      await sharedPreferences.setString(AppConstants.userDetails, userJson);
      notifyListeners();
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
