import 'package:flutter/material.dart';
import 'package:hrms_yb/core/network/dio_api_request.dart';
import 'package:hrms_yb/core/network/dio_api_services.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/leave/models/leave_summary_model.dart';
import 'package:intl/intl.dart';

class MyLeaveSummaryTabProvider extends ChangeNotifier {
  final BuildContext context;
  LeaveSummaryModel? leaveSummaryModel;
  bool isLoading = false;

  MyLeaveSummaryTabProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  void _init() {
    getLeaveSummary();
    notifyListeners();
  }

  Future<void> getLeaveSummary() async {
    isLoading = true;
    notifyListeners();
    String url = DioApiServices.leaveSummary;

    try {
      var response = await DioApiRequest().getCommonApiCall(url);
      leaveSummaryModel = LeaveSummaryModel.fromJson(response?.data);
    } catch (e) {
      debugPrint("Object route => Eception getting summary");
    }
    isLoading = false;
    notifyListeners();
  }

  String formatDate(String date) {
    final parsedDate = DateTime.parse(date).toLocal();
    return DateFormat('dd MMM yyyy, hh:mm a').format(parsedDate);
  }
}
