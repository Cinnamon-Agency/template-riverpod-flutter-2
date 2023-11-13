extension DurationExt on Duration {
  /// Returns the duration in minutes, rounded up
  int get inCeilMinutes => (inSeconds / 60).ceil();
}
