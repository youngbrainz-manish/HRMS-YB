import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/network/dio_api_request.dart';
import 'package:hrms_yb/core/network/dio_api_services.dart';
import 'package:hrms_yb/core/router/app_router.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';

enum ForgotPassState { init, verifyOtp, setPassword }

class ForgotPasswordProvider extends ChangeNotifier {
  final BuildContext context;

  ForgotPassState currentState = ForgotPassState.init;
  bool isLoading = false;
  String resrtPassToken =
      'yJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJvdHBfaWQiOjIsImVtYWlsIjoieW91bmdicmFpbnoucnVkcmFAZ21haWwuY29tIiwicHVycG9zZSI6IlBBU1NXT1JEX1JFU0VUIiwiaWF0IjoxNzcyMTY5MzIzLCJleHAiOjE3NzIxNjk2MjN9.03qI6Z0JxVz8pcseedvXoKmMcfR9Hv1JoahAKRmfufQ';

  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmNewPassController = TextEditingController();

  bool hideConfirmPass = true;
  bool hideNewPass = true;

  ForgotPasswordProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  void _init() {
    notifyListeners();
  }

  Future<void> requestOtp() async {
    if (emailController.text.trim().isEmpty) {
      CommonWidget.customSnackbar(
        context: context,
        description: "Please enter valid email address!",
        type: SnackbarType.error,
      );
      return;
    }
    isLoading = true;
    notifyListeners();
    String url = DioApiServices.requestOtp;
    Map<String, dynamic> data = {"email": emailController.text.trim()};

    try {
      var response = await DioApiRequest().postCommonApiCall(data, url);

      if (response.data['success'] == true) {
        CommonWidget.customSnackbar(
          context: context, // ignore: use_build_context_synchronously
          description: response.data['message'],
          type: SnackbarType.success,
        );
        currentState = ForgotPassState.verifyOtp;
      } else {
        CommonWidget.customSnackbar(
          context: context, // ignore: use_build_context_synchronously
          description: response.data['message'],
          type: SnackbarType.error,
        );
      }
    } catch (e) {
      debugPrint("object route => $e");
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> verifyOtp() async {
    if (emailController.text.trim().isEmpty) {
      CommonWidget.customSnackbar(
        context: context,
        description: "Please enter valid email address!",
        type: SnackbarType.error,
      );
      return;
    }

    isLoading = true;
    notifyListeners();
    String url = DioApiServices.verifyOtp;
    Map<String, dynamic> data = {"email": emailController.text.trim(), "otp": otpController.text.trim()};

    try {
      var response = await DioApiRequest().postCommonApiCall(data, url);

      if (response.data['success'] == true) {
        CommonWidget.customSnackbar(
          context: context, // ignore: use_build_context_synchronously
          description: response.data['message'],
          type: SnackbarType.success,
        );
        resrtPassToken = response.data['data']['reset_token'];
        currentState = ForgotPassState.setPassword;
      } else {
        CommonWidget.customSnackbar(
          context: context, // ignore: use_build_context_synchronously
          description: response.data['message'],
          type: SnackbarType.success,
        );
      }
    } catch (e) {
      debugPrint("object route => $e");
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> setNewPassword() async {
    if (newPassController.text.trim().isEmpty || confirmNewPassController.text.trim().isEmpty) {
      CommonWidget.customSnackbar(
        context: context,
        description: "Please enter valid password address!",
        type: SnackbarType.error,
      );
      return;
    }
    if (newPassController.text.trim() != confirmNewPassController.text.trim()) {
      CommonWidget.customSnackbar(
        context: context,
        description: "New password and confirm password is not same!",
        type: SnackbarType.error,
      );
      return;
    }

    isLoading = true;
    notifyListeners();
    String url = DioApiServices.resetPassword;
    Map<String, dynamic> data = {"new_password": newPassController.text.trim()};

    try {
      var response = await DioApiRequest().postCommonApiCall(data, url, resetToken: resrtPassToken);

      if (response.data['success'] == true) {
        CommonWidget.customSnackbar(
          context: context, // ignore: use_build_context_synchronously
          description: response.data['message'],
          type: SnackbarType.success,
        );
        // ignore: use_build_context_synchronously
        GoRouter.of(context).go(AppRouter.loginScreenRoute);
      } else {
        CommonWidget.customSnackbar(
          context: context, // ignore: use_build_context_synchronously
          description: response.data['message'],
          type: SnackbarType.success,
        );
      }
    } catch (e) {
      debugPrint("object route setNewPassword EXCEPTION=> $e");
    }
    isLoading = false;
    notifyListeners();
  }

  void updateState() {
    notifyListeners();
  }
}
