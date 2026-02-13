import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/theme/app_theme_provider.dart';
import 'package:hrms_yb/shared/utils/app_extensions.dart';
import 'package:hrms_yb/shared/widgets/common_button.dart';
import 'package:hrms_yb/shared/widgets/common_text_field.dart';
import 'package:provider/provider.dart';

class ForgotPinScreen extends StatefulWidget {
  const ForgotPinScreen({super.key});

  @override
  State<ForgotPinScreen> createState() => _ForgotPinScreenState();
}

class _ForgotPinScreenState extends State<ForgotPinScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        // appBar: AppBar(title: Text("data")),
        body: SafeArea(child: _buildBody(context: context)),
      ),
    );
  }

  Widget _buildBody({required BuildContext context}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    GoRouter.of(context).pop();
                  },
                  child: Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.watch<AppThemeProvider>().isDarkMode
                          ? Colors.white.withValues(alpha: 0.1)
                          : Colors.black.withValues(alpha: 0.02),
                      border: Border.all(color: Colors.black.withValues(alpha: 0.12)),
                    ),
                    child: Center(child: Icon(Icons.arrow_back_ios_rounded)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.watch<AppThemeProvider>().isDarkMode ? Colors.black : Colors.white,
                    ),
                    child: Image.asset("assets/images/transparant_logo.png", height: 120, width: 120),
                  ),
                  SizedBox(height: 20),
                  Text("Recover Access", style: context.textTheme.displaySmall),
                  SizedBox(height: 8),
                  Text("Enter your details to recover your PIN", style: context.textTheme.bodyMedium),
                  SizedBox(height: 36),
                  Card(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CommonTextField(
                            controller: TextEditingController(),
                            hintText: "Enter your email id",
                            labelText: "Email Id",
                            prefixIcon: Icon(Icons.email),
                          ),
                          SizedBox(height: 24),
                          CommonButton(title: "Send Recovery Instruction", onTap: () {}),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
