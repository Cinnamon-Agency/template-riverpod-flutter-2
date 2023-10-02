import 'package:cinnamon_riverpod_2/theme/colors/dark_app_colors.dart';
import 'package:cinnamon_riverpod_2/theme/colors/light_app_colors.dart';
import 'package:cinnamon_riverpod_2/theme/styles/dark_app_text_styles.dart';
import 'package:cinnamon_riverpod_2/theme/styles/light_app_text_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final appTheme = AppTheme();

class AppTheme {
  final ThemeData lightTheme = ThemeData(
    primaryColor: lightAppColors.primaryColor,
    scaffoldBackgroundColor: lightAppColors.backgroundColor,
    dialogBackgroundColor: Colors.white,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),

    /// BUTTONS
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: lightAppColors.primaryColor,
        foregroundColor: lightAppColors.primaryColorDark,
        disabledBackgroundColor: lightAppColors.neutrals100,
        disabledForegroundColor: lightAppColors.neutrals300,
        textStyle: lightAppTextStyles.primaryButtonTextStyle,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        splashFactory:
            defaultTargetPlatform == TargetPlatform.android ? InkSparkle.splashFactory : NoSplash.splashFactory,
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: lightAppColors.tertiaryColor,
        foregroundColor: lightAppColors.primaryColorDark,
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
    splashColor: lightAppColors.tertiaryColor,

    /// TEXT
    textTheme: TextTheme(
      titleMedium: lightAppTextStyles.titleMediumTextStyle,
      headlineSmall: lightAppTextStyles.headlineSmallTextStyle,
    ),

    /// INPUTS
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelStyle: TextStyle(
        color: lightAppColors.primaryColor,
      ),
      contentPadding: const EdgeInsets.all(20),
      iconColor: lightAppColors.primaryColor,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: darkAppColors.primaryColor,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      filled: true,
      fillColor: lightAppColors.neutralsWhite,
    ),
  );

  final ThemeData darkTheme = ThemeData(
    primaryColor: darkAppColors.primaryColor,
    scaffoldBackgroundColor: darkAppColors.backgroundColor,
    dialogBackgroundColor: Colors.black,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),

    /// BUTTONS
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: darkAppColors.primaryColor,
        foregroundColor: darkAppColors.primaryColorDark,
        disabledBackgroundColor: lightAppColors.neutrals700,
        disabledForegroundColor: lightAppColors.neutrals800,
        textStyle: darkAppTextStyles.primaryButtonTextStyle,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        splashFactory:
            defaultTargetPlatform == TargetPlatform.android ? InkSparkle.splashFactory : NoSplash.splashFactory,
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: darkAppColors.tertiaryColor,
        foregroundColor: darkAppColors.primaryColorDark,
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
    splashColor: darkAppColors.tertiaryColor,

    /// TEXT
    textTheme: TextTheme(
      titleMedium: darkAppTextStyles.titleMediumTextStyle,
      headlineSmall: darkAppTextStyles.headlineSmallTextStyle,
    ),

    /// INPUTS
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelStyle: TextStyle(
        color: lightAppColors.primaryColor,
      ),
      contentPadding: const EdgeInsets.all(20),
      iconColor: lightAppColors.primaryColor,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: darkAppColors.primaryColor,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      filled: true,
      fillColor: lightAppColors.neutralsBlack,
    ),
  );
}
