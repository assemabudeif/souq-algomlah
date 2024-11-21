import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/core/services/cart/models/cart_item_model.dart';
import '/core/services/favorite/models/favorite_model.dart';
import '/core/services/favorite/models/hive_product_model.dart';
import '/core/services/notifications_service.dart';
import '/core/utilities/bloc_observer.dart';

import 'app.dart';
import 'core/services/services_locator.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ServicesLocator().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await NotificationsService.initialize();
  Bloc.observer = AppBlocObserver();

  if (!Platform.isIOS) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  await Hive.initFlutter();
  Hive.registerAdapter(HiveProductModelAdapter());
  Hive.registerAdapter(FavoriteModelAdapter());
  Hive.registerAdapter(CartItemModelAdapter());
  await Hive.openBox<FavoriteModel>('favorites');
  await Hive.openBox<CartItemModel>('cart');

  log("FCM Token: ${await NotificationsService.getFCMToken()}");

  runApp(
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (_) =>
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      fallbackLocale: const Locale('ar'),
      assetLoader: const JsonAssetLoader(),
      child: ResponsiveSizer(
        maxMobileWidth: 450,
        maxTabletWidth: 1024,
        builder: (context, orientation, deviceType) {
          return const SouqAlgomlahApp();
        },
      ),
    ),
    // ),
  );
}
