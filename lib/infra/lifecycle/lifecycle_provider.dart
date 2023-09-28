import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final lifecycleProvider = StateProvider<AppLifecycleState>((ref) {
  return AppLifecycleState.resumed;
});