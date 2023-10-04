import 'package:flutter/material.dart';

/// Helper class for management of snackbars.
class SnackbarHelper {
  /// Shows a basic snackbar with [message].
  ///
  /// Optionally, a custom [duration] can be set.
  /// Snackbar theme is defined in app's `ThemeData`.
  static void showTFSnackbar(BuildContext context, String message, {int duration = 2000}) {
    // Hide the currently active snackbar, if it exists
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final snackbar = SnackBar(
      content: Text(message),
      padding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      dismissDirection: DismissDirection.horizontal,
      behavior: SnackBarBehavior.floating,
      duration: Duration(milliseconds: duration),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
