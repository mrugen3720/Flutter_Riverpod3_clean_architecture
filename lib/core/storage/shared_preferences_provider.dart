import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences_provider.g.dart';

/// Synchronous handle to [SharedPreferences].
///
/// The provider deliberately throws if accessed without an override —
/// `main()` is responsible for awaiting `SharedPreferences.getInstance()`
/// before `runApp` and overriding this provider via
/// `ProviderScope(overrides: [sharedPreferencesProvider.overrideWithValue(...)])`.
///
/// This is the canonical Riverpod pattern for async-init dependencies that
/// downstream providers want to consume synchronously.
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError(
    'sharedPreferencesProvider must be overridden in main() with the '
    'awaited SharedPreferences.getInstance().',
  );
}
