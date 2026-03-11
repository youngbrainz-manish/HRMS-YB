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
  static String leaveSummary = "user_leaves/leaveSummary";
  static String getMyLeavePlan = "leave/getMyLeavePlan";
  static String userLeavesApply = "user_leaves/apply";
  static String getMyLeaveRequesta = "user_leaves/getMyLeaves";
  static String cancelLeave = "user_leaves/cancel";
  static String approveOrRejectLeave = "user_leaves/action";
  static String revokeLeave = "user_leaves/revokeLeave";

  ///HR
  static String addHoliday = "Holiday/createHoliday";
  static const String deleteHoliday = 'holiday/deleteHoliday';
  static String updateHoliday = "Holiday/updateHoliday";
  static String getAllEmployee = "employees";
  static String getRoleForReporting = "fetchRoleForReporting";
  static String getUserCategory = "getUserCategory";

  static String deleteEmployee = "employees";
  static String getRoles = "getrole";
  static String createEmployee = "createEmployee";
  static String updateEmployee = "employees";
  static String getMyTeamLeaveRequest = "user_leaves/requestedLeaves";
  static String getAllUsersLeaves = "user_leaves/getUserLeaves";
  static const String getAllLeavePlans = "/leave/getAllLeavePlans";
  static String getLeavePlanById = "leave/leavePlan";
  static String createLeavePlan = "leave/leavePlan";
  static String updateLeavePlan = "user_leaves/updatePlanStatus";

  ///EMPLOYEE
}
