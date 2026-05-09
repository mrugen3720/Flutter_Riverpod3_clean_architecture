// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preferences.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userPreferences)
final userPreferencesProvider = UserPreferencesProvider._();

final class UserPreferencesProvider
    extends
        $FunctionalProvider<UserPreferences, UserPreferences, UserPreferences>
    with $Provider<UserPreferences> {
  UserPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userPreferencesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userPreferencesHash();

  @$internal
  @override
  $ProviderElement<UserPreferences> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UserPreferences create(Ref ref) {
    return userPreferences(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserPreferences value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserPreferences>(value),
    );
  }
}

String _$userPreferencesHash() => r'6b10838351add86d55a33c41ea1324b62c7b5756';
