// ignore_for_file: depend_on_referenced_packages, unnecessary_type_check
import 'package:dio/dio.dart';
import 'package:hrms_yb/core/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dio_api_services.dart';

class DioApiManager {
  static final DioApiManager _singleton = DioApiManager._internal();

  Dio? dio;
  static String token = '';

  factory DioApiManager() {
    return _singleton;
  }

  DioApiManager._internal();

  Future<void> configureDio() async {
    BaseOptions options = BaseOptions(
      baseUrl: DioApiServices.baseUrl,
      connectTimeout: const Duration(milliseconds: 50000),
      receiveTimeout: const Duration(milliseconds: 40000),
    );

    dio = Dio(options);

    dio?.interceptors.addAll({LogInterceptor(request: true, responseBody: true, error: true, requestBody: true)});

    dio?.httpClientAdapter = HttpClientAdapter();
  }

  Future<Dio> getDio() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString(AppConstants.token) ?? '';
    if (dio == null) {
      await configureDio();
    }
    return dio!;
  }

  static setToken(String newToken) {
    token = newToken;
  }

  String getToken() {
    return token;
  }
}
