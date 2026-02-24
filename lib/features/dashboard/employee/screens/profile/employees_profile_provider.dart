import 'package:flutter/material.dart';
import 'package:hrms_yb/core/network/authentication_data.dart';
import 'package:hrms_yb/core/network/dio_api_request.dart';
import 'package:hrms_yb/core/network/dio_api_services.dart';
import 'package:hrms_yb/models/user_model.dart';

class EmployeesProfileProvider extends ChangeNotifier {
  final BuildContext context;
  bool isLoading = false;
  UserModel? employee;

  EmployeesProfileProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  void _init() {
    getProfileData();
    notifyListeners();
  }

  Future<void> getProfileData() async {
    isLoading = true;
    notifyListeners();
    String employeeId = AuthenticationData.userModel?.empId.toString() ?? '';
    String url = "${DioApiServices.getUserById}/$employeeId";
    var response = await DioApiRequest().getCommonApiCall(url);
    if (response != null && response.data?['success'] == true) {
      AuthenticationData.userModel = UserModel.fromJson(response.data['data']);
      employee = AuthenticationData.userModel;
      notifyListeners();
    }
    isLoading = false;
    notifyListeners();
  }
}
