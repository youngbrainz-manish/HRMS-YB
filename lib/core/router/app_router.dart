import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/features/auth/forgot_pass/forgot_pin_screen.dart';
import 'package:hrms_yb/features/auth/login_screen.dart';
import 'package:hrms_yb/features/dashboard/employee/dashboard/employee_dashboard_provider.dart';
import 'package:hrms_yb/features/dashboard/employee/dashboard/employee_dashboard_screen.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/attendance/employee_attendace_screen.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/holiday/emp_holiday_screen.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/home/employee_home_screen.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/leave/employee_leave_screen.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/pay_slip/employees_pay_slip_screen.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/profile/employees_profile_screen.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/leave/leave_form/leave_form_screen.dart';
import 'package:hrms_yb/features/dashboard/hr/dashboard/hr_dashboard_provider.dart';
import 'package:hrms_yb/features/dashboard/hr/dashboard/hr_dashboard_screen.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/attendance/audit/audit_log_screen.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/attendance/correction/attendance_correction_screen.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/attendance/hr_attendance_screen.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/employee/add_employee_screen.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/employee/details/employee_details_screen.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/employee/hr_employee_screen.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/holiday/add_holiday_screen.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/holiday/hr_holiday_screen.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/home/hr_home_screen.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/leave/hr_leave_screen.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/leave/reply/reply_leave_screen.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/payroll/advance/edit_advance_screen.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/payroll/hr_payroll_screen.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/profile/edit_profile_screen.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/profile/hr_profile_screen.dart';
import 'package:hrms_yb/shared/custom_splash_screen.dart';
import 'package:hrms_yb/shared/notification/notification_screen.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');
final GlobalKey<NavigatorState> _shellNavigatorKey1 = GlobalKey<NavigatorState>(debugLabel: 'shell');

class AppRouter {
  static const splashRoute = '/';
  static const loginScreenRoute = '/login';
  static const forgotPinRoute = '/forgot-pin';
  static const hrDashboardRoute = '/hr-dashboard';

  static const employeeshomeScreenRoute = '/employees-home-screen';
  static const employeesAttendaceScreenRoute = '/employees-Attendace-screen';
  static const employeesLeaveScreenRoute = '/employees-Leave-screen';
  static const employeesPaySlipScreenRoute = '/employees-PaySlip-screen';
  static const employeesProfileScreenRoute = '/employees-Profile-screen';

  static const leaveFormScreenRoute = '/leave-form-screen';

  static const leaveRoute = '/leave';
  static const attendanceRoute = '/attendance';

  static const hrEmployeeScreenRoute = '/hrEmployeeScreen';
  static const hrAttendanceScreenRoute = '/hrAttendanceScreen';
  static const hrLeaveScreenRoute = '/hrLeaveScreen';
  static const hrPayrollScreenRoute = '/hrPayrollScreen';
  static const addEmployeeScreenRoute = '/addEmployeeScreen';
  static const employeeDetailsScreenRoute = '/employeeDetailsScreen';
  static const aCorrectionScreenRoute = '/attendanceCorrectionScreen';
  static const attendanceAuditLogScreenRoute = '/auditLogScreen';
  static const attendanceCorrectionScreenRoute = '/attendanceCorrectionScreen';
  static const replyLeaveScreenRoute = '/replyLeaveScreen';
  static const editAdvanceScreenRoute = '/editAdvanceScreen';
  static const notificationScreenRoute = '/notificationScreen';
  static const hrProfileScreenRoute = '/hrProfileScreen';
  static const hrHolidayScreenRoute = '/hrHolidayScreen';
  static const editProfileScreenRoute = '/editProfileScreen';
  static const addHolidayScreenRoute = '/addHolidayScreen';

  //Emp
  static String holidayScreenRoute = '/holidayScreen';

