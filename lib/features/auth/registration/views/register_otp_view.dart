import 'package:easy_localization/easy_localization.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/features/auth/registration/views/widgets/o_t_p_resend_widget.dart';
import '/features/auth/registration/viewmodel/registration_cubit.dart';
import '/core/services/services_locator.dart';
import '/core/theme/app_color.dart';
import '/core/utilities/font_manager.dart';

class RegisterOTPView extends StatefulWidget {
  const RegisterOTPView({
    super.key,
    required this.email,
  });

  final String email;

  @override
  State<RegisterOTPView> createState() => _RegisterOTPViewState();
}

class _RegisterOTPViewState extends State<RegisterOTPView> {
  final _vm = sl<RegistrationCubit>();

  @override
  void dispose() {
    _vm.disposeOTP();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegistrationCubit>(
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
            key: _vm.otpFormKey,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        context.locale == const ui.Locale('en')
                            ? 'Verify Email`'
                            : 'تحقق من البريد الإلكتروني',
                        style: TextStyle(
                          fontSize: 21.sp,
                          fontWeight: FontManager.boldFontWeight,
                        ),
                      ),
                      Gap(2.h),
                      Text(
                        context.locale == const ui.Locale('en')
                            ? 'Enter the verification code sent to your email'
                            : 'أدخل رمز التحقق المرسل إلى بريدك الإلكتروني',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontManager.semiBoldFontWeight,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Gap(6.h),
                      TextFormField(
                        controller: _vm.otpController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          hintText: context.locale == const ui.Locale('en')
                              ? 'Verification Code'
                              : 'كود التحقق',
                          hintStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontManager.semiBoldFontWeight,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 2.h,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return context.locale == const ui.Locale('en')
                                ? 'Please enter the verification code'
                                : 'الرجاء إدخال رمز التحقق';
                          }
                          return null;
                        },
                      ),
                      Gap(3.h),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: OTPResendWidget(
                          vm: _vm,
                          email: widget.email,
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<RegistrationCubit, RegistrationState>(
                  builder: (context, state) {
                    return state is VerifyOTPLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              _vm.verifyOTP(context, widget.email);
                            },
                            child: Text(
                              context.locale == const ui.Locale('en')
                                  ? 'Verify'
                                  : 'تحقق',
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
