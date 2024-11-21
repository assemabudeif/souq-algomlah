import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/core/services/services_locator.dart';
import '/core/theme/app_color.dart';
import '/core/utilities/font_manager.dart';
import '/features/auth/forgetpassword/viewmodel/forget_password_cubit.dart';
import '/generated/locale_keys.g.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key, required this.params});
  final ResetPasswordViewParams params;

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final ForgetPasswordCubit _vm = sl<ForgetPasswordCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ForgetPasswordCubit>(
      create: (context) => _vm,
      child: Scaffold(
        backgroundColor: AppColors.secondBackgroundColor,
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 3.h,
          ),
          child: Form(
            key: _vm.resetPasswordFormKey,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.auth_reset_password.tr(),
                        style: TextStyle(
                          fontSize: 21.sp,
                          fontWeight: FontManager.boldFontWeight,
                        ),
                      ),
                      Gap(2.h),
                      Text(
                        LocaleKeys.reset_password_enter_pw_label.tr(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontManager.semiBoldFontWeight,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Gap(8.h),
                      BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                        builder: (context, state) {
                          return TextFormField(
                            controller: _vm.newPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _vm.isPasswordHidden,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return LocaleKeys.general_required_field.tr();
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: LocaleKeys
                                  .update_password_input_new_password
                                  .tr(),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _vm.isPasswordHidden
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  _vm.togglePasswordVisibility();
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      Gap(1.h),
                      BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                        builder: (context, state) {
                          return TextFormField(
                            controller: _vm.confirmPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _vm.isConfirmPasswordHidden,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return LocaleKeys.general_required_field.tr();
                              } else if (value !=
                                  _vm.newPasswordController.text) {
                                return LocaleKeys
                                    .update_password_input_confirm_new_password
                                    .tr();
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: LocaleKeys
                                  .update_password_input_confirm_new_password
                                  .tr(),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _vm.isConfirmPasswordHidden
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  _vm.toggleConfirmPasswordVisibility();
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                  builder: (context, state) {
                    return state is ResetPasswordLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              _vm.resetPassword(
                                context: context,
                                email: widget.params.email,
                                otp: widget.params.otp,
                              );
                            },
                            child: Text(
                              LocaleKeys.auth_reset_password.tr(),
                            ),
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ResetPasswordViewParams {
  final String email;
  final String otp;

  ResetPasswordViewParams({
    required this.email,
    required this.otp,
  });
}
