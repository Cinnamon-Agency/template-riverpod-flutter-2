import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppIcons {
  static const double sizeSmall = 24;
  static const double sizeMedium = 32;

  /// Checks if the icon with a given [path] is in the SVG format.
  static bool isSvg(String path) => path.toLowerCase().contains('svg');

  /// Returns the correct icon `Widget`, depending on the format of the icon with a given [path].
  /// [size] determines the size of the icon, while [color] determines its color (only for SVG icons).
  static Widget icon(
    String path, {
    double size = sizeSmall,
    Color? color,
  }) {
    if (isSvg(path)) {
      return SvgPicture.asset(
        path,
        width: size,
        height: size,
        colorFilter: ColorFilter.mode(color ?? Colors.black, BlendMode.srcIn),
      );
    } else {
      return Image.asset(
        path,
        width: size,
        height: size,
      );
    }
  }
}
