import 'package:flutter/material.dart';
import 'package:hrms_yb/core/network/dio_api_request.dart';
import 'package:hrms_yb/core/network/dio_api_services.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/hr_leave_management/leave_tracker/tab_widget/my_leave_requests_tab/my_leave_model.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';

class MyLeaveRequestsTabProvider extends ChangeNotifier {
  final BuildContext context;
  final ScrollController scrollController = ScrollController();

  bool isLoading = false;
  bool isLoadMore = false;

  int currentPage = 1;
  int totalPages = 1;
  int limit = 10;

  List<LeaveModel> leaveList = [];

  MyLeaveRequestsTabProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.addListener(() {
        if (scrollController.position.pixels == (scrollController.position.maxScrollExtent - 200)) {
          getMyLeaveRequest(isPagination: true);
        }
      });
      _init();
    });
  }

  void _init() {
    getMyLeaveRequest();
  }

  Future<void> getMyLeaveRequest({bool isPagination = false}) async {
    if (isPagination) {
      if (currentPage > totalPages) return;
      isLoadMore = true;
    } else {
      isLoading = true;
      currentPage = 1;
      leaveList.clear();
    }
    if (context.mounted) {
      notifyListeners();
    }

    String url = "${DioApiServices.getMyLeaveRequesta}?page=$currentPage&limit=$limit";

    try {
      var response = await DioApiRequest().getCommonApiCall(url);

      if (response?.data != null) {
        final data = response!.data["data"];

        totalPages = data["totalPages"] ?? 1;

        List list = data["leaves"] ?? [];

        List<LeaveModel> fetchedLeaves = list.map((e) => LeaveModel.fromJson(e)).toList();

        leaveList.addAll(fetchedLeaves);

        currentPage++;
      }
    } catch (e) {
      debugPrint("GET MY LEAVE EXCEPTION => $e");
    }

    if (context.mounted) {
      isLoading = false;
      isLoadMore = false;
      notifyListeners();
    }
  }

  Future<void> refreshLeaves() async {
    currentPage = 1;
    leaveList.clear();
    await getMyLeaveRequest();
  }

  Future<bool?> cancelMyLeave({required LeaveModel leaveModel}) async {
    String url = "${DioApiServices.cancelLeave}/${leaveModel.userAppliedLeavesId}";

    try {
      var response = await DioApiRequest().putCommonApiCall({}, url);
      if (response?.data['success'] == true) {
        if (context.mounted) {
          CommonWidget.customSnackbar(
            context: context,
            description: response?.data['message'],
            type: SnackbarType.success,
          );
        }
        return true;
      } else {
        if (context.mounted) {
          CommonWidget.customSnackbar(
            context: context,
            description: response?.data['message'],
            type: SnackbarType.error,
          );
        }
        return false;
      }
    } catch (e) {
      debugPrint("object route => Cancel my leave EXCEPTION");
      return false;
    }
  }
}
