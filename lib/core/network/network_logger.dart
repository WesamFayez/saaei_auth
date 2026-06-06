import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class NetworkLogger extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint("------------- REQUEST -------------");
      debugPrint("request: ${options.uri}");
      debugPrint("method: ${options.method}");
      try {
        final headersJson = const JsonEncoder.withIndent('  ').convert(options.headers);
        debugPrint("headers: $headersJson");
      } catch (_) {
        debugPrint("headers: ${options.headers}");
      }
      
      if (options.data != null) {
        try {
          final bodyJson = const JsonEncoder.withIndent('  ').convert(options.data);
          debugPrint("body: $bodyJson");
        } catch (_) {
          debugPrint("body: ${options.data}");
        }
      }
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint("------------- RESPONSE -------------");
      try {
        final prettyJson = const JsonEncoder.withIndent('  ').convert(response.data);
        debugPrint(prettyJson);
      } catch (e) {
        debugPrint("responseData: ${response.data}");
      }
      debugPrint("------------------------------------");
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint("------------- ERROR -------------");
      debugPrint("request: ${err.requestOptions.uri}");
      debugPrint("message: ${err.message}");
      if (err.response?.data != null) {
        try {
          final errorJson = const JsonEncoder.withIndent('  ').convert(err.response?.data);
          debugPrint(errorJson);
        } catch (_) {
          debugPrint("errorResponse: ${err.response?.data}");
        }
      }
      debugPrint("---------------------------------");
    }
    super.onError(err, handler);
  }
}
