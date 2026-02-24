import 'package:flutter/material.dart';
import 'package:hrms_yb/core/network/dio_api_request.dart';
import 'package:hrms_yb/core/network/dio_api_services.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/holiday/holiday_model.dart';

class HrHolidayProvider extends ChangeNotifier {
  final BuildContext context;

  HrHolidayProvider({required this.context}) {
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
    notifyListeners();
  }

  /// ================= DELETE HOLIDAY =================

  Future<void> deleteHoliday({required int id}) async {
    isDeleting = true;
    notifyListeners();

    try {
      var response = await DioApiRequest().commonDeleteApi(
        url: "${DioApiServices.deleteHoliday}/$id",
        context: context,
      );

      if (response?.data['success'] == true) {
        holidays.removeWhere((e) => e.holidayId == id);

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response?.data['message'] ?? "Deleted"), backgroundColor: AppColors.successPrimary),
        );
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response?.data['message'] ?? "Failed"), backgroundColor: AppColors.errorColor),
        );
      }
    } catch (e) {
      debugPrint("Error deleting holiday: $e");
    }

    isDeleting = false;
    notifyListeners();
  }

  /// ================= DISPOSE =================

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
