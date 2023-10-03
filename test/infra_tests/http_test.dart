import 'dart:io';

import 'package:cinnamon_riverpod_2/infra/http/http_service.dart';
import 'package:cinnamon_riverpod_2/infra/storage/hive_storage_service.dart';
import 'package:cinnamon_riverpod_2/infra/storage/storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  late HttpService httpService;

  setUp(() async {
    // Use Riverpod to provide a test instance of storageService.
    final container = ProviderContainer();
    httpService = container.read(httpServiceProvider);

    await httpService.init();
  });

  group("Get Requests", () {
    test("Success", () => null);
    test("Error", () => null);
  });

  group("Post Requests", () {
    test("Success", () => null);
    test("Error", () => null);
  });

  // Add more tests as needed to cover other methods and edge cases.
}
