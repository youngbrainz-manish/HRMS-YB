import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/features/auth/forgot_pin_screen.dart';
import 'package:hrms_yb/features/auth/login_screen.dart';
import 'package:hrms_yb/features/dashboard/employee/dashboard/employee_dashboard_provider.dart';
import 'package:hrms_yb/features/dashboard/employee/dashboard/employee_dashboard_screen.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/attendance/employee_attendace_screen.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/home/employee_home_screen.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/leave/employee_leave_screen.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/pay_slip/employees_pay_slip_screen.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/profile/employees_profile_screen.dart';
import 'package:hrms_yb/features/dashboard/employee/screens/leave/leave_form/leave_form_screen.dart';
import 'package:hrms_yb/features/dashboard/hr/dashboard/hr_dashboard_screen.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

class AppRouter {
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

  static GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    initialLocation: loginScreenRoute,
    routes: <RouteBase>[
      GoRoute(
        name: 'Login Screen',
        path: loginScreenRoute,
        pageBuilder: slideTransitionPageBuider(child: LoginScreen()),
      ),
      GoRoute(path: forgotPinRoute, builder: (context, state) => const ForgotPinScreen()),
      GoRoute(path: hrDashboardRoute, builder: (context, state) => const HrDashboardScreen()),
      GoRoute(path: leaveFormScreenRoute, builder: (context, state) => const LeaveFormScreen()),
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
