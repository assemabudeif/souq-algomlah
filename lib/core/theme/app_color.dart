import 'package:flutter/material.dart';
import '/core/functions/build_material_color.dart';

class AppColors {
  static const Color primary = Color(0xFFf36e21);
  static const lightPrimary = Color(0xFFfef1e0);
  static const backgroundColor = Color(0xFFffffff);
  static const secondBackgroundColor = Color(0xFFf7f7f7);
  static const blackColor = Color(0xFF000000);
  static const lightTextColor = Color(0xFF535353);
  static final blackWithOpacityColor = const Color(0xFF000000).withOpacity(0.5);
  static const whiteColor = Color(0xFFFFFFFF);
  static const greyColor = Color(0xFF9A9A9D);
  static const textFormFieldFilledColor = Color(0xFFFFFFFF);
  static const lightGreyColor = Color(0xFFf7f7f7);
  static const borderColor = Color(0xFFdbdbdb);

  static MaterialColor primarySwatchColor = buildMaterialColor(primary);

  static const Color transparentColor = Colors.transparent;
  static const Color dangerColor = Colors.red;
  static const Color warningColor = Color(0xffffcc00);
  static const LinearGradient loginButtonGradientColor = LinearGradient(
    begin: AlignmentDirectional.centerStart,
    end: AlignmentDirectional.centerEnd,
    colors: [
      primary,
      Color(0xFFfdc896),
    ],
  );

  static const Color hintColor = Color(0xffaeaeae);
  static const Color privacyTextColor = Color(0xff5a5b78);
  static const Color lightButtonColor = Color(0xffd9d9d9);

  static const Color successColor = Color(0xff4caf50);
  static const Color availableColor = Color(0xff9fcfa7);
  static const Color availableBackgroundColor = Color(0xffc2e5c7);

  static const Color notAvailableColor = dangerColor;
  static const Color notAvailableBackgroundColor = Color(0xfff0d9d9);

  static const Color whatsappColor = Color(0xff25d366);

  static const Color emailColor = Color(0xff0077b5);
}
