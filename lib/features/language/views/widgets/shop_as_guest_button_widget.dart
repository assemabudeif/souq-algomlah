import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/core/theme/app_color.dart';
import '/core/utilities/font_manager.dart';
import '/features/language/viewmodel/language_cubit.dart';
import '/generated/locale_keys.g.dart';

class ShopAsGuestButtonWidget extends StatelessWidget {
  const ShopAsGuestButtonWidget({
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
          child: ElevatedButton(
            onPressed: () {
              _vm.shopAsGuestToggle();
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.w),
              ),
              backgroundColor: AppColors.whiteColor,
              surfaceTintColor: AppColors.whiteColor,
              side: const BorderSide(
                color: AppColors.primary,
              ),
              fixedSize: Size(80.w, 6.h),
            ),
            child: Text(
              LocaleKeys.auth_shop_as_guest.tr(),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontManager.mediumFontWeight,
                color: AppColors.blackColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
