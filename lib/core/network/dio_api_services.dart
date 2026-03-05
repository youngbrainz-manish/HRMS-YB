import 'env_file.dart';

class DioApiServices {
  static String baseUrl = Environment().getStrings('base_url');

  static const String login = 'auth/login';
  static const String requestOtp = 'auth/forgot-password/requestOtp';
  static const String verifyOtp = 'auth/forgot-password/verifyOtp';
  static const String resetPassword = 'auth/forgot-password/resetPassword';

  ///Common HR + EMPLOYEE
  static const String getUserById = 'employees';
  static const String getHolidays = 'Holiday/GetHolidays';
  static String updateProfile = "employeesPersonalDets";

  ///HR
  static String addHoliday = "Holiday/createHoliday";
  static const String deleteHoliday = 'holiday/deleteHoliday';
  static String updateHoliday = "Holiday/updateHoliday";
  static String getAllEmployee = "employees";

  static String deleteEmployee = "employees";
  static String getRoles = "getrole";
  static String createEmployee = "createEmployee";

  ///EMPLOYEE
}
