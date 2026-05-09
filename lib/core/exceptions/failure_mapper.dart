import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'failure.dart';

/// Maps a [DioException] (or any thrown error from the Dio layer) into a
/// typed [Failure]. This is the single canonical place where transport-level
/// errors are translated into domain-visible failures.
class FailureMapper {
  const FailureMapper._();

  static Failure fromDioException(DioException e) {
    if (e.error is Failure) {
      return e.error as Failure;
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const Failure.timeout();
      case DioExceptionType.cancel:
        return const Failure.cancelled();
      case DioExceptionType.connectionError:
        return const Failure.network();
      case DioExceptionType.badCertificate:
        return const Failure.unknown('SSL certificate issue detected.');
      case DioExceptionType.badResponse:
        return _fromBadResponse(e);
      case DioExceptionType.unknown:
        if (e.error is SocketException) return const Failure.network();
        return Failure.unknown(e.message ?? 'Unexpected error');
    }
  }

  static Failure fromError(Object error) {
    if (error is Failure) return error;
    if (error is DioException) return fromDioException(error);
    if (error is SocketException) return const Failure.network();
    return Failure.unknown(error.toString());
  }

  static Failure _fromBadResponse(DioException e) {
    final statusCode = e.response?.statusCode;
    final data = e.response?.data;
    final extracted = _extractMessage(data);

    switch (statusCode) {
      case 400:
        return Failure.server(
          code: 400,
          message: extracted ?? 'Bad request.',
        );
      case 401:
        return Failure.unauthorized(extracted);
      case 403:
        return Failure.forbidden(extracted);
      case 404:
        return Failure.notFound(extracted);
      case 422:
        return Failure.validation(
          _extractValidationErrors(data),
          message: extracted,
        );
      case 426:
        return Failure.forceUpdate(
          extracted ?? 'Please update the app to continue.',
        );
      case 429:
        return const Failure.server(
          code: 429,
          message: 'Too many requests. Please slow down.',
        );
      case 500:
      case 502:
      case 503:
      case 504:
        return Failure.server(code: statusCode, message: extracted);
      default:
        return Failure.server(code: statusCode, message: extracted);
    }
  }

  static String? _extractMessage(dynamic data) {
    try {
      var d = data;
      if (d is String) {
        d = jsonDecode(d);
      }
      if (d is Map) {
        final message = d['message'];
        if (message != null) return message.toString();
        final error = d['error'];
        if (error != null) return error.toString();
        final errors = d['errors'];
        if (errors is Map && errors.isNotEmpty) {
          final first = errors.values.first;
          if (first is List && first.isNotEmpty) return first.first.toString();
          return first.toString();
        }
      }
    } catch (_) {}
    return null;
  }

  static Map<String, List<String>> _extractValidationErrors(dynamic data) {
    try {
      var d = data;
      if (d is String) {
        d = jsonDecode(d);
      }
      if (d is Map && d['errors'] is Map) {
        final result = <String, List<String>>{};
        (d['errors'] as Map).forEach((key, value) {
          if (value is List) {
            result[key.toString()] = value.map((v) => v.toString()).toList();
          } else {
            result[key.toString()] = [value.toString()];
          }
        });
        return result;
      }
    } catch (_) {}
    return const {};
  }
}
