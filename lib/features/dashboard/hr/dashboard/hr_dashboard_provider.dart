import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/network/authentication_data.dart';
import 'package:hrms_yb/core/network/dio_api_request.dart';
import 'package:hrms_yb/core/network/dio_api_services.dart';
import 'package:hrms_yb/core/router/app_router.dart';
import 'package:hrms_yb/models/user_model.dart';
import 'package:hrms_yb/shared/common_method.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';

class HrDashboardProvider extends ChangeNotifier {
  final BuildContext context;
  int currentIndex = 0;

  String title = "Home";

  HrDashboardProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  void onItemTapped(int index) {
    switch (index) {
      case 0:
        GoRouter.of(rootNavigatorKey.currentState!.context).go(AppRouter.hrDashboardRoute);
      case 1:
        GoRouter.of(rootNavigatorKey.currentState!.context).go(AppRouter.hrEmployeeScreenRoute);
      case 2:
        GoRouter.of(rootNavigatorKey.currentState!.context).go(AppRouter.hrAttendanceScreenRoute);
      case 3:
        GoRouter.of(rootNavigatorKey.currentState!.context).go(AppRouter.hrLeaveScreenRoute);
      case 4:
        GoRouter.of(rootNavigatorKey.currentState!.context).go(AppRouter.hrPayrollScreenRoute);
      case 5:
        GoRouter.of(rootNavigatorKey.currentState!.context).go(AppRouter.hrHolidayScreenRoute);
    }
    currentIndex = index;
    notifyListeners();
  }

  void _init() {
    getProfileData();
  }

  Future<void> getProfileData() async {
    String employeeId = AuthenticationData.userModel?.userId.toString() ?? '';
    String url = "${DioApiServices.getUserById}/$employeeId";
    try {
      var response = await DioApiRequest().getCommonApiCall(url);
      if (response != null && response.data?['success'] == true) {
        AuthenticationData.userModel = UserModel.fromJson(response.data['data']);
      } else {
        CommonWidget.customSnackbar(
          context: context, // ignore: use_build_context_synchronously
          description: response?.data?['message'],
          type: SnackbarType.error,
        );
        if (context.mounted) {
          await CommonMethod().errageAllDataAndGotoLogin(context: context);
        }
      }
    } catch (e) {
      // print("Error fetching profile data: $e");
    }
  }

  void changeTitle(String s) {
    title = s;
    notifyListeners();
  }
}
