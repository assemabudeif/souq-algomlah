import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/core/enums/languaage_enum.dart';
import '/core/global/widgets/custom_loading_button.dart';
import '/core/services/services_locator.dart';
import '/core/theme/app_color.dart';
import '/features/change_language/viewmodel/change_language_cubit.dart';
import '/generated/locale_keys.g.dart';

class ChangeLanguageView extends StatefulWidget {
  const ChangeLanguageView({super.key});

  @override
  State<ChangeLanguageView> createState() => _ChangeLanguageViewState();
}

class _ChangeLanguageViewState extends State<ChangeLanguageView> {
  final _vm = sl<ChangeLanguageCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangeLanguageCubit>(
      create: (context) => _vm,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            LocaleKeys.home_drawer_change_language.tr(),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 2.h,
          ),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<ChangeLanguageCubit, ChangeLanguageState>(
                  bloc: _vm,
                  builder: (context, state) {
                    return Column(
                      children: [
                        RadioListTile(
                          title: Text(
                            'العربية',
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: _vm.selectedLang == LanguageEnum.arabic
                                  ? AppColors.primary
                                  : AppColors.blackColor,
                            ),
                          ),
                          value: LanguageEnum.arabic,
                          groupValue: _vm.selectedLang,
                          onChanged: _vm.onChanged,
                        ),
                        Gap(1.h),
                        RadioListTile(
                          title: Text(
                            'English',
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: _vm.selectedLang == LanguageEnum.english
                                  ? AppColors.primary
                                  : AppColors.blackColor,
                            ),
                          ),
                          value: LanguageEnum.english,
                          groupValue: _vm.selectedLang,
                          onChanged: _vm.onChanged,
                        ),
                      ],
                    );
                  },
                ),
              ),
              BlocBuilder<ChangeLanguageCubit, ChangeLanguageState>(
                bloc: _vm,
                builder: (context, state) {
                  return CustomLoadingButton(
                    onPressed: () {
                      return _vm.changeLanguage(context: context);
                    },
                    text: LocaleKeys.general_save.tr(),
                  );
                },
              ),
              Gap(3.h),
            ],
          ),
        ),
      ),
    );
  }
}
