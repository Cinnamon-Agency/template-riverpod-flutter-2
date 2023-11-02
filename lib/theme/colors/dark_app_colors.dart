import 'package:flutter/material.dart';
import 'package:cinnamon_riverpod_2/theme/colors/app_colors.dart';

final darkAppColors = DarkAppColors();

class DarkAppColors extends AppColors {
  @override
  Color get primary100 => const Color(0xFF487541);

  @override
  Color get primary200 => const Color(0xFF5c8454);

  @override
  Color get primary300 => const Color(0xFF6f9268);

  @override
  Color get primary400 => const Color(0xFF83a17c);

  @override
  Color get primary500 => const Color(0xFF97b191);

  @override
  Color get primary600 => const Color(0xFFabc0a6);

  @override
  Color get primaryDark => Colors.green.shade900;

  @override
  Color get backgroundColor => const Color(0xFF111211);

  @override
  Color get error => const Color(0xFFcb4154);
}
