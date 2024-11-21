// import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/core/utilities/app_routes.dart';
import 'core/services/app_prefs.dart';
import 'core/services/services_locator.dart';
import 'core/theme/theme_data/light_them.dart';

class SouqAlgomlahApp extends StatefulWidget {
  const SouqAlgomlahApp({super.key});

  @override
  State<SouqAlgomlahApp> createState() => _SouqAlgomlahAppState();
}

class _SouqAlgomlahAppState extends State<SouqAlgomlahApp> {
  @override
  void initState() {
    // sl<AppPreferences>().init(context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // context.setLocale(Locale(kAppLanguageCode));
    sl<AppPreferences>().init(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // if (Platform.isIOS) {
    //   return CupertinoApp(
    //     debugShowCheckedModeBanner: false,
    //     // title: LocaleKeys.app_name.tr(),
    //     localizationsDelegates: context.localizationDelegates,
    //     supportedLocales: context.supportedLocales,
    //     locale: context.locale,
    //     onGenerateRoute: RoutesManager.onGenerateRoute,
    //     theme: getCupertinoAppLightTheme,
    //     initialRoute: AppRoutes.initialRoute,
    //   );
    // } else {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: LocaleKeys.app_name.tr(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      onGenerateRoute: RoutesManager.onGenerateRoute,
      theme: getMaterialAppLightTheme,
      initialRoute: AppRoutes.initialRoute,
    );
    // }
  }
}
