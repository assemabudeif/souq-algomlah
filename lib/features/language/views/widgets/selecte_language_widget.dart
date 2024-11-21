import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/enums/languaage_enum.dart';
import '/features/language/viewmodel/language_cubit.dart';

import 'select_language_item_widget.dart';

class SelectLanguageWidget extends StatelessWidget {
  const SelectLanguageWidget({
    super.key,
    required LanguageCubit vm,
  }) : _vm = vm;

  final LanguageCubit _vm;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      bloc: _vm,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SelectLanguageItemWidget(
              title: 'اختر اللغة',
              languageName: 'العربية',
              value: LanguageEnum.arabic,
              onChanged: (value) {
                _vm.changeLanguage(
                  languageCode: value,
                  context: context,
                );
              },
              selected: _vm.selectedLanguage == LanguageEnum.arabic,
            ),
            SelectLanguageItemWidget(
              title: 'Select Language',
              languageName: 'English',
              value: LanguageEnum.english,
              onChanged: (value) {
                _vm.changeLanguage(
                  languageCode: value,
                  context: context,
                );
              },
              selected: _vm.selectedLanguage == LanguageEnum.english,
            ),
          ],
        );
      },
    );
  }
}
