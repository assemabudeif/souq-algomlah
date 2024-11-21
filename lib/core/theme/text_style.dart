import '/core/theme/app_color.dart';
import '/core/utilities/font_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:flutter/material.dart';

TextStyle _getTextStyle({
  Color? color,
  double? fontSize,
  FontWeight? fontWeight = FontWeight.normal,
  FontStyle fontStyle = FontStyle.normal,
}) {
  return TextStyle(
    color: color ?? AppColors.blackColor,
    fontSize: fontSize ?? 16.sp,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    overflow: TextOverflow.ellipsis,
  );
}

TextStyle get getBoldStyle {
  return _getTextStyle(
    fontWeight: FontManager.boldFontWeight,
    fontSize: 25.sp,
    color: AppColors.blackColor,
  );
}

TextStyle get getSemiBoldStyle {
  return _getTextStyle(
    fontWeight: FontManager.semiBoldFontWeight,
    fontSize: 18.sp,
    color: AppColors.blackColor,
  );
}

TextStyle get getMediumStyle {
  return _getTextStyle(
    fontWeight: FontManager.mediumFontWeight,
    fontSize: 16.sp,
    color: AppColors.blackColor,
  );
}

TextStyle get getRegularStyle {
  return _getTextStyle(
    fontWeight: FontManager.regularFontWeight,
    fontSize: 14.sp,
    color: AppColors.blackColor,
  );
}

TextStyle get getLightStyle {
  return _getTextStyle(
    fontWeight: FontManager.lightFontWeight,
    fontSize: 12.sp,
    color: AppColors.blackColor,
  );
}
