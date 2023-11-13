import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';

import './storage_service.dart';

/// Implementation of [LocalStorageService] with [Hive]
final class HiveStorageService extends LocalStorageService {
  late Box<dynamic> hiveBox;

  @override
  Future<void> init() async {
    if (Platform.isAndroid || Platform.isIOS) await Hive.initFlutter();

    return _openBox('box');
  }

  Future<void> _openBox(String boxName) async {
    hiveBox = await Hive.openBox(boxName);
  }

  Future<void> closeBox() async => hiveBox.close();

  @override
  Future<void> deleteValue(String key) async => hiveBox.delete(key);

  @override
  String? getValue(String key) => hiveBox.get(key) as String?;

  @override
  Future<void> setValue({required String key, required String? data}) async => hiveBox.put(key, data);

  @override
  Future<void> clear() async => hiveBox.clear();
}
