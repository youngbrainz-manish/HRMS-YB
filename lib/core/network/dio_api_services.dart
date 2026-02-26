import 'env_file.dart';

class DioApiServices {
  static String baseUrl = Environment().getStrings('base_url');

  static const String login = 'auth/login';
  static const String getUserById = 'employees';
  static const String getHolidays = 'Holiday/GetHolidays';
  static const String deleteHoliday = 'holiday/deleteHoliday';
  static String addHoliday = "Holiday/createHoliday";
  static String updateProfile = "employeesPersonalDets";
}
