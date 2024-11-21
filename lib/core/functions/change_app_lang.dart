import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '/core/constants/app_constance.dart';
import '/core/services/app_prefs.dart';
import '/core/services/services_locator.dart';

Future<void> changeAppLang({
  required String langCode,
  required BuildContext context,
}) async {
  await context.setLocale(Locale(langCode));
  kAppLanguageCode = langCode;
  await sl<AppPreferences>().setAppLanguageCode(langCode);
}
