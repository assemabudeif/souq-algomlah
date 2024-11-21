import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/core/theme/app_color.dart';
import '/core/theme/text_style.dart';
import '/core/utilities/font_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

ThemeData get getMaterialAppLightTheme => ThemeData(
      /// Define the default brightness and colors.
      primarySwatch: AppColors.primarySwatchColor,
      primaryColor: AppColors.primary,
      fontFamily: FontManager.defaultFontFamily,
      scaffoldBackgroundColor: AppColors.secondBackgroundColor,
      colorScheme: ThemeData.light().colorScheme.copyWith(
            primary: AppColors.primary,
          ),

      /// Define the default app bar theme.
      appBarTheme: ThemeData.light().appBarTheme.copyWith(
            backgroundColor: AppColors.backgroundColor,
            centerTitle: false,
            foregroundColor: AppColors.backgroundColor,
            surfaceTintColor: AppColors.backgroundColor,
            titleTextStyle: getBoldStyle.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.blackColor,
              fontFamily: FontManager.defaultFontFamily,
            ),
            elevation: 0,
            iconTheme: ThemeData.light().iconTheme.copyWith(
                  color: AppColors.blackColor,
                ),
          ),

      /// Define the default text form field theme.
      textSelectionTheme: ThemeData.light().textSelectionTheme.copyWith(
            cursorColor: AppColors.primary,
            selectionColor: AppColors.primary,
            selectionHandleColor: AppColors.primary,
          ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: getRegularStyle.copyWith(
          fontSize: 16.sp,
          color: AppColors.blackWithOpacityColor,
        ),
        labelStyle: getRegularStyle.copyWith(
          fontSize: 15.sp,
          color: AppColors.blackColor,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(100.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.borderColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(100.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.dangerColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(100.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.dangerColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(100.0),
        ),
        filled: true,
        fillColor: AppColors.textFormFieldFilledColor,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          vertical: 1.5.h,
          horizontal: 6.w,
        ),
      ),

      /// Define the default elevated button theme.
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          surfaceTintColor: AppColors.primary,
          foregroundColor: AppColors.whiteColor,
          fixedSize: Size(100.w, 6.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.w),
          ),
          textStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontManager.mediumFontWeight,
            color: AppColors.whiteColor,
            fontFamily: FontManager.defaultFontFamily,
          ),
        ),
      ),
      cardColor: AppColors.whiteColor,
      cardTheme: CardTheme(
        color: AppColors.whiteColor,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1.w),
        ),
        surfaceTintColor: AppColors.whiteColor,
      ),
    );

CupertinoThemeData get getCupertinoAppLightTheme => const CupertinoThemeData(
      applyThemeToAll: true,
      barBackgroundColor: AppColors.backgroundColor,
      primaryColor: AppColors.primary,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.backgroundColor,
    );
