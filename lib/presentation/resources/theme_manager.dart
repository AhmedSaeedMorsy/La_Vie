import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';

ThemeData getAppTheme() {
  return ThemeData(
    // main color
    primaryColor: ColorManager.primary,
    disabledColor: ColorManager.grey1,
    //app bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: ColorManager.primary,
      elevation: AppSize.s0,
      titleTextStyle: getSemiBoldStyle(
        fontSize: FontSizeManager.s22,
        color: ColorManager.black,
      ),
      iconTheme: IconThemeData(
        color: ColorManager.black,
      ),
    ),

    //text theme
    textTheme: TextTheme(
      bodyMedium: getRegularStyle(
        color: ColorManager.grey1,
        fontSize: FontSizeManager.s18,
      ),
      headlineSmall: getMediumStyle(
        color: ColorManager.black,
        fontSize: FontSizeManager.s12,
      ),
      headlineLarge: getMediumStyle(
        color: ColorManager.black,
        fontSize: FontSizeManager.s16,
      ),
      bodySmall: getRegularStyle(
        color: ColorManager.grey2,
        fontSize: FontSizeManager.s12,
      ),
      displayLarge: getRegularStyle(
        color: ColorManager.grey1,
        fontSize: FontSizeManager.s14,
      ),
      bodyLarge: getSemiBoldStyle(
        color: ColorManager.black,
        fontSize: FontSizeManager.s24,
      ),
      labelMedium: getMediumStyle(
        color: ColorManager.grey2,
        fontSize: FontSizeManager.s14,
      ),
      labelLarge: getMediumStyle(
        color: ColorManager.primary,
        fontSize: FontSizeManager.s16,
      ),
      displayMedium: getMediumStyle(
        color: ColorManager.lightGreen,
        fontSize: FontSizeManager.s16,
      ),
    ),

    // input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
      //content padding
      contentPadding: const EdgeInsets.all(
        AppSize.s8,
      ),
      // hint style
      hintStyle: getRegularStyle(
        color: ColorManager.grey1,
      ),
      // label style
      labelStyle: getMediumStyle(
        color: ColorManager.grey1,
      ),
      //enable style
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.grey1,
          width: AppSize.s1,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            AppSize.s8,
          ),
        ),
      ),
      // focus style
      focusColor: ColorManager.grey1,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.grey1,
          width: AppSize.s1,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            AppSize.s8,
          ),
        ),
      ),
      //error style
      errorStyle: getRegularStyle(
        color: ColorManager.error,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.grey1,
          width: AppSize.s1,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            AppSize.s8,
          ),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.error,
          width: AppSize.s1,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            AppSize.s8,
          ),
        ),
      ),
    ),
  );
}
