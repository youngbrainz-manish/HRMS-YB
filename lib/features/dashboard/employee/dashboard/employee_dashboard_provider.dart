import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/network/authentication_data.dart';
import 'package:hrms_yb/core/network/dio_api_request.dart';
import 'package:hrms_yb/core/network/dio_api_services.dart';
import 'package:hrms_yb/core/router/app_router.dart';
import 'package:hrms_yb/core/theme/app_theme_provider.dart';
import 'package:hrms_yb/models/user_model.dart';
import 'package:hrms_yb/shared/common_method.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:provider/provider.dart';

class EmployeeDashboardProvider extends ChangeNotifier {
  final BuildContext context;
  int currentIndex = 0;
  List<String> titleNames = ["Home", "Attendance", "Leave", "PatSlip", "Profile"];
  final GlobalKey themeSwitchKey = GlobalKey();
  EmployeeDashboardProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  void onItemTapped(int index) {
    switch (index) {
      case 0:
        GoRouter.of(rootNavigatorKey.currentState!.context).go(AppRouter.employeeshomeScreenRoute);
      case 1:
        GoRouter.of(rootNavigatorKey.currentState!.context).go(AppRouter.employeesAttendaceScreenRoute);
      case 2:
        GoRouter.of(rootNavigatorKey.currentState!.context).go(AppRouter.employeesLeaveScreenRoute);
      case 3:
        GoRouter.of(rootNavigatorKey.currentState!.context).go(AppRouter.employeesPaySlipScreenRoute);
      case 4:
        GoRouter.of(rootNavigatorKey.currentState!.context).go(AppRouter.employeesProfileScreenRoute);
    }
    currentIndex = index;
    notifyListeners();
  }

  void _init() {
    getProfileData();
  }

  Future<void> getProfileData() async {
    String employeeId = AuthenticationData.userModel?.empId.toString() ?? '';
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

  void toggleThemeMode() {
    final renderBox = themeSwitchKey.currentContext?.findRenderObject() as RenderBox?;
    final origin = renderBox?.localToGlobal(Offset(renderBox.size.width / 2, renderBox.size.height / 2)) ?? Offset.zero;
    context.read<AppThemeProvider>().toggleThemeWithAnimation(
      origin: origin,
      overlayState: Overlay.of(context),
      devicePixelRatio: MediaQuery.of(context).devicePixelRatio,
    );
  }
}
