// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hrms_yb/core/network/dio_api_request.dart';
// import 'package:hrms_yb/core/network/dio_api_services.dart';
// import 'package:hrms_yb/features/dashboard/hr/screens/hr_leave_management/leave_plans/all_leave_plan/all_leave_plan_response_model.dart';

// class LeavePlanAddEditViewProvider extends ChangeNotifier {
//   final BuildContext context;

//   LeavePlan? leavePlan;
//   final formKey = GlobalKey<FormState>();
//   int? leavePlanId;
//   TextEditingController planNameController = TextEditingController();
//   TextEditingController startDateController = TextEditingController();
//   TextEditingController endDateController = TextEditingController();
//   bool isLoading = false;
//   int? type;

//   LeavePlanAddEditViewProvider({required this.context}) {
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       Map<String, dynamic>? data = GoRouterState.of(context).extra as Map<String, dynamic>;
//       leavePlanId = data['id'];
//       type = data['type'];
//       _init();
//     });
//   }

//   Future<void> _init() async {
//     getLeavePlan();
//     notifyListeners();
//   }

//   getLeavePlan() async {
//     isLoading = true;
//     notifyListeners();
//     String url = "${DioApiServices.getLeavePlanById}/$leavePlanId";
//     try {
//       var response = await DioApiRequest().getCommonApiCall(url);
//       if (response?.data['success'] == true) {
//         leavePlan = (response?.data['data'] != null) ? (LeavePlan.fromJson(response?.data['data'])) : null;
//       } else {}
//     } catch (e) {
//       debugPrint("object route => GET PLAN DETAILS EXCEPTION");
//     }
//     isLoading = false;
//     notifyListeners();
//   }

//   Future<void> selectDate(BuildContext context, TextEditingController controller) async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2020),
//       lastDate: DateTime(2100),
//     );

//     if (pickedDate != null) {
//       controller.text =
//           "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, "0")}-${pickedDate.day.toString().padLeft(2, "0")}";
//       notifyListeners();
//     }
//   }

//   Future<void> saveLeavePlan() async {
//     if (!formKey.currentState!.validate()) return;

//     try {
//       isLoading = true;
//       notifyListeners();

//       await Future.delayed(const Duration(seconds: 1));

//       isLoading = false;
//       notifyListeners();
//     } catch (e) {
//       isLoading = false;
//       notifyListeners();
//     }
//   }

//   @override
//   void dispose() {
//     planNameController.dispose();
//     startDateController.dispose();
//     endDateController.dispose();
//     super.dispose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/network/dio_api_request.dart';
import 'package:hrms_yb/core/network/dio_api_services.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/hr_leave_management/leave_plans/all_leave_plan/all_leave_plan_response_model.dart';
import 'package:hrms_yb/shared/models/user_category_model.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';

class LeavePlanAddEditViewProvider extends ChangeNotifier {
  final BuildContext context;

  LeavePlan? leavePlan;

  final formKey = GlobalKey<FormState>();

  int? leavePlanId;
  int? type;

  bool isLoading = false;
  List<UserCategoryModel> userCategoryList = [];
  UserCategoryModel? selectedUserCategory;

  /// Controllers
  TextEditingController planNameController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  /// Leave Types List
  List<LeaveTypeFormModel> leaveTypes = [];

  LeavePlanAddEditViewProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Map<String, dynamic>? data = GoRouterState.of(context).extra as Map<String, dynamic>;

      leavePlanId = data['id'];
      type = data['type'];

