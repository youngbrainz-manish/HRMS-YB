import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/constants/app_constants.dart';
import 'package:hrms_yb/core/network/authentication_data.dart';
import 'package:hrms_yb/core/network/dio_api_request.dart';
import 'package:hrms_yb/core/network/dio_api_services.dart';
import 'package:hrms_yb/core/router/app_router.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/core/theme/app_theme_provider.dart';
import 'package:hrms_yb/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomSplashScreen extends StatefulWidget {
  const CustomSplashScreen({super.key});

  @override
  State<CustomSplashScreen> createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen> {
  bool isDark = false;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          isDark = context.read<AppThemeProvider>().isDarkMode;
        });
      });
    });
    _init();
  }

  void _init() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userJson = sharedPreferences.getString(AppConstants.userDetails);
    if (userJson != null && userJson != "null") {
      AuthenticationData.userModel = UserModel.fromJson(jsonDecode(userJson));
      await getProfileData();
    }

    Future.delayed(const Duration(seconds: 2), () {
      if (AuthenticationData.userModel != null) {
        if (AuthenticationData.userModel?.roles?.first.roleName.toString().toLowerCase() == "Employee".toLowerCase()) {
          GoRouter.of(context).go(AppRouter.employeeshomeScreenRoute); // ignore: use_build_context_synchronously
        } else {
          GoRouter.of(context).go(AppRouter.hrDashboardRoute); // ignore: use_build_context_synchronously
        }
      } else {
        GoRouter.of(context).go(AppRouter.loginScreenRoute); // ignore: use_build_context_synchronously
      }
    });
  }

  Future<void> getProfileData() async {
    String employeeId = AuthenticationData.userModel?.empId.toString() ?? '';
    String url = "${DioApiServices.getUserById}/$employeeId";
    try {
      var response = await DioApiRequest().getCommonApiCall(url);
      if (response != null && response.data?['success'] == true) {
        AuthenticationData.userModel = UserModel.fromJson(response.data['data']);
      }
    } catch (e) {
      // print("Error fetching profile data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _buildBody(context: context)),
    );
  }

  Widget _buildBody({required BuildContext context}) {
    return AnimatedContainer(
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
      color: isDark ? AppColors.blackColor : AppColors.whiteColor,
      child: SizedBox.expand(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/transparant_logo.png", height: 175, width: 175),
              const SizedBox(height: 20),
              TypewriterText(
                text: "Welcome to HRMS YB",
                style: TextStyle(color: isDark ? AppColors.whiteColor : AppColors.blackColor, fontSize: 16),
                speed: const Duration(milliseconds: 200),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration speed;

  const TypewriterText({super.key, required this.text, this.style, this.speed = const Duration(milliseconds: 80)});

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  String _displayText = "";
  int _index = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    _timer = Timer.periodic(widget.speed, (timer) {
      if (!mounted) return;

      if (_index < widget.text.length) {
        setState(() {
          _displayText += widget.text[_index];
          _index++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text("${_displayText}_", style: widget.style);
  }
}
