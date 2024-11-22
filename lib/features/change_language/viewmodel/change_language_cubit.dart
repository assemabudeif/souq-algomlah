import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souqalgomlah_app/core/utilities/app_routes.dart';
import 'package:souqalgomlah_app/core/utilities/extensions.dart';
import '/core/enums/languaage_enum.dart';
import '/core/functions/change_app_lang.dart';
import '/core/services/app_prefs.dart';
import '/core/services/services_locator.dart';

part 'change_language_state.dart';

class ChangeLanguageCubit extends Cubit<ChangeLanguageState> {
  ChangeLanguageCubit() : super(ChangeLanguageInitial());

  LanguageEnum selectedLang = sl<AppPreferences>().getAppLanguageCode() == 'ar'
      ? LanguageEnum.arabic
      : LanguageEnum.english;

  void toggleLang(LanguageEnum value) {
    emit(ChangeLanguageInitial());
    selectedLang = value;
    emit(ChangeLanguageFinalState());
  }

  Future<void> changeLanguage({required BuildContext context}) async {
    emit(ChangeLanguageInitial());
    await Future.delayed(const Duration(seconds: 2));

    if (context.mounted) {
      await changeAppLang(langCode: selectedLang.value, context: context)
          .then((value) {
        context.navigateToNamedWithPopUntil(AppRoutes.homeRoute);
        log(context.locale.languageCode, name: 'Locale');
        emit(ChangeLanguageFinalState());
      });
    }
    emit(ChangeLanguageFinalState());
  }

  void onChanged(LanguageEnum? value) {
    toggleLang(value!);
  }
}
