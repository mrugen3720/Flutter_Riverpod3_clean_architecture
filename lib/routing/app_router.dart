import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../app/splash_screen.dart';
import '../core/session/session_controller.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/registration_screen.dart';
import 'app_routes.dart';

part 'app_router.g.dart';

/// Top-level navigator key. The router and any non-widget surface that
/// needs the current overlay (snackbars, modal bottom sheets) read this
/// directly. Replaces the legacy Riverpod-container and BuildContext globals
/// that this codebase used to expose.
final rootNavigatorKey = GlobalKey<NavigatorState>();

final routeObserver = RouteObserver<ModalRoute<dynamic>>();

/// Bridges Riverpod state changes into a `Listenable` that go_router can
/// watch via `refreshListenable`. Anytime the session state transitions,
/// the router re-evaluates `redirect`.
///
/// [notifyListeners] is deferred via [scheduleMicrotask] so the notification
/// does not fire synchronously during the widget-tree build phase — doing
/// so would trigger "Tried to modify a provider while the widget tree was
/// building" from Riverpod.
class _RouterRefreshNotifier extends ChangeNotifier {
  _RouterRefreshNotifier(Ref ref) {
    ref.listen(
      sessionControllerProvider,
      (_, _) => scheduleMicrotask(notifyListeners),
    );
  }
}

@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  final refresh = _RouterRefreshNotifier(ref);
  ref.onDispose(refresh.dispose);

  final authPaths = <String>{
    AppRoute.signIn.path,
    AppRoute.signUp.path,
    AppRoute.forgotPassword.path,
    AppRoute.resetPassword.path,
    AppRoute.otp.path,
    AppRoute.onBoarding.path,
  };

  return GoRouter(
    observers: [routeObserver],
    initialLocation: AppRoute.splash.path,
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    refreshListenable: refresh,
    redirect: (context, state) {
      final session = ref.read(sessionControllerProvider);
      final loc = state.matchedLocation;
      final isSplash = loc == AppRoute.splash.path;
      final isAuthPath = authPaths.contains(loc);

      return session.when(
        // Bootstrap not yet resolved — pin the user to splash.
        loading: () => isSplash ? null : AppRoute.splash.path,
        // Bootstrap blew up — fall back to sign-in.
        error: (_, _) => isAuthPath ? null : AppRoute.signIn.path,
        data: (status) {
          switch (status) {
            case SessionStatus.loggedIn:
              if (isSplash || isAuthPath) return AppRoute.home.path;
              return null;
            case SessionStatus.loggedOut:
              if (isSplash || !isAuthPath) return AppRoute.signIn.path;
              return null;
          }
        },
      );
    },
    routes: [
      GoRoute(
        path: AppRoute.splash.path,
        name: AppRoute.splash.name,
        pageBuilder: (context, state) =>
            MaterialPage(key: state.pageKey, child: const SplashScreen()),
      ),
      GoRoute(
        path: AppRoute.signIn.path,
        name: AppRoute.signIn.name,
        pageBuilder: (context, state) =>
            MaterialPage(key: state.pageKey, child: const LoginScreen()),
      ),
      GoRoute(
        path: AppRoute.signUp.path,
        name: AppRoute.signUp.name,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const RegistrationScreen(),
        ),
      ),
      GoRoute(
        path: AppRoute.forgotPassword.path,
        name: AppRoute.forgotPassword.name,
        pageBuilder: (context, state) =>
            MaterialPage(key: state.pageKey, child: const Scaffold()),
      ),
      GoRoute(
        path: AppRoute.otp.path,
        name: AppRoute.otp.name,
        pageBuilder: (context, state) =>
            MaterialPage(key: state.pageKey, child: const Scaffold()),
      ),
      GoRoute(
        path: AppRoute.home.path,
        name: AppRoute.home.name,
        pageBuilder: (context, state) =>
            MaterialPage(key: state.pageKey, child: const Scaffold()),
      ),
      GoRoute(
        path: AppRoute.profile.path,
        name: AppRoute.profile.name,
        pageBuilder: (context, state) =>
            MaterialPage(key: state.pageKey, child: const Scaffold()),
      ),
    ],
  );
}
