// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Presentation-layer controller for the registration screen.
///
/// Follows the same patterns as [AuthNotifier]:
/// - Depends only on domain validators (no data-layer coupling)
/// - Holds pure value-class state ([RegistrationState])
/// - UI controllers live in the widget's `State`
///
/// Uses a **mock API** that simulates a 2-second network delay. When your
/// real backend is ready, swap the `_submitToApi()` body with a proper use
/// case injected via `ref.read(registerUseCaseProvider)`.

@ProviderFor(RegistrationNotifier)
final registrationProvider = RegistrationNotifierProvider._();

/// Presentation-layer controller for the registration screen.
///
/// Follows the same patterns as [AuthNotifier]:
/// - Depends only on domain validators (no data-layer coupling)
/// - Holds pure value-class state ([RegistrationState])
/// - UI controllers live in the widget's `State`
///
/// Uses a **mock API** that simulates a 2-second network delay. When your
/// real backend is ready, swap the `_submitToApi()` body with a proper use
/// case injected via `ref.read(registerUseCaseProvider)`.
final class RegistrationNotifierProvider
    extends $NotifierProvider<RegistrationNotifier, RegistrationState> {
  /// Presentation-layer controller for the registration screen.
  ///
  /// Follows the same patterns as [AuthNotifier]:
  /// - Depends only on domain validators (no data-layer coupling)
  /// - Holds pure value-class state ([RegistrationState])
  /// - UI controllers live in the widget's `State`
  ///
  /// Uses a **mock API** that simulates a 2-second network delay. When your
  /// real backend is ready, swap the `_submitToApi()` body with a proper use
  /// case injected via `ref.read(registerUseCaseProvider)`.
  RegistrationNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registrationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registrationNotifierHash();

  @$internal
  @override
  RegistrationNotifier create() => RegistrationNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RegistrationState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RegistrationState>(value),
    );
  }
}

String _$registrationNotifierHash() =>
    r'6223d8e5531b392204a29f40fc6d835daef5e99a';

/// Presentation-layer controller for the registration screen.
///
/// Follows the same patterns as [AuthNotifier]:
/// - Depends only on domain validators (no data-layer coupling)
/// - Holds pure value-class state ([RegistrationState])
/// - UI controllers live in the widget's `State`
///
/// Uses a **mock API** that simulates a 2-second network delay. When your
/// real backend is ready, swap the `_submitToApi()` body with a proper use
/// case injected via `ref.read(registerUseCaseProvider)`.

abstract class _$RegistrationNotifier extends $Notifier<RegistrationState> {
  RegistrationState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<RegistrationState, RegistrationState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RegistrationState, RegistrationState>,
              RegistrationState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
