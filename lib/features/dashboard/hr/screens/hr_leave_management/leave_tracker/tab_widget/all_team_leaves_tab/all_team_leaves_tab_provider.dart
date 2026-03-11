import 'package:flutter/material.dart';
import 'package:hrms_yb/core/network/dio_api_request.dart';
import 'package:hrms_yb/core/network/dio_api_services.dart';
import 'package:hrms_yb/shared/models/leave_module/all_user_response_model.dart';

class AllTeamLeavesTabProvider extends ChangeNotifier {
  final BuildContext context;

  AllTeamLeavesTabProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  final ScrollController scrollController = ScrollController();

  List<LeaveModel> leaveList = [];

  bool isLoading = false;
  bool isPaginationLoading = false;

  int currentPage = 1;
  int totalPages = 1;

  void _init() {
    scrollController.addListener(_scrollListener);
    getAllUsersLeave();
  }

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent &&
        !isPaginationLoading &&
        currentPage < totalPages) {
      currentPage++;
      getAllUsersLeave(isPagination: true);
    }
  }

  Future<void> getAllUsersLeave({bool isPagination = false}) async {
    String url = "${DioApiServices.getAllUsersLeaves}?page=$currentPage";

    try {
      if (isPagination) {
        isPaginationLoading = true;
      } else {
        isLoading = true;
      }

      notifyListeners();

      var response = await DioApiRequest().getCommonApiCall(url);
      if (response?.data['success'] == true) {
        AllUserResponseModel model = AllUserResponseModel.fromJson(response!.data);

        if (model.leaveDataModel != null) {
          totalPages = model.leaveDataModel!.totalPages ?? 1;

          if (isPagination) {
            leaveList.addAll(model.leaveDataModel!.leaveModelList ?? []);
          } else {
            leaveList = model.leaveDataModel!.leaveModelList ?? [];
          }
        }
      }
    } catch (e) {
      debugPrint("EXCEPTION GETTING ALL USER LEAVES $e");
    }

    isLoading = false;
    isPaginationLoading = false;

    notifyListeners();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
