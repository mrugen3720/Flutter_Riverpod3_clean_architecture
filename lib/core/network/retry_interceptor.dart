import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Bounded retry for **idempotent** transport failures.
///
/// Strategy:
/// - Max 3 attempts total (1 original + 2 retries).
/// - Exponential backoff: 200ms, 400ms.
/// - Only retries `GET` requests on transient transport errors
///   (connection / timeout / 5xx). `POST/PUT/PATCH/DELETE` are NEVER retried
///   automatically — those calls may have side effects, so duplicate delivery
///   is treated as a UX concern (the user re-taps).
///
/// Replaces the unbounded `onNoInternet: () => callLoginApi()` recursion that
/// existed in the old notifier.
class RetryInterceptor extends Interceptor {
  RetryInterceptor(this._dio, {this.maxAttempts = 3});

  final Dio _dio;
  final int maxAttempts;

  static const _attemptKey = '__app_retry_attempt__';

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    final attempt = (options.extra[_attemptKey] as int?) ?? 0;

    if (!_shouldRetry(err, options) || attempt + 1 >= maxAttempts) {
      return handler.next(err);
    }

    final delay = Duration(milliseconds: 200 * (1 << attempt));
    if (kDebugMode) {
      debugPrint(
        'RetryInterceptor: ${options.method} ${options.uri} '
        'attempt ${attempt + 2}/$maxAttempts in ${delay.inMilliseconds}ms',
      );
    }
    await Future<void>.delayed(delay);

    options.extra[_attemptKey] = attempt + 1;

    try {
      final response = await _dio.fetch<dynamic>(options);
      return handler.resolve(response);
    } on DioException catch (e) {
      return handler.next(e);
    }
  }

  bool _shouldRetry(DioException err, RequestOptions options) {
    if (options.method.toUpperCase() != 'GET') return false;
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return true;
      case DioExceptionType.badResponse:
        final code = err.response?.statusCode ?? 0;
        return code >= 500;
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return false;
    }
  }
}
