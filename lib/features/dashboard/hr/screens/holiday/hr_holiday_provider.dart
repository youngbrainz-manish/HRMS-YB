import 'package:flutter/material.dart';
import 'package:hrms_yb/core/network/dio_api_request.dart';
import 'package:hrms_yb/core/network/dio_api_services.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/holiday/holiday_model.dart';

class HrHolidayProvider extends ChangeNotifier {
  final BuildContext context;
  bool isLoading = false;
  bool isDeleting = false;
  final List<HolidayModel> holidays = [];

  HrHolidayProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  Future<void> _init() async {
    await getHolidays();
    notifyListeners();
  }

  Future<void> getHolidays() async {
    isLoading = true;
    notifyListeners();
    String url = DioApiServices.getHolidays;

    try {
      var response = await DioApiRequest().getCommonApiCall(url);
      if (response?.data['success'] == true && response!.data != null) {
        var data = response.data['data']['holidays'] as List;
        holidays.clear();
        holidays.addAll(data.map((e) => HolidayModel.fromJson(e)).toList());
      }
    } catch (e) {
      debugPrint("Error fetching holidays: $e");
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteHoliday({required int id}) async {
    isDeleting = true;
    notifyListeners();
    try {
      var response = await DioApiRequest().commonDeleteApi(
        url: "${DioApiServices.deleteHoliday}/$id",
        context: context,
      );
      if (response?.data['success'] == true) {
        int index = holidays.indexWhere((holiday) => holiday.holidayId == id);
        if (index >= 0 && index < holidays.length) {
          holidays.removeAt(index);
          notifyListeners();
        }
        ScaffoldMessenger.of(
          context, // ignore: use_build_context_synchronously
        ).showSnackBar(
          SnackBar(
            content: Text(response?.data['message'] ?? "Failed to delete holiday"),
            backgroundColor: AppColors.successPrimary,
          ),
        );
      } else {
        ScaffoldMessenger.of(
          context, // ignore: use_build_context_synchronously
        ).showSnackBar(
          SnackBar(
            content: Text(response?.data['message'] ?? "Failed to delete holiday"),
            backgroundColor: AppColors.errorColor,
          ),
        );
      }
    } catch (e) {
      debugPrint("Error deleting holiday: $e");
    }
    isDeleting = false;
    notifyListeners();
  }
}
