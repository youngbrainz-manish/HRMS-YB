import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/network/dio_api_request.dart';
import 'package:hrms_yb/core/network/dio_api_services.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/holiday/holiday_model.dart';

class AddHolidayProvider extends ChangeNotifier {
  final BuildContext context;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  HolidayModel? holidayModel;

  String holidayType = "COMPANY";
  bool isLoading = false;

  List<String> holidayTypeOptions = ["COMPANY", "NATIONAL", "FESTIVAL"];

  AddHolidayProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Map<String, dynamic>? data = GoRouterState.of(context).extra as Map<String, dynamic>?;
      holidayModel = data?['holiday'];
      _init();
    });
  }

  void _init() {
    getInitData();
    notifyListeners();
  }

  getInitData() {
    titleController.text = holidayModel?.title ?? '';
    dateController.text = holidayModel?.holidayDate ?? "";
    if ((holidayModel?.holidayType ?? "").isNotEmpty) {
      holidayType = holidayModel?.holidayType ?? "";
    }
  }

  /// Select Date
  Future<void> selectDate({String? initDate}) async {
    final date = await showDatePicker(
      context: context,
      initialDate: (initDate ?? "").isNotEmpty ? DateTime.parse(initDate!) : DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
    );

    if (date != null) {
      dateController.text =
          "${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}";
    }
  }

  Future<void> submitHoliday() async {
    if (dateController.text.isEmpty || titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }
    isLoading = true;
    notifyListeners();
    String holidateDAte = dateController.text.replaceAll("-", "/");
    Map<String, dynamic> requestData = {
      "holiday_date": holidateDAte,
      "holiday_type": holidayType,
      "title": titleController.text,
    };

    if (holidayModel?.holidayId != null) {
      await updateHoliday(requestData: requestData);
    } else {
      await addHoliday(requestData: requestData);
    }

    if (!context.mounted) return;
    isLoading = false;
    notifyListeners();
  }

  /// Add Holiday Form
  Future<void> addHoliday({required Map<String, dynamic> requestData}) async {
    try {
      var response = await DioApiRequest().postCommonApiCall(requestData, DioApiServices.addHoliday);

      if (response?.data != null && response?.data['success'] == true) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context, // ignore: use_build_context_synchronously
          ).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.successPrimary,
              content: Text(response?.data['message'] ?? "Holiday Added Successfully"),
            ),
          );
          HolidayModel holidayModel = HolidayModel.fromJson(response?.data['data']);
          GoRouter.of(context).pop(holidayModel);
        } else {
          ScaffoldMessenger.of(
            context, // ignore: use_build_context_synchronously
          ).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.errorColor,
              content: Text(response?.data['message'] ?? "Failed to add holiday"),
            ),
          );
        }
      }
    } catch (e) {
      debugPrint("object route => Exception Holiday Add");
    }
  }

  /// Update Holiday Form
  Future<void> updateHoliday({required Map<String, dynamic> requestData}) async {
    String url = "${DioApiServices.updateHoliday}/${holidayModel?.holidayId}";
    try {
      // FormData formData = FormData.fromMap(requestData);
      var response = await DioApiRequest().putCommonApiCall(requestData, url);

      if (response?.data != null && response?.data['success'] == true) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context, // ignore: use_build_context_synchronously
          ).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.successPrimary,
              content: Text(response?.data['message'] ?? "Holiday Update Successfully"),
            ),
          );
          HolidayModel holidayModel = HolidayModel.fromJson(response?.data['data']);
          GoRouter.of(context).pop(holidayModel);
        } else {
          ScaffoldMessenger.of(
            context, // ignore: use_build_context_synchronously
          ).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.errorColor,
              content: Text(response?.data['message'] ?? "Failed to update holiday"),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(
          context, // ignore: use_build_context_synchronously
        ).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.errorColor,
            content: Text(response?.data['message'] ?? "Failed to update holiday"),
          ),
        );
      }
    } catch (e) {
      debugPrint("object route => Exception Holiday Update");
    }
  }

  void updateState() {
    notifyListeners();
  }
}
