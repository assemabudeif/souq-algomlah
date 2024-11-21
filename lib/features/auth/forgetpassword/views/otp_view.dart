import 'package:easy_localization/easy_localization.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/core/services/services_locator.dart';
import '/core/theme/app_color.dart';
import '/core/utilities/font_manager.dart';
import '/features/auth/forgetpassword/viewmodel/forget_password_cubit.dart';
import '/generated/locale_keys.g.dart';

class ResetPasswordOTPView extends StatefulWidget {
  const ResetPasswordOTPView({super.key, required this.email});

  final String email;

  @override
  State<ResetPasswordOTPView> createState() => _ResetPasswordOTPViewState();
}

class _ResetPasswordOTPViewState extends State<ResetPasswordOTPView> {
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
                      LocaleKeys.reset_password_enter_code_label.tr(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontManager.semiBoldFontWeight,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Gap(8.h),
                    Directionality(
                      textDirection: ui.TextDirection.ltr,
                      child: OtpTextField(
                        numberOfFields: 6,
                        borderColor: AppColors.primary,
                        focusedBorderColor: AppColors.primary,
                        disabledBorderColor: AppColors.primary.withOpacity(0.5),
                        enabledBorderColor: AppColors.primary.withOpacity(0.3),
                        mainAxisAlignment: MainAxisAlignment.center,
                        contentPadding: EdgeInsets.symmetric(vertical: 4.w),
                        showFieldAsBox: true,
                        margin: EdgeInsets.symmetric(horizontal: 2.w),
                        borderRadius: BorderRadius.circular(2.w),
                        onSubmit: (String verificationCode) {
                          _vm.submtOtp(verificationCode);
                        },
                        fieldWidth: 10.w,
                        cursorColor: AppColors.primary,
                        autoFocus: true,
                        alignment: Alignment.center,
                        enabled: true,
                        textStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontManager.semiBoldFontWeight,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    Gap(3.h),
                    BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                      builder: (context, state) {
                        return Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: state is SendOTPLoading
                              ? const CircularProgressIndicator()
                              : TextButton(
                                  onPressed: () {
                                    _vm.reSendOTP(
                                      context: context,
                                      email: widget.email,
                                    );
                                  },
                                  child: Text(
                                    LocaleKeys.reset_password_retry.tr(),
                                    style: TextStyle(
                                      fontSize: 16.5.sp,
                                      fontWeight: FontManager.boldFontWeight,
                                    ),
                                    textAlign: TextAlign.end,
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
                  return state is VerifyOTPLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            _vm.verifyOTP(
                              context: context,
                              email: widget.email,
                            );
                          },
                          child: Text(
                            LocaleKeys.general_next.tr(),
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
