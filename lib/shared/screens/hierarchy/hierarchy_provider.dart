import 'package:flutter/material.dart';
import 'package:hrms_yb/core/network/dio_api_request.dart';
import 'package:hrms_yb/models/hierarchy_model.dart';

class HierarchyProvider extends ChangeNotifier {
  final BuildContext context;

  final List<HierarchyModel> hierarchy = [];
  bool isLoading = false;

  HierarchyProvider({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  Future<void> _init() async {
    await getHierarchy();
    notifyListeners();
  }

  Future<void> getHierarchy() async {
    isLoading = true;
    notifyListeners();

    String url = "getHierarchy";
    try {
      var response = await DioApiRequest().getCommonApiCall(url);

      if (response?.data['success'] == true && response?.data['data'] != null) {
        final List dataList = response!.data['data'];
        hierarchy.addAll(dataList.map((e) => HierarchyModel.fromJson(e)).toList());
      }
    } catch (e) {
      debugPrint("object route Exception Get hierchy => $e");
    }
    isLoading = false;
    notifyListeners();
  }
}
