import 'package:flutter/material.dart';
import 'package:hrms_yb/core/network/authentication_data.dart';
import 'package:hrms_yb/core/network/dio_api_request.dart';
import 'package:hrms_yb/core/network/dio_api_services.dart';
import 'package:hrms_yb/models/user_model.dart';
import 'package:hrms_yb/shared/common_method.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';

class HrProfileProvider extends ChangeNotifier {
  final BuildContext context;
  bool isLoading = false;
  UserModel? employee;

  String? currentAddress;

  String? permanentAddress;

  HrProfileProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  Future<void> _init() async {
    await getProfileData();
    if ((employee?.addresses ?? []).isNotEmpty) {
      for (var address in employee!.addresses!) {
        if (address.addressType?.toLowerCase() == "Current".toLowerCase()) {
          currentAddress =
              "${address.street}, ${address.city}, ${address.state} - ${address.pincode}";
        }
        if (address.addressType?.toLowerCase() == "Permanent".toLowerCase()) {
          permanentAddress =
              "${address.street}, ${address.city}, ${address.state} - ${address.pincode}";
        }
      }
    }
    // currentAddress
    notifyListeners();
  }

  Future<void> getProfileData() async {
    isLoading = true;
    notifyListeners();
    String employeeId = AuthenticationData.userModel?.userId.toString() ?? '';
    String url = "${DioApiServices.getUserById}/$employeeId";
    try {
      var response = await DioApiRequest().getCommonApiCall(url);
      if (response != null && response.data?['success'] == true) {
        AuthenticationData.userModel = UserModel.fromJson(
          response.data['data'],
        );
        employee = AuthenticationData.userModel;
        notifyListeners();
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
      CommonWidget.customSnackbar(
        context: context, // ignore: use_build_context_synchronously
        description: "Something went wrong! Try again.",
        type: SnackbarType.error,
      );
      debugPrint("object route => GET PROFIOLE EXCEPTION");
    }

    isLoading = false;
    notifyListeners();
  }
}
