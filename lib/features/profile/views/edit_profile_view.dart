import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/core/services/services_locator.dart';
import '/core/theme/app_color.dart';
import '/core/utilities/font_manager.dart';
import '/features/profile/viewmodels/edit_profile/edit_profile_cubit.dart';
import '/features/profile/views/widgets/edit_profile_city_widget.dart';
import '/generated/locale_keys.g.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _vm = sl<EditProfileCubit>();

  @override
  void initState() {
    _vm.init(context);
    super.initState();
  }

  @override
  void dispose() {
    _vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditProfileCubit>(
      create: (context) => _vm,
      child: BlocConsumer<EditProfileCubit, EditProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
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
                      LocaleKeys.settings_update_profile.tr(),
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
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Zأ-ي\s]')),
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
                      decoration: InputDecoration(
                        hintText: LocaleKeys.auth_mobile.tr(),
                      ),
                      validator: (value) {
                        var regex = RegExp(r'^[569]\d{7}$');
                        if (value == null || value.isEmpty) {
                          return LocaleKeys.general_required_field.tr();
                        } else if (regex.hasMatch(value) == false) {
                          return context.locale == const Locale("en")
                              ? "Invalid Phone number"
                              : "رقم الهاتف غير صحيح";
                        } else {
                          return null;
                        }
                      },
                    ),
                    Gap(1.h),
                    TextFormField(
                      controller: _vm.additionalPhoneController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9+]+')),
                      ],
                      validator: (value) {
                        var regex = RegExp(r'^[569]\d{7}$');
                        if (value == null || value.isEmpty) {
                          return null;
                        } else if (regex.hasMatch(value) == false) {
                          return context.locale == const Locale("en")
                              ? "Invalid Phone number"
                              : "رقم الهاتف غير صحيح";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: LocaleKeys.auth_additional_mobile.tr(),
                      ),
                    ),
                    Gap(1.h),
                    Text(
                      LocaleKeys.auth_residential_info.tr(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.primary,
                      ),
                    ),
                    Gap(2.h),
                    EditProfileCityWidget(vm: _vm),
                    Gap(1.5.h),
                    TextFormField(
                      controller: _vm.blockController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        hintText: LocaleKeys.auth_widget.tr(),
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
                      keyboardType: TextInputType.text,
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
                              hintText:
                                  LocaleKeys.addresses_apartment_number.tr(),
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
                    state is! EditProfileLoading
                        ? ElevatedButton(
                            onPressed: () {
                              _vm.editProfile(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              elevation: 0,
                            ),
                            child: Text(
                              LocaleKeys.auth_update_profile.tr(),
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
