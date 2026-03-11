import 'package:flutter/material.dart';
import 'package:hrms_yb/core/network/dio_api_request.dart';
import 'package:hrms_yb/core/network/dio_api_services.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/hr_leave_management/leave_plans/all_leave_plan/all_leave_plan_response_model.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';

class AllLeavePlanProvider extends ChangeNotifier {
  final BuildContext context;

  AllLeavePlanProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  bool isLoading = false;
  AllLeavePlansResponseModel? leavePlansResponseModel;
  List<LeavePlan> get leavePlans => leavePlansResponseModel?.data?.data ?? [];

  void _init() {
    getAllLeavePlans();
  }

  Future<void> getAllLeavePlans() async {
    isLoading = true;
    notifyListeners();

    String url = DioApiServices.getAllLeavePlans;

    try {
      var response = await DioApiRequest().getCommonApiCall(url);

      if (response?.data['success'] == true) {
        leavePlansResponseModel = AllLeavePlansResponseModel.fromJson(response?.data);
      } else {
        if (context.mounted) {
          CommonWidget.customSnackbar(
            context: context,
            description: "Failed to fetch leave plans",
            type: SnackbarType.error,
          );
        }
      }
    } catch (e) {
      debugPrint("Exception in getAllLeavePlans => $e");
    }

    isLoading = false;
    notifyListeners();
  }
}
