// ignore: unused_import
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
// ignore: library_prefixes
import 'package:dio/dio.dart' as dioImported;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/constants/api_constants.dart';
import 'package:hrms_yb/core/constants/app_constants.dart';
import 'package:hrms_yb/core/network/authentication_data.dart';
import 'package:hrms_yb/core/network/common_response.dart';
import 'package:hrms_yb/core/network/dio_api_manager.dart';
import 'package:hrms_yb/core/router/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioApiRequest {
  DioApiRequest();

  postCommonApiCall(var data, String url, {bool? showToast}) async {
    Dio dio = await DioApiManager().getDio();
    try {
      Options options = Options();
      String token = DioApiManager().getToken();
      if (token.isEmpty) {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        token = sharedPreferences.getString(ApiConstants.token) ?? '';
      }

      options.headers = {"Authorization": token.isNotEmpty ? 'Bearer $token' : ''};
      if (kDebugMode) {
        ///Uncommnet to get CURL in log
        // String cURL = generateCurlFromFormData(url, data, options);
        // log("route cURL : $cURL");
      }

      var response = await dio.post(url, data: data, options: options);

      if (response.data is Map<String, dynamic>) {
        CommonResponse commonResponse = CommonResponse.fromJson(response.data);
        if (commonResponse.status == 200) {
          return response;
        } else if (commonResponse.status == 401) {
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.clear();
          AuthenticationData.token = "";

          if (showToast == true) {
            // CommonWidget().showSnackBar(
            //   message: commonResponse.message ?? Constants.apiErrorMessage,
            //   bgColor: requiredRedColor,
            // );
            // AppGlobal.showSnackBar(body: commonResponse.message ?? Constants.apiErrorMessage);
          }
          GoRoute(path: AppRouter.loginScreenRoute);
          return null;
        } else {
          if (showToast == true) {
            // CommonWidget().showSnackBar(
            //   message: commonResponse.message ?? Constants.apiErrorMessage,
            //   bgColor: requiredRedColor,
            // );
          }
          return response;
        }
      } else if (response.data is DioException) {
        if (showToast == true) {
          // CommonWidget().showSnackBar(
          //   message: response.statusMessage ?? Constants.apiErrorMessage,
          //   bgColor: requiredRedColor,
          // );
        }
        return null;
      } else {
        if (showToast == true) {
          // CommonWidget().showSnackBar(
          //   message: response.statusMessage ?? Constants.apiErrorMessage,
          //   bgColor: requiredRedColor,
          // );
        }
        return null;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        // CommonWidget().showSnackBar(
        //   message: e.response.toString() ?? Constants.apiErrorMessage,
        //   bgColor: requiredRedColor,
        // );
        return e.response;
      } else {}
    } catch (ex) {
      if (showToast == true) {
        // CommonWidget().showSnackBar(message: ex.toString(), bgColor: requiredRedColor);
      }
      return null;
    }
  }

  Future<dioImported.Response?> getCommonApiCall(
    String url, {
    bool? showToast,
    Map<String, dynamic>? queryParams,
  }) async {
    var dio = await DioApiManager().getDio();

    try {
      Options options = Options();
      String token = DioApiManager().getToken();
      if (token.isEmpty) {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        token = sharedPreferences.getString(ApiConstants.token) ?? '';
      }
      options.headers = {"Authorization": token.isNotEmpty ? 'Bearer $token' : ''};
      options.validateStatus = (status) => status != null && status < 500;
      var response = await dio.get(url, options: options, queryParameters: queryParams);

      if (response.data is Map<String, dynamic>) {
        CommonResponse commonResponse = CommonResponse.fromJson(response.data);
        if (commonResponse.status == 200) {
          return response;
        } else if (commonResponse.status == 401) {
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

          sharedPreferences.clear();
          AuthenticationData.token = "";

          if (showToast == true) {
            // CommonWidget().showSnackBar(
            //   message: commonResponse.message ?? Constants.apiErrorMessage,
            //   bgColor: requiredRedColor,
            // );
            GoRoute(path: AppRouter.loginScreenRoute);
            // AppGlobal.showSnackBar(body: commonResponse.message ?? Constants.apiErrorMessage);
          }

          return response;
        } else {
          if (showToast == true) {
            // AppGlobal.showSnackBar(body: commonResponse.message ?? Constants.apiErrorMessage);
          }
          return response;
        }
      } else if (response.data is DioException) {
        if (showToast == true) {
          // AppGlobal.showSnackBar(body: response.statusMessage ?? Constants.apiErrorMessage);
        }
        return null;
      } else {
        if (showToast == true) {
          // AppGlobal.showSnackBar(body: Constants.apiErrorMessage);
        }

        return response;
      }
    }
    // on DioException catch (e) {
    //   print("object route => DioException=> $e");
    //   if (e.response != null) {
    //     return e.response;
    //   } else {}
    // }
    catch (ex) {
      if (showToast == true) {}

      return null;
    }
  }

  String generateCurlFromFormData(String url, FormData formData, Options? options) {
    final buffer = StringBuffer();
    buffer.write('curl -X POST');

    // Add headers
    final headers = options?.headers ?? {};
    headers.forEach((key, value) {
      buffer.write(' -H "$key: $value"');
    });

    // Add form fields
    for (final MapEntry<String, String> field in formData.fields) {
      buffer.write(' -F "${field.key}=${field.value}"');
    }

    // Add files
    for (final file in formData.files) {
      final field = file.key;
      final MultipartFile multipartFile = file.value;
      final filePath = multipartFile.filename ?? 'your_file_path';

      final filename = multipartFile.filename ?? filePath.split(Platform.pathSeparator).last;
      buffer.write(' -F "$field=@$filePath;filename=$filename"');
    }

    // Add URL
    buffer.write(' "$url"');

    return buffer.toString();
  }

  Future<dioImported.Response?> commonDeleteApi({
    required BuildContext context,
    required String url,
    bool? showToast,
  }) async {
    Dio dio = await DioApiManager().getDio();
    try {
      Options options = Options();
      String token = DioApiManager().getToken();
      if (token.isEmpty) {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        token = sharedPreferences.getString(AppConstants.token) ?? '';
      }
      options.headers = {"Authorization": token.isNotEmpty ? 'Bearer $token' : ''};
      options.validateStatus = (status) => status != null && status <= 500;

      final response = await dio.delete(url, options: options);

      if (response.data is Map<String, dynamic>) {
        CommonResponse commonResponse = CommonResponse.fromJson(response.data);
        if (commonResponse.success == true) {
          return response;
        } else if (commonResponse.success == false) {
          if (showToast == true && context.mounted) {}
          return response;
        } else {
          if (showToast == true) {}
          return response;
        }
      } else if (response.data is DioException) {
        if (showToast == true) {}
        return null;
      } else {
        if (showToast == true) {}
        return response;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (kDebugMode) {
          print('Error: ${e.response?.statusCode} -> ${e.response?.data}');
        }
      } else {
        if (kDebugMode) {
          print('Request failed: ${e.message}');
        }
      }
    }
    return null;
  }

  Future<dynamic> putCommonApiCall(var data, String url, {bool? showToast}) async {
    Dio dio = await DioApiManager().getDio();
    try {
      Options options = Options();
      String token = DioApiManager().getToken();

      if (token.isEmpty) {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        token = sharedPreferences.getString(ApiConstants.token) ?? '';
      }
      options.headers = {"Authorization": token.isNotEmpty ? 'Bearer $token' : ''};

      if (data is FormData) {
        options.contentType = 'multipart/form-data';
      }

      /// DEBUG CURL LOG
      if (kDebugMode) {
        String cURL = generateCurlFromFormData(url, data, options);
        log("route PUT cURL : $cURL");
      }

      /// PUT REQUEST
      var response = await dio.put(url, data: data, options: options);

      /// RESPONSE HANDLING (same as POST)
      if (response.data is Map<String, dynamic>) {
        CommonResponse commonResponse = CommonResponse.fromJson(response.data);

        if (commonResponse.status == 200) {
          return response;
        } else if (commonResponse.status == 401) {
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.clear();

          AuthenticationData.token = "";

          GoRoute(path: AppRouter.loginScreenRoute);

          return null;
        } else {
          return response;
        }
      } else {
        return null;
      }
    } on DioException catch (e) {
      print("object route PUT ERROR => $e");

      if (e.response != null) {
        return e.response;
      }
      return null;
    } catch (ex) {
      print("object route PUT EXCEPTION => $ex");
      return null;
    }
  }
}
