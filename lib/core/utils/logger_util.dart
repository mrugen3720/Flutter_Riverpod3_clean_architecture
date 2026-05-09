import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logger_util.g.dart';

/// App-wide logging facade.
///
/// In debug builds writes to `dart:developer.log` (visible in IDE consoles).
/// In release builds writes to a single cached `package:logger` instance —
/// no per-call construction.
class AppLogger {
  AppLogger._();

  static final AppLogger _instance = AppLogger._();
  static AppLogger get instance => _instance;

  static final Logger _release = Logger(
    filter: _AlwaysLogFilter(),
    printer: PrettyPrinter(),
  );

  void v(Object? message) => _log(' VERBOSE: $message');
  void d(Object? message) => _log(' DEBUG: $message');
  void i(Object? message) => _log(' INFO: $message');
  void w(Object? message) => _log(' WARNING: $message');

  void e(Object? message, {StackTrace? stackTrace}) {
    _log(' ERROR: $message', stackTrace: stackTrace);
  }

  void log(Object? message, {StackTrace? stackTrace}) {
    _log(message, stackTrace: stackTrace);
  }

  void _log(Object? message, {StackTrace? stackTrace}) {
    final timestamped = '$message , -- ${DateTime.now()}';
    if (kDebugMode) {
      developer.log(
        timestamped,
        stackTrace: stackTrace,
        time: DateTime.now(),
      );
    } else {
      _release.w(timestamped, stackTrace: stackTrace, time: DateTime.now());
    }
  }
}

class _AlwaysLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) => true;
}

/// Back-compat top-level handle. Used by transport-layer files that have no
/// `Ref` (interceptors, mappers) and by legacy notifiers that haven't yet
/// migrated to [appLoggerProvider]. Resolves to the same singleton.
// ignore: non_constant_identifier_names
final AppLogger logger = AppLogger.instance;

/// DI handle for widget / notifier code. Tests can override this provider
/// to capture or silence logs.
@Riverpod(keepAlive: true)
AppLogger appLogger(Ref ref) => AppLogger.instance;
