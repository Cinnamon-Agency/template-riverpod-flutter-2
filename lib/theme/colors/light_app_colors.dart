import 'app_colors.dart';
import 'package:flutter/material.dart';

final lightAppColors = LightAppColors();

class LightAppColors extends AppColors {
  @override
  Color get primaryColor => Colors.green.shade300;

  @override
  Color get primaryColorDark => Colors.green.shade900;

  @override
  Color get secondaryColor => Colors.green.shade200;

  @override
  Color get tertiaryColor => Colors.green.shade100;

  @override
  Color get backgroundColor => Colors.white;
}
