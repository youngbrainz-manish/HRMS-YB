import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hrms_yb/core/network/dio_api_request.dart';
import 'package:hrms_yb/core/network/dio_api_services.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/employee/employee_response_model.dart';
import 'package:hrms_yb/shared/common_method.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';

class EmployeeListProvider extends ChangeNotifier {
  final BuildContext context;

  bool loadFullScreen = true;

  /// UI STATE
  bool showFilters = false;
  bool isLoading = false;
  bool isPaginationLoading = false;
  bool hasMore = true;

  /// PAGINATION
  int _page = 1;
  final int _limit = 10;

  /// SEARCH
  String searchText = "";
  Timer? _debounce;

  /// SCROLL
  final ScrollController scrollController = ScrollController();

  /// FILTER LISTS
  List<String> departmentList = const [
    "All Departments",
    "HR",
    "Sales",
    "Accounts",
    "Service",
    "Logistics",
  ];

  List<String> designationList = const [
    "All Designations",
    "Manager",
    "Executive",
    "Associate",
    "Intern",
  ];

  List<String> statusList = const ["All Status", "Active", "Inactive"];

  String department = "All Departments";
  String designation = "All Designations";
  String status = "All Status";

  List<EmployeeModel> employeesList = [];

  bool isLoadingFullScreen = false;

  EmployeeListProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  /// INIT
  void _init() {
    scrollController.addListener(_scrollListener);
    getEmployeeData(isInitial: true);
  }

  void updateState() {
    notifyListeners();
  }

  /// SEARCH (DEBOUNCE)
  void onSearchChanged(String value) {
    loadFullScreen = false;
    notifyListeners();
    searchText = value;

    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 200), () async {
      await getEmployeeData(isInitial: true);
      loadFullScreen = true;
      notifyListeners();
    });
  }

  /// FILTER APPLY
  Future<void> applyFilters() async {
    loadFullScreen = false;
    notifyListeners();
    await getEmployeeData(isInitial: true);
    loadFullScreen = true;
    notifyListeners();
  }

  /// SCROLL LISTENER
  void _scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      loadMore();
    }
  }

  /// LOAD MORE
  Future<void> loadMore() async {
    if (isPaginationLoading || !hasMore || isLoading) return;

    _page++;
    await getEmployeeData();
  }

  /// API CALL
  Future<void> getEmployeeData({bool isInitial = false}) async {
    if (isInitial) {
      _page = 1;
      hasMore = true;
      isLoading = true;
    } else {
      isPaginationLoading = true;
    }

    notifyListeners();

    String url = DioApiServices.getAllEmployee;

    Map<String, dynamic> queryParams = {
      "search": searchText,
      "limit": _limit,
      "page": _page,
      "department_name": department == "All Departments" ? "" : department,
      "designation_name": designation == "All Designations" ? "" : designation,
      "status": status == "All Status" ? "" : status,
    };

    try {
      var response = await DioApiRequest().getCommonApiCall(
        url,
        queryParams: queryParams,
      );

      if (response?.data?['success'] == true) {
        EmployeesResponseModel model = EmployeesResponseModel.fromJson(
          response?.data,
        );

        List<EmployeeModel> newList =
            model.employeesData?.employeeDetailsList ?? [];

        if (isInitial) {
          employeesList.clear();
        }

        employeesList.addAll(newList);

        /// CHECK IF MORE DATA EXISTS
        if (newList.length < _limit) {
          hasMore = false;
        }
      } else {
        CommonWidget.customSnackbar(
          context: context, // ignore: use_build_context_synchronously
          description: response?.data?['message'],
          type: SnackbarType.error,
        );
        // ignore: use_build_context_synchronously
        await CommonMethod().errageAllDataAndGotoLogin(context: context);
      }
    } catch (e) {
      debugPrint("GET EMPLOYEE ERROR => $e");
    }

    isLoading = false;
    isPaginationLoading = false;
    notifyListeners();
  }

  /// DELETE USER (UNCHANGED)
  Future<void> deleteUser({int? id}) async {
    if (id == null) {
      CommonWidget.customSnackbar(
        context: context,
        description: "Something went wrong! Try again.",
        type: SnackbarType.error,
      );
      return;
    }
    isLoadingFullScreen = true;
    notifyListeners();
    String url = "${DioApiServices.deleteEmployee}/$id";

    try {
      var response = await DioApiRequest().commonDeleteApi(
        context: context,
        url: url,
      );

      if (response?.data['success'] == true) {
        CommonWidget.customSnackbar(
          context: context, // ignore: use_build_context_synchronously
          description: response?.data['message'] ?? "User deleted successfully",
          type: SnackbarType.success,
        );
        employeesList.removeWhere((u) => u.userId == id);
      } else {
        CommonWidget.customSnackbar(
          context: context, // ignore: use_build_context_synchronously
          description:
              response?.data['message'] ?? "Something went wrong! Try again.",
          type: SnackbarType.error,
        );
      }
    } catch (e) {
      CommonWidget.customSnackbar(
        context: context, // ignore: use_build_context_synchronously
        description: "Something went wrong! Try again.",
        type: SnackbarType.error,
      );
      debugPrint("object rooute DELETE EMPLOYEE EXCEPTION => $e");
    }
    isLoadingFullScreen = false;
    notifyListeners();
  }

  @override
  void dispose() {
    scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}
