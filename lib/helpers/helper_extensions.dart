import 'package:cinnamon_riverpod_2/helpers/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension BuildContextExt on BuildContext {
  Size get size => MediaQuery.sizeOf(this);

  ThemeData get theme => Theme.of(this);

  AppLocalizations get localization => AppLocalizations.of(this)!;
}

extension DateTimeExt on DateTime {
  /// Extracts just the date from [this] DateTime.
  DateTime get date => DateTime(year, month, day);

  /// Formats [this] in a `dd.MM.yyyy` format.
  String get dateString => DateFormat("dd.MM.yyyy").format(this);
}

extension DateStringExt on String {
  /// Converts date from String to DateTime
  DateTime get toDateTime => DateFormat('dd.MM.yyyy').parse(this);
}

extension AsyncValueUI on AsyncValue {
  void showSnackbarOnError(BuildContext context) {
    if (!isLoading && hasError) {
      SnackbarHelper.showTFSnackbar(
          context,
          error.toString());
    }
  }
}