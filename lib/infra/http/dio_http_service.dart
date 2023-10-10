import 'dart:convert';

import 'package:cinnamon_riverpod_2/infra/http/http_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// use this as means to implement your token
/// token is sometimes recieved from login endpoint, however sometimes when working with firebase
/// you may extract it from FirebaseAuth.instance.currentUser.getIdToken()
///
/// when used in [DioHttpService] this value is refreshed so you may add logic to check if its expired before use
final tokenProvider = FutureProvider<String>((ref) async {

  return "Auth Token";
});

final class DioHttpService implements HttpService {
  final ProviderRef ref;
  final dio = Dio();

  DioHttpService(this.ref);

  @override
  Future<void> init() async {
    dio.options.baseUrl = "http://localhost:3000";

    dio.interceptors.add(InterceptorsWrapper(onRequest: (r, h) async {
      // notice the use of refresh here
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
  Future<T> request<T>(BaseHttpRequest request,
      {required T Function(Map<String, dynamic> response) transformer}) async {
    Map<String, dynamic> value;
    switch (request.type) {
      case RequestType.get:
        value = await _get(request);
      case RequestType.post:
        value = await _post(request);
      case RequestType.patch:
        value = await _patch(request);
    }

    return transformer(value);
  }

  Future<Map<String, dynamic>> _post(BaseHttpRequest request) async {
    final resp =
        await dio.post(request.path, data: await request.toMap(), options: Options(contentType: request.contentType));
    return resp.data;
  }

  Future<Map<String, dynamic>> _patch(BaseHttpRequest request) async {
    final resp =
        await dio.patch(request.path, data: await request.toMap(), options: Options(contentType: request.contentType));
    return resp.data;
  }

  Future<Map<String, dynamic>> _get(BaseHttpRequest request) async {
    final resp = await dio.get(request.path,
        queryParameters: await request.toMap(), options: Options(contentType: request.contentType));
    return resp.data;
  }
}
