import 'package:flutter/material.dart';
import 'package:hrms_yb/core/network/dio_api_request.dart';
import 'package:hrms_yb/core/network/dio_api_services.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/hr_leave_management/leave_tracker/models/leave_plan_data_model.dart';
import 'package:hrms_yb/shared/common_method.dart';

class MyLeavePlanProvider extends ChangeNotifier {
  final BuildContext context;

  bool isLoading = false;
  LeavePlanDataModel? leavePlanDataModel;

  MyLeavePlanProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  Future<void> _init() async {
    await getMyLeavePlan();
    notifyListeners();
  }

  Future<void> getMyLeavePlan() async {
    isLoading = true;
    notifyListeners();
    String url = DioApiServices.getMyLeavePlan;

    try {
      var response = await DioApiRequest().getCommonApiCall(url);

      if (response?.data['success']) {
        leavePlanDataModel = LeavePlanDataModel.fromJson(response?.data['data']);
      } else {
        if (context.mounted) {
          CommonMethod().errageAllDataAndGotoLogin(context: context);
        }
      }
    } catch (e) {
      debugPrint("object route => GET MY LEAVE PLAN EXCEPTION $e");
    }
    isLoading = false;
    notifyListeners();
  }
}
