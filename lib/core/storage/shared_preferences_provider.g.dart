// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_preferences_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Synchronous handle to [SharedPreferences].
///
/// The provider deliberately throws if accessed without an override —
/// `main()` is responsible for awaiting `SharedPreferences.getInstance()`
/// before `runApp` and overriding this provider via
/// `ProviderScope(overrides: [sharedPreferencesProvider.overrideWithValue(...)])`.
///
/// This is the canonical Riverpod pattern for async-init dependencies that
/// downstream providers want to consume synchronously.

@ProviderFor(sharedPreferences)
final sharedPreferencesProvider = SharedPreferencesProvider._();

/// Synchronous handle to [SharedPreferences].
///
/// The provider deliberately throws if accessed without an override —
/// `main()` is responsible for awaiting `SharedPreferences.getInstance()`
/// before `runApp` and overriding this provider via
/// `ProviderScope(overrides: [sharedPreferencesProvider.overrideWithValue(...)])`.
///
/// This is the canonical Riverpod pattern for async-init dependencies that
/// downstream providers want to consume synchronously.

final class SharedPreferencesProvider
    extends
        $FunctionalProvider<
          SharedPreferences,
          SharedPreferences,
          SharedPreferences
        >
    with $Provider<SharedPreferences> {
  /// Synchronous handle to [SharedPreferences].
  ///
  /// The provider deliberately throws if accessed without an override —
  /// `main()` is responsible for awaiting `SharedPreferences.getInstance()`
  /// before `runApp` and overriding this provider via
  /// `ProviderScope(overrides: [sharedPreferencesProvider.overrideWithValue(...)])`.
  ///
  /// This is the canonical Riverpod pattern for async-init dependencies that
  /// downstream providers want to consume synchronously.
  SharedPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedPreferencesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedPreferencesHash();

  @$internal
  @override
  $ProviderElement<SharedPreferences> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SharedPreferences create(Ref ref) {
    return sharedPreferences(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SharedPreferences value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SharedPreferences>(value),
    );
  }
}

String _$sharedPreferencesHash() => r'aff8747938dc87c033748fd5da047fa87dc708fe';
