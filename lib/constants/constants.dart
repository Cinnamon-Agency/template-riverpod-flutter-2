/// All constants used in the app.
class AppConstants {
  /// User agent package name for use in map tile layers.
  static String mapUserAgent = "cinnamon_riverpod_2";

  /// Regex used for password matching.
  ///
  /// Matches strings that:
  /// - contain at least one lowercase letter
  /// - contain at least one uppercase letter
  /// - contain at least one digit
  /// - are at least 8 characters in length.
  static RegExp passwordRegex = RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$');
}
