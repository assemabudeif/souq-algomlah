import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/core/services/services_locator.dart';
import '/core/theme/app_color.dart';
import '/features/profile/viewmodels/change_password/change_password_cubit.dart';
import '/generated/locale_keys.g.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final _vm = sl<ChangePasswordCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangePasswordCubit>(
      create: (context) => _vm,
      child: Scaffold(
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
                  LocaleKeys.my_account_list_change_password.tr(),
                  style: TextStyle(
                    fontSize: 23.sp,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(8.h),
                TextFormField(
                  controller: _vm.newPasswordController,
                  decoration: InputDecoration(
                    labelText:
                        LocaleKeys.update_password_input_new_password.tr(),
                  ),
                  obscureText: true,
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
                ),
                Gap(2.h),
                TextFormField(
                  controller: _vm.confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: LocaleKeys
                        .update_password_input_confirm_new_password
                        .tr(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return LocaleKeys.general_required_field.tr();
                    } else if (value != _vm.newPasswordController.text) {
                      return context.locale == const Locale('en')
                          ? 'Password does not match'
                          : 'كلمة المرور غير متطابقة';
                    }
                    return null;
                  },
                ),
                Gap(4.h),
                BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                  bloc: _vm,
                  builder: (context, state) {
                    if (state is ChangePasswordLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ElevatedButton(
                      onPressed: () => _vm.changePassword(context),
                      child: Text(
                        LocaleKeys.my_account_list_change_password.tr(),
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