  static GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    initialLocation: splashRoute,
    routes: <RouteBase>[
      GoRoute(
        name: 'Splash Screen',
        path: splashRoute,
        pageBuilder: slideTransitionPageBuider(child: CustomSplashScreen()),
      ),
      GoRoute(
        name: 'Login Screen',
        path: loginScreenRoute,
        pageBuilder: slideTransitionPageBuider(child: LoginScreen()),
      ),
      GoRoute(path: forgotPinRoute, builder: (context, state) => const ForgotPinScreen()),
      GoRoute(path: leaveFormScreenRoute, builder: (context, state) => const LeaveFormScreen()),
      GoRoute(path: addEmployeeScreenRoute, builder: (context, state) => const AddEmployeeScreen()),
      GoRoute(path: employeeDetailsScreenRoute, builder: (context, state) => const EmployeeDetailsScreen()),
      GoRoute(path: attendanceCorrectionScreenRoute, builder: (context, state) => const AttendanceCorrectionScreen()),
      GoRoute(path: attendanceAuditLogScreenRoute, builder: (context, state) => const AuditLogScreen()),
      GoRoute(path: replyLeaveScreenRoute, builder: (context, state) => const ReplyLeaveScreen()),
      GoRoute(path: editAdvanceScreenRoute, builder: (context, state) => const EditAdvanceScreen()),
      GoRoute(path: notificationScreenRoute, builder: (context, state) => const NotificationScreen()),
      GoRoute(path: editProfileScreenRoute, builder: (context, state) => EditProfileScreen()),
      GoRoute(path: addHolidayScreenRoute, builder: (context, state) => const AddHolidayScreen()),

      ///Emp
      GoRoute(path: holidayScreenRoute, builder: (context, state) => const HolidayScreen()),

      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget? child) {
          return ChangeNotifierProvider<EmployeeDashboardProvider>(
            create: (_) => EmployeeDashboardProvider(context: context),
            child: EmployeeDashboardScreen(widget: child ?? EmployeeHomeScreen()),
          );
        },
        routes: [
          GoRoute(
            name: 'Employee Home Screen',
            path: employeeshomeScreenRoute,
            builder: (BuildContext context, GoRouterState state) {
              return EmployeeHomeScreen();
            },
          ),
          GoRoute(
            name: 'Employee Attendance Screen',
            path: employeesAttendaceScreenRoute,
            builder: (BuildContext context, GoRouterState state) {
              return EmployeeAttendaceScreen();
            },
          ),
          GoRoute(
            name: 'Employee Leave Screen',
            path: employeesLeaveScreenRoute,
            builder: (BuildContext context, GoRouterState state) {
              return EmployeeLeaveScreen();
            },
          ),
          GoRoute(
            name: 'Employee PaySlip Screen',
            path: employeesPaySlipScreenRoute,
            builder: (BuildContext context, GoRouterState state) {
              return EmployeesPaySlipScreen();
            },
          ),

          GoRoute(
            name: 'Employees Profile Screen',
            path: employeesProfileScreenRoute,
            builder: (BuildContext context, GoRouterState state) {
              return const EmployeesProfileScreen();
            },
          ),
        ],
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey1,
        builder: (BuildContext context, GoRouterState state, Widget? child) {
          return ChangeNotifierProvider<HrDashboardProvider>(
            create: (_) => HrDashboardProvider(context: context),
            child: HrDashboardScreen(widget: child ?? HrHomeScreen()),
          );
        },
        routes: [
          GoRoute(
            name: 'Hr Profile Screen',
            path: hrProfileScreenRoute,
            builder: (BuildContext context, GoRouterState state) {
              return HrProfileScreen();
            },
          ),
          GoRoute(
            name: 'Hr Home Screen',
            path: hrDashboardRoute,
            builder: (BuildContext context, GoRouterState state) {
              return HrHomeScreen();
            },
          ),
          GoRoute(
            name: 'Hr Employee Screen',
            path: hrEmployeeScreenRoute,
            builder: (BuildContext context, GoRouterState state) {
              return const HrEmployeeScreen();
            },
          ),
          GoRoute(
            name: 'Hr Attendance Screen',
            path: hrAttendanceScreenRoute,
            builder: (BuildContext context, GoRouterState state) {
              return HrAttendanceScreen();
            },
          ),
          GoRoute(
            name: 'Hr Leave Screen',
            path: hrLeaveScreenRoute,
            builder: (BuildContext context, GoRouterState state) {
              return HrLeaveScreen();
            },
          ),
          GoRoute(
            name: 'Hr Payroll Screen',
            path: hrPayrollScreenRoute,
            builder: (BuildContext context, GoRouterState state) {
              return HrPayrollScreen();
            },
          ),
          GoRoute(
            name: 'Hr Holiday Screen',
            path: hrHolidayScreenRoute,
            builder: (BuildContext context, GoRouterState state) {
              return HrHolidayScreen();
            },
          ),
        ],
      ),
    ],
  );

  static CustomTransitionPage Function(dynamic context, dynamic state) slideTransitionPageBuider({
    required Widget child,
  }) {
    return (context, state) {
      return CustomTransitionPage(
        transitionDuration: Duration(milliseconds: 200),
        reverseTransitionDuration: Duration(milliseconds: 200),
        key: state.pageKey,
        child: child,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.easeInOut);

          return FadeTransition(opacity: curvedAnimation, child: child);
        },
      );
    };
  }
}
