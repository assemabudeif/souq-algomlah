import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/core/global/cites.dart';
import '/core/theme/app_color.dart';
import '/core/utilities/font_manager.dart';
import '/features/auth/registration/viewmodel/registration_cubit.dart';
import '/generated/locale_keys.g.dart';

class RegisterChooseCityWidget extends StatelessWidget {
  const RegisterChooseCityWidget({
    super.key,
    required RegistrationCubit vm,
  }) : _vm = vm;

  final RegistrationCubit _vm;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      bloc: _vm,
      builder: (context, state) {
        return DropdownSearch<String>(
          onChanged: (value) {
            _vm.selectedCity = value!;
          },
          dropdownButtonProps: DropdownButtonProps(
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.blackWithOpacityColor,
            ),
            iconSize: 5.w,
          ),
          dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontManager.mediumFontWeight,
              color: AppColors.blackColor,
            ),
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.center,
            dropdownSearchDecoration: InputDecoration(
                hintText: LocaleKeys.home_city_dialog_choose_city.tr(),
                hintStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontManager.mediumFontWeight,
                  color: AppColors.lightTextColor,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                  vertical: 2.h,
                ),
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.borderColor,
                  ),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.borderColor,
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.borderColor,
                  ),
                ),
                filled: false),
          ),
          items: [
            for (int i = 0; i < cites.length; i++)
              context.locale == const Locale('en')
                  ? cites[i]['en'].toString()
                  : cites[i]['ar'].toString(),
          ],
          autoValidateMode: AutovalidateMode.always,
          enabled: true,
          compareFn: (item, selectedItem) => item == selectedItem,
          itemAsString: (item) => item,
          popupProps: PopupProps.dialog(
            showSearchBox: true,
            fit: FlexFit.tight,
            containerBuilder: (context, popupWidget) {
              return Material(
                child: Container(
                  width: 100.w,
                  height: 100.h,
                  color: AppColors.whiteColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                    vertical: 3.h,
                  ),
                  child: popupWidget,
                ),
              );
            },
            title: Text(
              LocaleKeys.home_city_dialog_choose_city.tr(),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontManager.mediumFontWeight,
                color: AppColors.lightTextColor,
              ),
            ),
            dialogProps: DialogProps(
              backgroundColor: AppColors.whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.w),
              ),
              useRootNavigator: true,
            ),
          ),
        );
      },
    );
  }
}
