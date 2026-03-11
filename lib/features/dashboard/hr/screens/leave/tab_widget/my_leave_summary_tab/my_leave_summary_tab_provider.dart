import 'package:flutter/material.dart';
import 'package:hrms_yb/core/network/dio_api_request.dart';
import 'package:hrms_yb/core/network/dio_api_services.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/leave/models/leave_summary_model.dart';
import 'package:hrms_yb/shared/common_method.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';

class MyLeaveSummaryTabProvider extends ChangeNotifier {
  final BuildContext context;
  LeaveSummaryModel? leaveSummaryModel;
  bool isLoading = false;

  MyLeaveSummaryTabProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  void _init() {
    getLeaveSummary();
    notifyListeners();
  }

  Future<void> getLeaveSummary() async {
    isLoading = true;
    notifyListeners();
    String url = DioApiServices.leaveSummary;

    try {
      var response = await DioApiRequest().getCommonApiCall(url);

      if (response?.data['success'] == true) {
        leaveSummaryModel = LeaveSummaryModel.fromJson(response?.data);
      } else {
        if (context.mounted) {
          CommonWidget.customSnackbar(
            context: context,
            description: "Something went wrong! Try again.",
            type: SnackbarType.error,
          );
          CommonMethod().errageAllDataAndGotoLogin(context: context);
        }
      }
    } catch (e) {
      debugPrint("Object route => Eception getting summary");
    }
    if (context.mounted) {
      isLoading = false;
      notifyListeners();
    }
  }
}
