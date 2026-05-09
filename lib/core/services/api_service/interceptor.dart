import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../env/env.dart';
import '../../exceptions/failure.dart';
import '../../exceptions/failure_mapper.dart';
import '../../utils/logger_util.dart';
import 'log_redactor.dart';

/// Async signature for retrieving the current bearer token. Provided via
/// `SecureTokenStorage` in the Riverpod graph so the interceptor never reads
/// secrets from a global singleton.
typedef TokenReader = Future<String?> Function();

/// Synchronous read of the latest known device connectivity. Provided via
/// `connectivityProvider` so the interceptor never reads from a global mutable.
typedef ConnectivityCheck = bool Function();

/// Transport-layer interceptor.
///
/// Responsibilities:
/// 1. Inject auth + content headers (token sourced via [tokenReader]).
/// 2. Short-circuit when offline by rejecting with a typed [Failure.network].
/// 3. Map every [DioException] to a typed [Failure] and forward it via
///    [ErrorInterceptorHandler.next] so callers can pattern-match.
/// 4. Emit redacted, debug-only logs for request / response / error.
///
/// 401 surfaces as [Failure.unauthorized]; the auth notifier observes that
/// failure and asks the global session controller to log the user out, at
/// which point the router's `redirect` handles navigation declaratively.
class ApiInterceptors extends InterceptorsWrapper {
  ApiInterceptors({
    required this.tokenReader,
    required this.connectivityCheck,
  });

  final TokenReader tokenReader;
  final ConnectivityCheck connectivityCheck;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!connectivityCheck()) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: const Failure.network(),
          type: DioExceptionType.connectionError,
        ),
      );
    }

    options.headers['Accept'] = 'application/json';
    final token = await tokenReader();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['KEY'] = Env.apiKey;

    _logRequest(options);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    _logResponse(response);
    super.onResponse(response, handler);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    _logError(err);
    final failure = FailureMapper.fromDioException(err);
    handler.next(err.copyWith(error: failure));
  }

  // ───────────────────────── logging (debug-only, redacted) ─────────────────

  void _logRequest(RequestOptions options) {
    if (!kDebugMode) return;
    final headers = LogRedactor.redactHeaders(
      Map<String, dynamic>.from(options.headers),
    );
    final method = options.method;
    final uri = options.uri;

    if (method == 'GET') {
      logger.d('REQUEST[$method] => PATH: $uri\n HEADERS: $headers');
      return;
    }

    try {
      final body = LogRedactor.redactBody(options.data);
      final encoded = body is String ? body : jsonEncode(body);
      logger.d(
        'REQUEST[$method] => PATH: $uri\n HEADERS: $headers\n DATA: $encoded',
      );
    } catch (_) {
      logger.d(
        'REQUEST[$method] => PATH: $uri\n HEADERS: $headers\n DATA: <unserializable>',
      );
    }
  }

  void _logResponse(Response response) {
    if (!kDebugMode) return;
    try {
      final body = LogRedactor.redactBody(response.data);
      final encoded = body is String ? body : jsonEncode(body);
      logger.d(
        'RESPONSE[${response.statusCode}] => '
        'PATH: ${response.requestOptions.uri}\n DATA: $encoded',
      );
    } catch (_) {
      logger.d(
        'RESPONSE[${response.statusCode}] => '
        'PATH: ${response.requestOptions.uri}',
      );
    }
  }

  void _logError(DioException err) {
    if (!kDebugMode) return;
    final statusCode = err.response?.statusCode;
    final uri = err.requestOptions.uri;
    var dataStr = '';
    try {
      final data = LogRedactor.redactBody(err.response?.data);
      dataStr = data is String ? data : jsonEncode(data);
    } catch (_) {}
    logger.e('ERROR[$statusCode] => PATH: $uri\n DATA: $dataStr');
  }
}
