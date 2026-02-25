// import 'package:flutter/material.dart';

// class EmpHolidayProvider extends ChangeNotifier {
//   final BuildContext context;

//   EmpHolidayProvider({required this.context}) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _init();
//     });
//   }

//   void _init() {
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';
import 'package:hrms_yb/core/network/dio_api_request.dart';
import 'package:hrms_yb/core/network/dio_api_services.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/holiday/holiday_model.dart';

class EmpHolidayProvider extends ChangeNotifier {
  final BuildContext context;

  EmpHolidayProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });

    scrollController.addListener(_paginationListener);
  }

  /// ================= VARIABLES =================

  bool isLoading = false;
  bool isDeleting = false;
  bool isPaginationLoading = false;
  bool hasMoreData = true;

  final List<HolidayModel> holidays = [];

  int page = 1;
  final int limit = 8;

  final ScrollController scrollController = ScrollController();

  /// ================= INIT =================

  Future<void> _init() async {
    await getHolidays();
  }

  /// ================= PAGINATION LISTENER =================

  void _paginationListener() {
    if (!scrollController.hasClients || isPaginationLoading || !hasMoreData) return;

    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;

    /// load next page before reaching end
    if (currentScroll >= maxScroll - 200) {
      getHolidays(isLoadMore: true);
    }
  }

  /// ================= GET HOLIDAYS =================

  Future<void> getHolidays({bool isLoadMore = false}) async {
    if (isLoadMore) {
      if (isPaginationLoading || !hasMoreData) return;
      isPaginationLoading = true;
    } else {
      isLoading = true;
      page = 1;
      hasMoreData = true;
      holidays.clear();
    }
    if (!context.mounted) return;
    notifyListeners();

    try {
      String url = "${DioApiServices.getHolidays}?page=$page&limit=$limit";

      var response = await DioApiRequest().getCommonApiCall(url);

      if (response?.data['success'] == true) {
        List data = response!.data['data']['holidays'];

        final newList = data.map((e) => HolidayModel.fromJson(e)).toList();

        holidays.addAll(newList);

        /// check if more pages exist
        if (newList.length < limit) {
          hasMoreData = false;
        } else {
          page++;
        }
      }
    } catch (e) {
      debugPrint("Error fetching holidays: $e");
    }

    isLoading = false;
    isPaginationLoading = false;
    if (!context.mounted) return;
    notifyListeners();
  }

  /// ================= DISPOSE =================

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
