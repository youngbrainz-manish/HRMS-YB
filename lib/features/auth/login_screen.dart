import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/router/app_router.dart';
import 'package:hrms_yb/core/theme/app_theme_provider.dart';
import 'package:hrms_yb/features/auth/login_provider.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:hrms_yb/shared/widgets/common_button.dart';
import 'package:hrms_yb/shared/widgets/common_text_field.dart';
import 'package:provider/provider.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginProvider(context: context),
      child: Consumer<LoginProvider>(
        builder: (context, provider, child) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Scaffold(
              body: SafeArea(
                child: _buildBody(context: context, provider: provider),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody({required BuildContext context, required LoginProvider provider}) {
    bool isDarkMode = context.watch<AppThemeProvider>().isDarkMode;
    return Container(
      color: isDarkMode ? AppColors.appScreenDark : AppColors.appScreenLight,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
                  onPressed: () {
                    context.read<AppThemeProvider>().toggleTheme();
                  },
                ),
              ),

              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(shape: BoxShape.circle, color: isDarkMode ? Colors.black : Colors.white),
                child: Image.asset("assets/images/transparant_logo.png", height: 120, width: 120),
              ),
              SizedBox(height: 8),
              Text("HRMS YB", style: AppTextStyle().headingTextStyle(context: context, fontSize: 36)),
              Text(
                "Sign in to continue",
                style: AppTextStyle().subTitleTextStyle(context: context, color: AppColors.greyColor),
              ),
              SizedBox(height: 32),
              Card(
                child: Container(
                  padding: EdgeInsets.only(left: 24, top: 32, right: 24, bottom: 16),
                  child: Column(
                    children: [
                      CommonTextField(
                        controller: provider.emailController,
                        hintText: "Enter your email id",
                        labelText: "Email ID",
                        prefixIcon: Icon(Icons.email),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email id is required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppSize.verticalWidgetSpacing),
                      CommonTextField(
                        controller: provider.pinController,
                        hintText: "Enter your password",
                        labelText: "Enter Password",
                        prefixIcon: Icon(Icons.password),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 36),
                      CommonButton(
                        isLoading: provider.isLoading,
                        title: "Login",
                        onTap: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          if (provider.emailController.text.isEmpty || provider.pinController.text.isEmpty) {
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
                            return;
                          }
                          var data = await provider.login(
                            email: provider.emailController.text.trim(),
                            password: provider.pinController.text.trim(),
                          );

                          if (data == true) {
                            if (provider.userModel!.roleId == 1) {
                              // ignore: use_build_context_synchronously
                              GoRouter.of(context).go(AppRouter.employeeshomeScreenRoute);
                            } else {
                              // ignore: use_build_context_synchronously
                              GoRouter.of(context).go(AppRouter.hrDashboardRoute);
                            }
                          }
                        },
                      ),
                      SizedBox(height: AppSize.verticalWidgetSpacing),
                      GestureDetector(
                        onTap: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          final result = await context.push(AppRouter.forgotPinRoute);

                          if (result == true) {
                            ScaffoldMessenger.of(
                              context, // ignore: use_build_context_synchronously
                            ).showSnackBar(const SnackBar(content: Text("Recovery email sent successfully")));
                          }
                        },
                        child: Text(
                          "Forgot your PIN?",
                          style: AppTextStyle().titleTextStyle(context: context, color: AppColors.textButtonColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
