import 'package:flutter/material.dart';
import 'package:hrms_yb/core/network/dio_api_request.dart';
import 'package:hrms_yb/core/network/dio_api_services.dart';
import 'package:hrms_yb/shared/common_method.dart';
import 'package:hrms_yb/shared/models/leave_module/team_leave_data_model.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';

class TeamRequestsTabProvider extends ChangeNotifier {
  final BuildContext context;

  bool isLoading = false;
  List<TeamLeaveDataModel> teamLeaveDataModel = [];

  TeamRequestsTabProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  void _init() {
    getTeamsLeaveRequest();
    notifyListeners();
  }

  Future<void> getTeamsLeaveRequest() async {
    isLoading = true;
    notifyListeners();
    String url = DioApiServices.getMyTeamLeaveRequest;
    try {
      var response = await DioApiRequest().getCommonApiCall(url);
      if (response?.data['success'] == true) {
        teamLeaveDataModel =
            (response?.data['data'] as List?)
                ?.map((e) => TeamLeaveDataModel.fromJson(e))
                .toList() ??
            [];
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
      debugPrint("object route => GET MY TEAM LEAVE EXCEPTION => $e");
    }
    isLoading = false;
    notifyListeners();
  }
}
