// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logger_util.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// DI handle for widget / notifier code. Tests can override this provider
/// to capture or silence logs.

@ProviderFor(appLogger)
final appLoggerProvider = AppLoggerProvider._();

/// DI handle for widget / notifier code. Tests can override this provider
/// to capture or silence logs.

final class AppLoggerProvider
    extends $FunctionalProvider<AppLogger, AppLogger, AppLogger>
    with $Provider<AppLogger> {
  /// DI handle for widget / notifier code. Tests can override this provider
  /// to capture or silence logs.
  AppLoggerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLoggerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLoggerHash();

  @$internal
  @override
  $ProviderElement<AppLogger> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppLogger create(Ref ref) {
    return appLogger(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppLogger value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppLogger>(value),
    );
  }
}

String _$appLoggerHash() => r'e32c6e2fe49ce970b09ffe3cfcae2c4163a0044e';
