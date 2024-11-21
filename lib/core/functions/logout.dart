import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '/core/constants/app_constance.dart';
import '/core/network/api_constance.dart';
import '/core/services/app_prefs.dart';
import '/core/services/cart/cart_service.dart';
import '/core/services/favorite/favorite_service.dart';
import '/core/services/services_locator.dart';
import '/core/utilities/app_routes.dart';
import '/core/utilities/extensions.dart';

Future<void> logout(BuildContext context) async {
  /// Clear all shared preferences
  await sl<AppPreferences>().clear();
  await sl<FavoriteService>().dropFavorites();
  await sl<CartService>().dropCart();

  /// Reset all global variables
  kFirstTime = true;
  ApiConstance.token = '';
  kUserId = '';
  kUserName = '';

  /// Navigate to the language route
  if (context.mounted) {
    kAppLanguageCode = context.deviceLocale.languageCode;
    context.setLocale(Locale(kAppLanguageCode));
    sl<AppPreferences>().setAppLanguageCode(kAppLanguageCode);

    context.navigateToNamedWithPopUntil(AppRoutes.languageRoute);
  }
}
