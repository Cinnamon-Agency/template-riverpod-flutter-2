import 'dart:io';

import 'package:cinnamon_riverpod_2/infra/storage/hive_storage_service.dart';
import 'package:cinnamon_riverpod_2/infra/storage/storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  late StorageService storageService;
  setUpAll(() {
    var path = Directory.current.path;
    Hive.init(path + '/test/hive_testing_path');
  });
  setUp(() async {
    // Use Riverpod to provide a test instance of storageService.
    final container = ProviderContainer();
    storageService = container.read(localStorageServiceProvider);

    await storageService.init();
  });

  test('Sets and Gets a Value', () async {
    final key = 'testKey';
    final value = 'testValue';

    await storageService.setValue(key: key, data: value);
    final retrievedValue = storageService.getValue(key);

    expect(retrievedValue, equals(value));
  });


  test('Get a non existing value', () async {
    final key = 'non-exiting';

     final retrievedValue = storageService.getValue(key);

    expect(retrievedValue, equals(null));
  });

  test('Deletes a Value', () async {
    final key = 'testKey';
    final value = 'testValue';

    await storageService.setValue(key: key, data: value);
    await storageService.deleteValue(key);

    final retrievedValue = storageService.getValue(key);

    expect(retrievedValue, isNull);
  });

  test('Clears the Box', () async {
    final key1 = 'key1';
    final value1 = 'value1';
    final key2 = 'key2';
    final value2 = 'value2';

    await storageService.setValue(key: key1, data: value1);
    await storageService.setValue(key: key2, data: value2);

    await storageService.clear();

    final retrievedValue1 = storageService.getValue(key1);
    final retrievedValue2 = storageService.getValue(key2);

    expect(retrievedValue1, isNull);
    expect(retrievedValue2, isNull);
  });

  // Add more tests as needed to cover other methods and edge cases.
}
