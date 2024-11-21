import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/core/services/services_locator.dart';
import '/core/theme/app_color.dart';
import '/core/utilities/font_manager.dart';
import '/features/auth/login/viewmodel/login_cubit.dart';
import '/generated/locale_keys.g.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _vm = sl<LoginCubit>();

  @override
  void dispose() {
    _vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => _vm,
      child: Scaffold(
        backgroundColor: AppColors.secondBackgroundColor,
        appBar: AppBar(),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 3.h,
          ),
          child: Form(
            key: _vm.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.auth_login.tr(),
                  style: TextStyle(
                    fontSize: 22.sp,
                    color: AppColors.blackColor,
                    fontWeight: FontManager.boldFontWeight,
                  ),
                ),
                Gap(10.h),
                TextFormField(
                  controller: _vm.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: LocaleKeys.auth_user_name_hint.tr(),
                  ),
                  validator: (value) {
                    final valid = EmailValidator.validate(value ?? "");
                    log("Email Valid: $valid");
                    if (value!.isEmpty) {
                      return LocaleKeys.general_required_field.tr();
                    } else if (!valid) {
                      return context.locale == const Locale("en")
                          ? "not valid email!"
                          : "البريد الإلكتروني غير صالح!";
                    }
                    return null;
                  },
                ),
                Gap(2.h),
                BlocBuilder<LoginCubit, LoginState>(
                  bloc: _vm,
                  builder: (context, state) {
                    return TextFormField(
                      controller: _vm.passwordController,
                      obscureText: _vm.isPasswordHidden,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: LocaleKeys.auth_password.tr(),
                        suffixIcon: IconButton(
                          onPressed: _vm.changePasswordVisibility,
                          icon: Icon(
                            _vm.isPasswordHidden
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 20.sp,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.general_required_field.tr();
                        } else if (value.length < 8) {
                          return context.locale == const Locale('en')
                              ? 'Password must be at least 8 characters'
                              : 'يجب أن تكون كلمة المرور على الأقل 8 أحرف';
                        }
                        return null;
                      },
                    );
                  },
                ),
                Gap(2.h),
                InkWell(
                  onTap: () {
                    _vm.resetPassword(context);
                  },
                  child: Text(
                    LocaleKeys.auth_reset_password.tr(),
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                Gap(2.h),
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return state is LoginLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            onPressed: () {
                              _vm.login(context);
                            },
                            child: Text(
                              LocaleKeys.auth_login.tr(),
                            ),
                          );
                  },
                ),
                Gap(2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LocaleKeys.auth_dnt_have_account.tr(),
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColors.hintColor,
                      ),
                    ),
                    Gap(1.w),
                    InkWell(
                      onTap: () {
                        _vm.register(context);
                      },
                      child: Text(
                        LocaleKeys.auth_register.tr(),
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
