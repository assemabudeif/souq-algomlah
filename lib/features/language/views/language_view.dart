import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:souqalgomlah_app/core/global/widgets/check_connectivity.dart';
import '/core/data/models/cities_model.dart';
import '/core/services/services_locator.dart';
import '/core/theme/app_color.dart';
import '/core/utilities/font_manager.dart';
import '/features/language/viewmodel/language_cubit.dart';

import '/generated/assets.dart';
import '/generated/locale_keys.g.dart';

import 'widgets/auth_buttons_widget.dart';
import 'widgets/language_continue_button_widget.dart';
import 'widgets/selecte_language_widget.dart';
import 'widgets/shop_as_guest_button_widget.dart';

class LanguageView extends StatefulWidget {
  const LanguageView({super.key});

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  final LanguageCubit _vm = sl<LanguageCubit>();

  @override
  void initState() {
    _vm.getCities(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LanguageCubit>(
      create: (context) => _vm,
      child: BlocConsumer<LanguageCubit, LanguageState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: CheckInternetConnectionView(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                    vertical: 3.h,
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Image.asset(
                          Assets.assetsImagesLogo,
                          height: 8.h,
                        ),
                      ),
                      Gap(3.h),
                      SelectLanguageWidget(vm: _vm),
                      Gap(10.h),
                      AuthButtonsWidget(vm: _vm),
                      Gap(4.h),
                      ShopAsGuestButtonWidget(vm: _vm),
                      Gap(6.h),
                      BlocBuilder<LanguageCubit, LanguageState>(
                        bloc: _vm,
                        builder: (context, state) {
                          return Visibility(
                            visible: _vm.shopAsGuest,
                            child: DropdownSearch<CityModel>(
                              selectedItem: _vm.selectedCity,
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
                                    hintText: LocaleKeys
                                        .home_city_dialog_choose_city
                                        .tr(),
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
                              items: _vm.cities,
                              autoValidateMode: AutovalidateMode.always,
                              enabled: true,
                              compareFn: (item, selectedItem) =>
                                  item == selectedItem,
                              itemAsString: (item) =>
                                  context.locale == const Locale("ar")
                                      ? item.name
                                      : item.englishName,
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
                              onChanged: (CityModel? city) {
                                _vm.selectedCity = city;
                              },
                            ),
                          );
                        },
                      ),
                      Gap(5.h),
                      LanguageContinueButtonWidget(vm: _vm),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
