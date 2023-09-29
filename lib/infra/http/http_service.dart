import 'dart:async';

import 'package:cinnamon_riverpod_2/infra/http/dio_http_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final httpServiceProvider = Provider<HttpService>((ref) => DioHttpService(ref));

abstract interface class HttpService {
  Future<void> init();
  Future<T> request<T>(BaseHttpRequest request, {required T Function(Map<String, dynamic> response) converter});
}

Map<String, dynamic> defaultConverter(Map<String, dynamic> map) {
  return map;
}

enum RequestType { get, post, patch }

abstract class BaseHttpRequest {
  final String? url;
  final String endpoint;
  final RequestType type;
  final String contentType;

  String get path {
    if (url != null) return url! + endpoint;
    return endpoint;
  }

  FutureOr<Map<String, dynamic>> toMap();

  const BaseHttpRequest({
    required this.endpoint,
    this.type = RequestType.get,
    this.url,
    this.contentType = Headers.jsonContentType,
  });
}


