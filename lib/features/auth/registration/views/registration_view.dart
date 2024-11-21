import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/core/utilities/app_routes.dart';
import '/core/utilities/extensions.dart';
import '/core/global/widgets/custom_checkbox_widget.dart';
import '/core/services/services_locator.dart';
import '/core/theme/app_color.dart';
import '/core/utilities/font_manager.dart';
import '/features/auth/registration/viewmodel/registration_cubit.dart';
import '/generated/locale_keys.g.dart';

import 'widgets/register_choose_city_widget.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  final _vm = sl<RegistrationCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegistrationCubit>(
      create: (context) => _vm,
      child: Scaffold(
        backgroundColor: AppColors.secondBackgroundColor,
        appBar: AppBar(),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 3.h,
          ),
          child: Form(
            key: _vm.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.auth_register.tr(),
                  style: TextStyle(
                    fontSize: 23.sp,
                    color: AppColors.blackColor,
                    fontWeight: FontManager.boldFontWeight,
                  ),
                ),
                Gap(1.h),
                Text(
                  LocaleKeys.auth_personal_info.tr(),
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColors.primary,
                  ),
                ),
                Gap(1.h),
                TextFormField(
                  controller: _vm.fullNameController,
                  keyboardType: TextInputType.name,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Zأ-ي\s]')),
                  ],
                  decoration: InputDecoration(
                    hintText: LocaleKeys.auth_full_name.tr(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return LocaleKeys.general_required_field.tr();
                    }
                    return null;
                  },
                ),
                Gap(1.h),
                BlocBuilder<RegistrationCubit, RegistrationState>(
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
                Gap(1.h),
                TextFormField(
                  controller: _vm.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: LocaleKeys.auth_email.tr(),
                  ),
                  validator: (value) {
                    final valid = EmailValidator.validate(value ?? "");
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
                Gap(1.h),
                TextFormField(
                  controller: _vm.phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9+]+')),
                  ],
                  //
                  decoration: InputDecoration(
                    hintText:
                        "${LocaleKeys.auth_mobile.tr()} ${LocaleKeys.general_optional.tr()}",
                  ),
                  // validator: (value) {
                  //   var regex = RegExp(r'^[569]\d{7}$');
                  //   if (value == null || value.isEmpty) {
                  //     return LocaleKeys.general_required_field.tr();
                  //   } else if (regex.hasMatch(value) == false) {
                  //     return context.locale == const Locale("en")
                  //         ? "Invalid Phone number"
                  //         : "رقم الهاتف غير صحيح";
                  //   } else {
                  //     return null;
                  //   }
                  // },
                ),
                // Gap(1.h),
                // TextFormField(
                //   controller: _vm.additionalPhoneController,
                //   keyboardType: TextInputType.phone,
                //   inputFormatters: [
                //     FilteringTextInputFormatter.allow(RegExp(r'[0-9+]+')),
                //   ],
                //   decoration: InputDecoration(
                //     hintText: LocaleKeys.auth_additional_mobile.tr(),
                //   ),
                //   validator: (value) {
                //     var regex = RegExp(r'^[569]\d{7}$');
                //     if (value == null || value.isEmpty) {
                //       return null;
                //     } else if (regex.hasMatch(value) == false) {
                //       return context.locale == const Locale("en")
                //           ? "Invalid Phone number"
                //           : "رقم الهاتف غير صحيح";
                //     } else {
                //       return null;
                //     }
                //   },
                // ),
                Gap(1.h),
                Text(
                  LocaleKeys.auth_residential_info.tr(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.primary,
                  ),
                ),
                Gap(2.h),
                RegisterChooseCityWidget(vm: _vm),
                Gap(1.5.h),
                TextFormField(
                  controller: _vm.blockController,
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                    hintText: context.locale == const Locale("en")
                        ? "Region"
                        : "المنطقة",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return LocaleKeys.general_required_field.tr();
                    }
                    return null;
                  },
                ),
                Gap(1.h),
                TextFormField(
                  controller: _vm.gadeController,
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                    hintText:
                        "${LocaleKeys.auth_gada.tr()} ${LocaleKeys.general_optional.tr()}",
                  ),
                ),
                Gap(1.h),
                TextFormField(
                  controller: _vm.streetController,
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                    hintText: LocaleKeys.auth_street.tr(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return LocaleKeys.general_required_field.tr();
                    }
                    return null;
                  },
                ),
                Gap(1.h),
                TextFormField(
                  controller: _vm.houseNoController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    hintText: LocaleKeys.auth_house_no.tr(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return LocaleKeys.general_required_field.tr();
                    }
                    return null;
                  },
                ),
                Gap(1.h),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _vm.floorController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          hintText: LocaleKeys.addresses_floor.tr(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return LocaleKeys.general_required_field.tr();
                          }
                          return null;
                        },
                      ),
                    ),
                    Gap(1.w),
                    Expanded(
                      child: TextFormField(
                        controller: _vm.apartmentNoController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          hintText: LocaleKeys.addresses_apartment_number.tr(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return LocaleKeys.general_required_field.tr();
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                Gap(2.h),
                InkWell(
                  onTap: () {
                    _vm.changeAgreeWithPrivacy();
                  },
                  child: Row(
                    children: [
                      BlocBuilder<RegistrationCubit, RegistrationState>(
                        bloc: _vm,
                        builder: (context, state) {
                          return CustomCheckBoxWidget(
                            selected: _vm.isAgreeWithPriavacy,
                            onTap: _vm.changeAgreeWithPrivacy,
                          );
                        },
                      ),
                      Gap(1.w),
                      Text(
                        LocaleKeys.auth_i_agree_on.tr(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.blackColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context.navigateToNamed(AppRoutes.privacyPolicyRoute);
                        },
                        child: Text(
                          LocaleKeys.auth_privacy_policy.tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.primary,
                            fontWeight: FontManager.boldFontWeight,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Gap(2.h),
                BlocBuilder<RegistrationCubit, RegistrationState>(
                  bloc: _vm,
                  builder: (context, state) {
                    return state is! RegistrationLoading
                        ? ElevatedButton(
                            onPressed: () {
                              _vm.register(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _vm.isAgreeWithPriavacy
                                  ? AppColors.primary
                                  : AppColors.lightButtonColor,
                              elevation: 0,
                            ),
                            child: Text(
                              LocaleKeys.auth_register.tr(),
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                ),
                Gap(2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LocaleKeys.auth_already_have_account.tr(),
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.hintColor,
                      ),
                    ),
                    Gap(1.w),
                    InkWell(
                      onTap: () {
                        _vm.login(context);
                      },
                      child: Text(
                        LocaleKeys.auth_login.tr(),
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: AppColors.primary,
                          fontWeight: FontManager.boldFontWeight,
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
