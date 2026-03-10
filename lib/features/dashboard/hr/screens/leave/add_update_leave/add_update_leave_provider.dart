import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/network/dio_api_request.dart';
import 'package:hrms_yb/core/network/dio_api_services.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/leave/models/leave_plan_data_model.dart';
import 'package:hrms_yb/shared/common_method.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:intl/intl.dart';

class AddUpdateLeaveProvider extends ChangeNotifier {
  final BuildContext context;

  bool isLoading = false;
  bool isSubmittingLeave = false;
  LeavePlanDataModel? leavePlanDataModel;
  List<LeaveType> leaveTypes = [];
  LeaveType? selectedLeaveType;

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  int totalDays = 0;

  TextEditingController descriptionTextController = TextEditingController();
  AddUpdateLeaveProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  Future<void> _init() async {
    isLoading = true;
    notifyListeners();
    await getMyLeavePlan();
    isLoading = false;
    notifyListeners();
  }

  getMyLeavePlan() async {
    String url = DioApiServices.getMyLeavePlan;

    try {
      var response = await DioApiRequest().getCommonApiCall(url);

      if (response?.data['success']) {
        leavePlanDataModel = LeavePlanDataModel.fromJson(
          response?.data['data'],
        );

        leaveTypes.addAll(leavePlanDataModel?.leaveTypes ?? []);
      } else {
        // ignore: use_build_context_synchronously
        CommonMethod().errageAllDataAndGotoLogin(context: context);
      }
    } catch (e) {
      debugPrint("object route => GET MY LEAVE PLAN EXCEPTION $e");
    }
  }

  /// Select Date
  Future<void> selectDate({
    required BuildContext context,
    required TextEditingController controller,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    Function(DateTime)? onDateSelected,
  }) async {
    DateTime now = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? now,
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2100),
    );

    if (picked != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(picked);

      if (onDateSelected != null) {
        onDateSelected(picked);
      }

      notifyListeners();
    }
  }

  void updateState() {
    notifyListeners();
  }

  Future<void> selectEndDate() async {
    if (startDateController.text.isNotEmpty) {
      await selectDate(
        context: context,
        controller: endDateController,
        initialDate: startDateController.text.isNotEmpty
            ? DateTime.parse(startDateController.text)
            : DateTime.now(),
        firstDate: startDateController.text.isNotEmpty
            ? DateTime.parse(startDateController.text)
            : DateTime.now(),
        lastDate: DateTime(2035),
      );
    } else {
      CommonWidget.customSnackbar(
        context: context,
        description: "Please select start date first",
        type: SnackbarType.error,
      );
    }
    totalDays = 0;
    totalDays =
        DateTime.parse(
          endDateController.text,
        ).difference(DateTime.parse(startDateController.text)).inDays +
        1;
    notifyListeners();
  }

  Future<void> submitLeave() async {
    isSubmittingLeave = true;
    notifyListeners();
    String url = DioApiServices.userLeavesApply;
    if (selectedLeaveType == null) {
      CommonWidget.customSnackbar(
        context: context,
        description: "Please select leave type.",
        type: SnackbarType.error,
      );
      return;
    }
    if (startDateController.text.trim().isEmpty) {
      CommonWidget.customSnackbar(
        context: context,
        description: "Please Select Start Date.",
        type: SnackbarType.error,
      );
      return;
    }
    if (endDateController.text.trim().isEmpty) {
      CommonWidget.customSnackbar(
        context: context,
        description: "Please Select End Date.",
        type: SnackbarType.error,
      );
      return;
    }
    try {
      Map<String, dynamic> data = {
        "leave_plan_type_id": selectedLeaveType?.leavePlanTypeId ?? 0,
        "from_date": startDateController.text.trim(),
        "to_date": endDateController.text.trim(),
        "reason": descriptionTextController.text.trim(),
      };
      var response = await DioApiRequest().postCommonApiCall(data, url);
      if (response?.data['success'] == true) {
        if (context.mounted) {
          CommonWidget.customSnackbar(
            context: context,
            description:
                response?.data['message'] ?? "Leave applied successfully",
            type: SnackbarType.success,
          );
          GoRouter.of(context).pop(true);
        }
      } else {
        if (context.mounted) {
          CommonWidget.customSnackbar(
            context: context,
            description:
                response?.data['message'] ??
                "Something went wronge! Try again.",
            type: SnackbarType.error,
          );
        }
      }
    } catch (e) {
      debugPrint("object route => APPLY LEAVE EXCEPTION => $e");
    }
    isSubmittingLeave = false;
    notifyListeners();
  }
}
