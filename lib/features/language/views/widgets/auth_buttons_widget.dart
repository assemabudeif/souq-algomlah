import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/core/theme/app_color.dart';
import '/core/utilities/app_routes.dart';
import '/core/utilities/extensions.dart';
import '/core/utilities/font_manager.dart';
import '/features/language/viewmodel/language_cubit.dart';
import '/generated/locale_keys.g.dart';

class AuthButtonsWidget extends StatelessWidget {
  const AuthButtonsWidget({
    super.key,
    required LanguageCubit vm,
  }) : _vm = vm;
  final LanguageCubit _vm;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      bloc: _vm,
      builder: (context, state) {
        return Visibility(
          visible: _vm.selectedLanguage != null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 27.w,
                height: 6.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.w),
                  gradient: AppColors.loginButtonGradientColor,
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10.w),
                  onTap: () {
                    context.navigateToNamed(AppRoutes.loginRoute);
                  },
                  child: Center(
                    child: Text(
                      LocaleKeys.auth_login.tr(),
                      style: TextStyle(
                        fontSize: 15.5.sp,
                        fontWeight: FontManager.mediumFontWeight,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
              Gap(2.w),
              TextButton(
                onPressed: () {
                  context.navigateToNamed(AppRoutes.registerRoute);
                },
                child: Text(
                  LocaleKeys.auth_register.tr(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontManager.mediumFontWeight,
                    color: AppColors.blackColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
