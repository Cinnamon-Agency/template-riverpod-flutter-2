import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension BuildContextExt on BuildContext {
  Size get size => MediaQuery.sizeOf(this);

  ThemeData get theme => Theme.of(this);
}

extension DateTimeExt on DateTime {
  /// Extracts just the date from [this] DateTime.
  DateTime get date => DateTime(year, month, day);

  /// Formats [this] in a `dd.MM.yyyy.` format.
  String get dateString => DateFormat("dd.MM.yyyy.").format(this);
}
