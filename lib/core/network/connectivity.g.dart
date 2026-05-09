// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connectivity.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Tracks the device's perceived internet reachability.
///
/// Replaces the legacy top-level mutable connectivity flag that this
/// codebase used to expose.
///
/// Behavior:
///   1. Optimistically defaults to `true` so the very first request is not
///      blocked while the initial probe resolves.
///   2. Listens to `InternetConnectionChecker.onStatusChange` for live updates
///      and folds them into state.
///   3. Kicks off a one-shot probe on `build()` and writes the result to state.
///
/// Consumers (notably the `ApiInterceptors`) read the current value
/// synchronously via `ref.read(connectivityProvider)`. If the optimistic
/// default turns out to be wrong, the first real request will fail at the
/// transport layer and [FailureMapper] maps it to `Failure.network` — same
/// user-facing behavior, one wasted TCP attempt.
///
/// **No third-party probe is performed.** The legacy
/// `http://clients3.google.com/generate_204` cleartext check is gone:
/// `InternetConnectionChecker` already pings a configurable list of hosts
/// over HTTPS internally.

@ProviderFor(Connectivity)
final connectivityProvider = ConnectivityProvider._();

/// Tracks the device's perceived internet reachability.
///
/// Replaces the legacy top-level mutable connectivity flag that this
/// codebase used to expose.
///
/// Behavior:
///   1. Optimistically defaults to `true` so the very first request is not
///      blocked while the initial probe resolves.
///   2. Listens to `InternetConnectionChecker.onStatusChange` for live updates
///      and folds them into state.
///   3. Kicks off a one-shot probe on `build()` and writes the result to state.
///
/// Consumers (notably the `ApiInterceptors`) read the current value
/// synchronously via `ref.read(connectivityProvider)`. If the optimistic
/// default turns out to be wrong, the first real request will fail at the
/// transport layer and [FailureMapper] maps it to `Failure.network` — same
/// user-facing behavior, one wasted TCP attempt.
///
/// **No third-party probe is performed.** The legacy
/// `http://clients3.google.com/generate_204` cleartext check is gone:
/// `InternetConnectionChecker` already pings a configurable list of hosts
/// over HTTPS internally.
final class ConnectivityProvider extends $NotifierProvider<Connectivity, bool> {
  /// Tracks the device's perceived internet reachability.
  ///
  /// Replaces the legacy top-level mutable connectivity flag that this
  /// codebase used to expose.
  ///
  /// Behavior:
  ///   1. Optimistically defaults to `true` so the very first request is not
  ///      blocked while the initial probe resolves.
  ///   2. Listens to `InternetConnectionChecker.onStatusChange` for live updates
  ///      and folds them into state.
  ///   3. Kicks off a one-shot probe on `build()` and writes the result to state.
  ///
  /// Consumers (notably the `ApiInterceptors`) read the current value
  /// synchronously via `ref.read(connectivityProvider)`. If the optimistic
  /// default turns out to be wrong, the first real request will fail at the
  /// transport layer and [FailureMapper] maps it to `Failure.network` — same
  /// user-facing behavior, one wasted TCP attempt.
  ///
  /// **No third-party probe is performed.** The legacy
  /// `http://clients3.google.com/generate_204` cleartext check is gone:
  /// `InternetConnectionChecker` already pings a configurable list of hosts
  /// over HTTPS internally.
  ConnectivityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'connectivityProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$connectivityHash();

  @$internal
  @override
  Connectivity create() => Connectivity();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$connectivityHash() => r'e6dfc28a001c5b2730c2e225c47661aa60ac55df';

/// Tracks the device's perceived internet reachability.
///
/// Replaces the legacy top-level mutable connectivity flag that this
/// codebase used to expose.
///
/// Behavior:
///   1. Optimistically defaults to `true` so the very first request is not
///      blocked while the initial probe resolves.
///   2. Listens to `InternetConnectionChecker.onStatusChange` for live updates
///      and folds them into state.
///   3. Kicks off a one-shot probe on `build()` and writes the result to state.
///
/// Consumers (notably the `ApiInterceptors`) read the current value
/// synchronously via `ref.read(connectivityProvider)`. If the optimistic
/// default turns out to be wrong, the first real request will fail at the
/// transport layer and [FailureMapper] maps it to `Failure.network` — same
/// user-facing behavior, one wasted TCP attempt.
///
/// **No third-party probe is performed.** The legacy
/// `http://clients3.google.com/generate_204` cleartext check is gone:
/// `InternetConnectionChecker` already pings a configurable list of hosts
/// over HTTPS internally.

abstract class _$Connectivity extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
