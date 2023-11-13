import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'hive_storage_service.dart';

/// Static class for defining keys for storing values
class LocalStorageKeys {
  static String tripTimer(String tripId) => 'tripTimer_$tripId';
}

final localStorageServiceProvider = Provider<LocalStorageService>(
  (_) => HiveStorageService(),
);

/// Abstract class defining [LocalStorageService] structure
abstract class LocalStorageService {
  Future<void> init();

  /// Delete value by key
  Future<void> deleteValue(String key);

  /// Get value by key
  String? getValue(String key);

  /// Clear storage
  Future<void> clear();

  /// Store new value
  Future<void> setValue({required String key, required String? data});
}
