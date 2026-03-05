import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/network/dio_api_request.dart';
import 'package:hrms_yb/core/network/dio_api_services.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/employee/employee_response_model.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';

class EmployeeDetailsProvider extends ChangeNotifier {
  final BuildContext context;
  bool isLoading = false;

  EmployeeDetailsModel? employeeDetailsModel;
  EmployeeModel? employeeModel;

  EmployeeDetailsProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Map<String, dynamic> data =
          GoRouter.of(context).state.extra as Map<String, dynamic>;
      employeeModel = data['employeeModel'];
      _init();
    });
  }

  void _init() {
    getEmployeeDetails(id: employeeModel?.userId ?? 0);
    notifyListeners();
  }

  Future<void> getEmployeeDetails({required int id}) async {
    isLoading = true;
    notifyListeners();
    String url = "${DioApiServices.getUserById}/$id";

    try {
      var response = await DioApiRequest().getCommonApiCall(url);
      if (response?.data['data'] != null && response?.data['success'] == true) {
        employeeDetailsModel = EmployeeDetailsModel.fromJson(
          response?.data['data'],
        );
      } else {
        CommonWidget.customSnackbar(
          context: context, // ignore: use_build_context_synchronously
          description:
              response?.data['message'] ?? "Something went wronge! Try again.",
          type: SnackbarType.error,
        );
      }
    } catch (e) {
      debugPrint("object route => get employee exception $e");
    }
    isLoading = false;
    notifyListeners();
  }
}

class DetailItem {
  final IconData icon;
  final Color color;
  final String label;
  final String value;

  DetailItem({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });
}
