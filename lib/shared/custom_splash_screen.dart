import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/constants/app_constants.dart';
import 'package:hrms_yb/core/network/authentication_data.dart';
import 'package:hrms_yb/core/router/app_router.dart';
import 'package:hrms_yb/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:typing_text_animation/typing_text_animation.dart';

class CustomSplashScreen extends StatefulWidget {
  const CustomSplashScreen({super.key});

  @override
  State<CustomSplashScreen> createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userJson = sharedPreferences.getString(AppConstants.userDetails);
    AuthenticationData.userModel = userJson != null ? UserModel.fromMap(jsonDecode(userJson)) : null;

    Future.delayed(const Duration(seconds: 2), () {
      if (AuthenticationData.userModel != null) {
        GoRouter.of(context).go(AppRouter.employeeshomeScreenRoute); // ignore: use_build_context_synchronously
      } else {
        GoRouter.of(context).go(AppRouter.loginScreenRoute); // ignore: use_build_context_synchronously
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _buildBody(context: context)),
    );
  }

  Widget _buildBody({required BuildContext context}) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/transparant_logo.png", height: 175, width: 175),
            SizedBox(height: 20),
            TypingTextAnimation(
              texts: ["Welcome to HRMS YB", ""],
              textStyle: TextStyle(color: Colors.black, fontSize: 16.0),
              showCursor: true,
            ),
          ],
        ),
      ),
    );
  }
}