      _init();
    });
  }

  Future<void> _init() async {
    isLoading = true;
    notifyListeners();
    await getUserCategory();
    isLoading = false;
    notifyListeners();
    if (leavePlanId != null) {
      await getLeavePlan();
    } else {
      addLeaveType();
    }

    notifyListeners();
  }

  Future<void> getUserCategory() async {
    String url = DioApiServices.getUserCategory;
    try {
      var response = await DioApiRequest().getCommonApiCall(url);
      userCategoryList = response?.data['data'] != null
          ? List<UserCategoryModel>.from(response?.data['data'].map((x) => UserCategoryModel.fromJson(x)))
          : [];
    } catch (e) {
      debugPrint("object route => Eception Get UserCategoryModel => $e");
    }
  }

  /// GET PLAN DETAILS
  Future<void> getLeavePlan() async {
    isLoading = true;
    notifyListeners();

    String url = "${DioApiServices.getLeavePlanById}/$leavePlanId";

    try {
      var response = await DioApiRequest().getCommonApiCall(url);

      if (response?.data['success'] == true) {
        leavePlan = LeavePlan.fromJson(response?.data['data']);

        /// Prefill values
        planNameController.text = leavePlan?.planName ?? "";
        startDateController.text = leavePlan?.startDate ?? "";
        endDateController.text = leavePlan?.endDate ?? "";

        if (leavePlan?.userCategory != null) {
          selectedUserCategory = userCategoryList.firstWhere(
            (e) => e.userCategoryId == leavePlan?.userCategory?.userCategoryId,
            orElse: () => userCategoryList.first,
          );
        }

        /// Leave Types
        leaveTypes.clear();

        leavePlan?.leaveTypes?.forEach((e) {
          leaveTypes.add(
            LeaveTypeFormModel(
              leaveType: e.leaveType,
              // creditType: e.creditType,
              leaveCount: e.leaveCount?.toString(),
              carryForward: e.carryForward ?? false,
              maxCarryForward: e.maxCarryForward?.toString(),
              isPaid: e.isPaid ?? true,
            ),
          );
        });
      }
    } catch (e) {
      debugPrint("GET PLAN DETAILS EXCEPTION => $e");
    }

    isLoading = false;
    notifyListeners();
  }

  /// ADD LEAVE TYPE
  void addLeaveType() {
    leaveTypes.add(LeaveTypeFormModel());
    notifyListeners();
  }

  /// REMOVE LEAVE TYPE
  void removeLeaveType(int index) {
    leaveTypes.removeAt(index);
    notifyListeners();
  }

  /// DATE PICKER
  Future<void> selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      controller.text =
          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, "0")}-${pickedDate.day.toString().padLeft(2, "0")}";
      notifyListeners();
    }
  }

  /// SAVE PLAN
  Future<void> saveLeavePlan() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading = true;
      notifyListeners();

      Map<String, dynamic> body = {
        "plan_name": planNameController.text,
        "start_date": startDateController.text,
        "end_date": endDateController.text,
        "user_category_id": selectedUserCategory?.userCategoryId ?? '',
        "leave_types": leaveTypes.map((e) => e.toJson()).toList(),
      };
      // ignore: prefer_typing_uninitialized_variables
      var response;

      if (leavePlanId == null) {
        response = await DioApiRequest().postCommonApiCall(body, DioApiServices.createLeavePlan);
      } else {
        response = await DioApiRequest().putCommonApiCall(body, "${DioApiServices.updateLeavePlan}/$leavePlanId");
      }

      if (response?.data['success'] == true) {
        if (context.mounted) {
          CommonWidget.customSnackbar(
            context: context,
            description: response?.data['message'] ?? "Plan created successfully",
            type: SnackbarType.success,
          );
          GoRouter.of(context).pop(true);
        }
      } else {
        if (context.mounted) {
          CommonWidget.customSnackbar(
            context: context,
            description: response?.data['message'] ?? "Something went wrong! try again.",
            type: SnackbarType.error,
          );
        }
      }
    } catch (e) {
      debugPrint("SAVE PLAN ERROR => $e");
    }
    if (context.mounted) {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    planNameController.dispose();
    startDateController.dispose();
    endDateController.dispose();

    for (var e in leaveTypes) {
      e.dispose();
    }

    super.dispose();
  }

  void updateState() {
    notifyListeners();
  }
}

/// LEAVE TYPE FORM MODEL
class LeaveTypeFormModel {
  TextEditingController leaveTypeController = TextEditingController();
  TextEditingController leaveCountController = TextEditingController();
  TextEditingController maxCarryForwardController = TextEditingController();

  // String creditType = "monthly";

  bool carryForward = false;
  bool isPaid = true;

  LeaveTypeFormModel({
    String? leaveType,
    // String? creditType,
    String? leaveCount,
    bool carryForward = false,
    String? maxCarryForward,
    bool isPaid = true,
  }) {
    leaveTypeController.text = leaveType ?? "";
    leaveCountController.text = leaveCount ?? "";
    maxCarryForwardController.text = maxCarryForward ?? "";
    // creditType = creditType ?? "monthly";
    carryForward = carryForward;
    isPaid = isPaid;
  }

  Map<String, dynamic> toJson() {
    return {
      "leave_type": leaveTypeController.text,
      "leave_count": double.tryParse(leaveCountController.text) ?? 0,
      "carry_forward": carryForward,
      "max_carry_forward": carryForward ? int.tryParse(maxCarryForwardController.text) : null,
      "is_paid": isPaid,
    };
  }

  void dispose() {
    leaveTypeController.dispose();
    leaveCountController.dispose();
    maxCarryForwardController.dispose();
  }
}
