import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/auth_providers.dart';

part 'session_controller.g.dart';

/// Coarse-grained app-shell auth state. Single source of truth consumed by:
///   - the `goRouter` redirect (declarative gating of protected routes), and
///   - the splash screen (idle until `build()` resolves).
///
/// Notifiers update this controller via [markLoggedIn] / [markLoggedOut]
/// instead of imperatively navigating; the router re-evaluates `redirect`
/// when state changes via the bridged `refreshListenable`.
enum SessionStatus { loggedIn, loggedOut }

@Riverpod(keepAlive: true)
class SessionController extends _$SessionController {
  @override
  Future<SessionStatus> build() async {
    // SharedPreferences is bootstrapped in `main()` and injected via
    // ProviderScope overrides, so by the time anything reads us the
    // storage layer is already warm.
    final session = await ref.read(getSessionUseCaseProvider)();
    return session != null
        ? SessionStatus.loggedIn
        : SessionStatus.loggedOut;
  }

  void markLoggedIn() {
    state = const AsyncData(SessionStatus.loggedIn);
  }

  void markLoggedOut() {
    state = const AsyncData(SessionStatus.loggedOut);
  }
}
