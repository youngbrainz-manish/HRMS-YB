import 'package:hrms_yb/core/network/authentication_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonMethod {
  Future<void> errageAllDataAndGotoLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    AuthenticationData.token = "";
    AuthenticationData.userModel = null;
  }
}
