import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connectivity.g.dart';

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
@Riverpod(keepAlive: true)
class Connectivity extends _$Connectivity {
  @override
  bool build() {
    final subscription =
        InternetConnectionChecker.instance.onStatusChange.listen(
      (status) {
        state = status == InternetConnectionStatus.connected;
      },
    );

    // Fire-and-forget initial probe; folds into state on resolution.
    InternetConnectionChecker.instance.hasConnection.then(
      (connected) => state = connected,
    );

    ref.onDispose(subscription.cancel);
    return true;
  }
}
