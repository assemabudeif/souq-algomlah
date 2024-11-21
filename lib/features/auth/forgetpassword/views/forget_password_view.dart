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

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key, required this.email});
  final String email;

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final ForgetPasswordCubit _vm = sl<ForgetPasswordCubit>();

  @override
  void initState() {
    _vm.emailController.text = widget.email;
    super.initState();
  }

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
              key: _vm.forgetPasswordFormKey,
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
                          LocaleKeys.reset_password_enter_email_label.tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontManager.semiBoldFontWeight,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Gap(8.h),
                        TextFormField(
                          controller: _vm.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText:
                                LocaleKeys.reset_password_email_or_phone.tr(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                    builder: (context, state) {
                      return state is SendOTPLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              onPressed: () {
                                _vm.sendOtp(context);
                              },
                              child: Text(
                                LocaleKeys.general_next.tr(),
                              ),
                            );
                    },
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
