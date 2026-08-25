import 'package:dio/dio.dart';

/// Simple in-memory response cache keyed by URL.
///
/// Only **GET** requests are cached. POST/PUT/DELETE are never cached: their
/// bodies vary per call (e.g. each image generation sends a different photo),
/// so returning a cached response by URL alone would hand back a stale result.
class CacheInterceptor extends Interceptor {
  final Map<String, Response> _cache = {};

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.method == 'GET') {
      final cached = _cache[options.uri.toString()];
      if (cached != null) {
        handler.resolve(cached);
        return;
      }
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.requestOptions.method == 'GET') {
      _cache[response.requestOptions.uri.toString()] = response;
    }
    handler.next(response);
  }
}
