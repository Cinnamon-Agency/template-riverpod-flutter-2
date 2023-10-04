import 'package:flutter/material.dart';

abstract class AppColors {
  /// Primary app colors
  Color get primary100;
  Color get primary200;
  Color get primary300;
  Color get primary400;
  Color get primary500;
  Color get primary600;
  Color get primaryDark;

  /// App background color (e.g. for Scaffolds)
  Color get backgroundColor;

  Color get neutralsWhite => const Color(0xFFFFFFFF);
  Color get neutrals100 => const Color(0xFFDFDFDF);
  Color get neutrals200 => const Color(0xFFC1C1C1);
  Color get neutrals300 => const Color(0xFF9A9A9A);
  Color get neutrals400 => const Color(0xFF767676);
  Color get neutrals500 => const Color(0xFF5B5B5B);
  Color get neutrals600 => const Color(0xFF474747);
  Color get neutrals700 => const Color(0xFF3B3B3B);
  Color get neutrals800 => const Color(0xFF313131);
  Color get neutrals900 => const Color(0xFF1E1E1E);
  Color get neutralsBlack => const Color(0xFF000000);

  Color get error;
}
