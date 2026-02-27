import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/core/theme/app_theme_provider.dart';
import 'package:hrms_yb/features/auth/forgot_pass/forgot_password_provider.dart';
import 'package:hrms_yb/shared/utils/app_extensions.dart';
import 'package:hrms_yb/shared/utils/app_size.dart';
import 'package:hrms_yb/shared/widgets/common_button.dart';
import 'package:hrms_yb/shared/widgets/common_text_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class ForgotPinScreen extends StatefulWidget {
  const ForgotPinScreen({super.key});

  @override
  State<ForgotPinScreen> createState() => _ForgotPinScreenState();
}

class _ForgotPinScreenState extends State<ForgotPinScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ForgotPasswordProvider(context: context),
      child: Consumer<ForgotPasswordProvider>(
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

  Widget _buildBody({required BuildContext context, required ForgotPasswordProvider provider}) {
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonTextField(
                            isEnable: provider.currentState == ForgotPassState.init,
                            controller: provider.emailController,
                            hintText: "Enter your email id",
                            labelText: "Email Id",
                            prefixIcon: Icon(Icons.email),
                          ),
                          if (provider.currentState == ForgotPassState.verifyOtp) ...[
                            SizedBox(height: AppSize.verticalWidgetSpacing),
                            Text("Enter OTP"),
                            SizedBox(height: AppSize.verticalWidgetSpacing / 4),
                            MaterialPinField(
                              length: 6,
                              onCompleted: (value) {
                                provider.otpController.text = value;
                                provider.updateState();
                              },
                              theme: MaterialPinTheme(
                                borderColor: AppColors.borderGrey,
                                focusedFillColor: Colors.transparent,
                                shape: MaterialPinShape.outlined,
                                cellSize: const Size(45, 47),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ],
                          if (provider.currentState == ForgotPassState.setPassword) ...[
                            SizedBox(height: AppSize.verticalWidgetSpacing),
                            CommonTextField(
                              controller: provider.newPassController,
                              hintText: "Enter New Password",
                              prefixIcon: Icon(Icons.lock_outline),
                              suffixIcon: provider.hideNewPass ? Icons.visibility_off : Icons.visibility,
                              obscureText: provider.hideNewPass,
                              onSuffixTap: () {
                                provider.hideNewPass = !provider.hideNewPass;
                                provider.updateState();
                              },
                            ),
                            SizedBox(height: AppSize.verticalWidgetSpacing),
                            CommonTextField(
                              controller: provider.confirmNewPassController,
                              hintText: "Confirm New Password",
                              prefixIcon: Icon(Icons.lock_outline),
                              obscureText: provider.hideConfirmPass,
                              suffixIcon: provider.hideConfirmPass ? Icons.visibility_off : Icons.visibility,
                              onSuffixTap: () {
                                provider.hideConfirmPass = !provider.hideConfirmPass;
                                provider.updateState();
                              },
                            ),
                          ],

                          SizedBox(height: 24),
                          CommonButton(
                            isLoading: provider.isLoading,
                            title: getButtonTitle(provider: provider),
                            onTap: () {
                              if (provider.currentState == ForgotPassState.init) {
                                provider.requestOtp();
                              } else if (provider.currentState == ForgotPassState.verifyOtp) {
                                provider.verifyOtp();
                              } else if (provider.currentState == ForgotPassState.setPassword) {
                                provider.setNewPassword();
                              }
                              provider.updateState();
                            },
                          ),
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

  String getButtonTitle({required ForgotPasswordProvider provider}) {
    String titl = "Get OTP";
    if (provider.currentState == ForgotPassState.init) {
    } else if (provider.currentState == ForgotPassState.verifyOtp) {
      titl = "Verify OTP";
    } else if (provider.currentState == ForgotPassState.setPassword) {
      titl = "Set Password";
    }
    return titl;
  }
}
