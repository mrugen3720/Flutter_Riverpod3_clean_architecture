// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Presentation-layer controller for the auth screens.
///
/// Depends only on **domain use cases** and the global [SessionController];
/// never on `data/`, transport types, or the router. Navigation happens
/// declaratively: this notifier flips the session state and the router's
/// `redirect` reacts.
///
/// Holds plain value-class state ([AuthState]); UI controllers are owned by
/// the screen so their `dispose()` lifecycle is sound.

@ProviderFor(AuthNotifier)
final authProvider = AuthNotifierProvider._();

/// Presentation-layer controller for the auth screens.
///
/// Depends only on **domain use cases** and the global [SessionController];
/// never on `data/`, transport types, or the router. Navigation happens
/// declaratively: this notifier flips the session state and the router's
/// `redirect` reacts.
///
/// Holds plain value-class state ([AuthState]); UI controllers are owned by
/// the screen so their `dispose()` lifecycle is sound.
final class AuthNotifierProvider
    extends $NotifierProvider<AuthNotifier, AuthState> {
  /// Presentation-layer controller for the auth screens.
  ///
  /// Depends only on **domain use cases** and the global [SessionController];
  /// never on `data/`, transport types, or the router. Navigation happens
  /// declaratively: this notifier flips the session state and the router's
  /// `redirect` reacts.
  ///
  /// Holds plain value-class state ([AuthState]); UI controllers are owned by
  /// the screen so their `dispose()` lifecycle is sound.
  AuthNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authNotifierHash();

  @$internal
  @override
  AuthNotifier create() => AuthNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthState>(value),
    );
  }
}

String _$authNotifierHash() => r'ebc4e4f05cec70c7232adb61da7c03b6e6acf63c';

/// Presentation-layer controller for the auth screens.
///
/// Depends only on **domain use cases** and the global [SessionController];
/// never on `data/`, transport types, or the router. Navigation happens
/// declaratively: this notifier flips the session state and the router's
/// `redirect` reacts.
///
/// Holds plain value-class state ([AuthState]); UI controllers are owned by
/// the screen so their `dispose()` lifecycle is sound.

abstract class _$AuthNotifier extends $Notifier<AuthState> {
  AuthState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AuthState, AuthState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AuthState, AuthState>,
              AuthState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
