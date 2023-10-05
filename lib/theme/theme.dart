import 'package:cinnamon_riverpod_2/gen/fonts.gen.dart';
import 'package:cinnamon_riverpod_2/theme/colors/dark_app_colors.dart';
import 'package:cinnamon_riverpod_2/theme/colors/light_app_colors.dart';
import 'package:cinnamon_riverpod_2/theme/styles/dark_app_text_styles.dart';
import 'package:cinnamon_riverpod_2/theme/styles/light_app_text_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final appTheme = AppTheme();

class AppTheme {
    ThemeData get lightTheme => ThemeData(
    fontFamily: FontFamily.manrope,

    primaryColor: lightAppColors.primary100,
    scaffoldBackgroundColor: lightAppColors.backgroundColor,
    dialogBackgroundColor: Colors.white,

    /// TRANSITION
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),

    /// BUTTONS
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: lightAppColors.primary100,
        foregroundColor: lightAppColors.primaryDark,
        disabledBackgroundColor: lightAppColors.primary600,
        disabledForegroundColor: lightAppColors.neutralsWhite,
        textStyle: lightAppTextStyles.primaryButtonTextStyle,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        splashFactory:
            defaultTargetPlatform == TargetPlatform.android ? InkSparkle.splashFactory : NoSplash.splashFactory,
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: lightAppColors.primary500,
        foregroundColor: lightAppColors.primaryDark,
        disabledBackgroundColor: lightAppColors.neutrals700,
        disabledForegroundColor: lightAppColors.neutrals800,
        textStyle: darkAppTextStyles.primaryButtonTextStyle,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        splashFactory:
            defaultTargetPlatform == TargetPlatform.android ? InkSparkle.splashFactory : NoSplash.splashFactory,
      ),
    ),

    /// SPLASHES
    splashFactory: defaultTargetPlatform == TargetPlatform.android ? InkSparkle.splashFactory : NoSplash.splashFactory,
    splashColor: lightAppColors.primary300,

    /// TEXT
    textTheme: TextTheme(
      titleMedium: lightAppTextStyles.titleMediumTextStyle,
      headlineLarge: lightAppTextStyles.headlineLargeTextStyle,
      headlineSmall: lightAppTextStyles.headlineSmallTextStyle,
      bodyLarge: lightAppTextStyles.bodyLargeTextStyle,
      bodyMedium: lightAppTextStyles.bodyMediumTextStyle,
      bodySmall: lightAppTextStyles.bodySmallTextStyle,
      labelMedium: lightAppTextStyles.labelMediumTextStyle,
    ),

    /// INPUTS
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelStyle: TextStyle(
        color: lightAppColors.primary100,
      ),
      hintStyle: TextStyle(color: darkAppColors.backgroundColor),
      labelStyle: TextStyle(color: darkAppColors.backgroundColor),
      contentPadding: const EdgeInsets.all(20),
      iconColor: lightAppColors.primary100,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: darkAppColors.primary100,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: lightAppColors.error,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: lightAppColors.error,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      errorStyle: TextStyle(color: lightAppColors.error),
      filled: true,
      fillColor: lightAppColors.neutralsWhite,
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: lightAppColors.primary100,
    ),

    /// SNACKBAR
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: lightAppColors.primaryDark,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      contentTextStyle: lightAppTextStyles.bodyMediumTextStyle.copyWith(color: lightAppColors.neutralsWhite),
    ),
  );

    ThemeData get darkTheme => ThemeData(
    fontFamily: FontFamily.manrope,

    primaryColor: darkAppColors.primary100,
    scaffoldBackgroundColor: darkAppColors.backgroundColor,
    dialogBackgroundColor: Colors.black,

    /// TRANSITION
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),

    /// BUTTONS
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: darkAppColors.primary100,
        foregroundColor: darkAppColors.neutralsWhite,
        disabledBackgroundColor: lightAppColors.primary300,
        disabledForegroundColor: lightAppColors.primary600,
        textStyle: darkAppTextStyles.primaryButtonTextStyle,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        splashFactory:
            defaultTargetPlatform == TargetPlatform.android ? InkSparkle.splashFactory : NoSplash.splashFactory,
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: darkAppColors.primary300,
        foregroundColor: darkAppColors.neutralsWhite,
        disabledBackgroundColor: lightAppColors.neutrals700,
        disabledForegroundColor: lightAppColors.neutrals800,
        textStyle: darkAppTextStyles.primaryButtonTextStyle,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        splashFactory:
            defaultTargetPlatform == TargetPlatform.android ? InkSparkle.splashFactory : NoSplash.splashFactory,
      ),
    ),

    /// SPLASHES
    splashFactory: defaultTargetPlatform == TargetPlatform.android ? InkSparkle.splashFactory : NoSplash.splashFactory,
    splashColor: darkAppColors.primary300,

    /// TEXT
    textTheme: TextTheme(
      titleMedium: darkAppTextStyles.titleMediumTextStyle,
      headlineLarge: darkAppTextStyles.headlineLargeTextStyle,
      headlineSmall: darkAppTextStyles.headlineSmallTextStyle,
      bodyLarge: darkAppTextStyles.bodyLargeTextStyle,
      bodyMedium: darkAppTextStyles.bodyMediumTextStyle,
      bodySmall: darkAppTextStyles.bodySmallTextStyle,
      labelMedium: darkAppTextStyles.labelMediumTextStyle,
    ),

    /// INPUTS
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelStyle: TextStyle(
        color: lightAppColors.primary100,
      ),
      hintStyle: TextStyle(color: lightAppColors.backgroundColor),
      labelStyle: TextStyle(color: lightAppColors.backgroundColor),
      contentPadding: const EdgeInsets.all(20),
      iconColor: lightAppColors.primary100,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: darkAppColors.primary100,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: darkAppColors.error,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: darkAppColors.error,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      errorStyle: TextStyle(color: darkAppColors.error),
      filled: true,
      fillColor: lightAppColors.neutrals900,
    ),

    /// SNACKBAR
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: darkAppColors.primary600,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      contentTextStyle: lightAppTextStyles.bodyMediumTextStyle,
    ),
  );
}
