import 'dart:convert';

import 'package:cinnamon_riverpod_2/infra/http/http_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// use this as means to implement your token
/// token is sometimes recieved from login endpoint, however sometimes when working with firebase
/// you may extract it from FirebaseAuth.instance.currentUser.getIdToken()
final tokenProvider = FutureProvider<String>((ref) async {
  return "Auth Token";
});

class DioHttpService implements HttpService {
  final ProviderRef ref;
  final dio = Dio();

  DioHttpService(this.ref) {
    dio.options.baseUrl = "http://localhost:3000";

    dio.interceptors.add(InterceptorsWrapper(onRequest: (r, h) async {
      final token = await ref.refresh(tokenProvider.future);
      // logger.info("token is $token");
      r.headers["Authorization"] = "Bearer $token";
      return h.next(r);
    }, onResponse: (r, h) {
      if (r.data is String) {
        r.data = jsonDecode(r.data);
      }
      r.data ??= <String, dynamic>{};

      return h.next(r);
    }));
  }

  @override
  Future<T> request<T>(BaseHttpRequest request, {required T Function(Map<String, dynamic> response) converter}) async {
    Map<String, dynamic> value;
    switch (request.type) {
      case RequestType.get:
        value = await _get(request);
      case RequestType.post:
        value = await _post(request);
      case RequestType.patch:
        value = await _patch(request);
    }

    return converter(value);
  }

  Future<Map<String, dynamic>> _post(BaseHttpRequest request) async {
    final resp = await dio.post(request.path, data: await request.toMap());
    return resp.data;
  }

  Future<Map<String, dynamic>> _patch(BaseHttpRequest request) async {
    final resp = await dio.patch(request.path, data: await request.toMap());
    return resp.data;
  }

  Future<Map<String, dynamic>> _get(BaseHttpRequest request) async {
    final resp = await dio.get(request.path, queryParameters: await request.toMap());
    return resp.data;
  }
}
