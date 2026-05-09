import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/domain/entities/user_profile.dart';
import 'shared_preferences_provider.dart';

part 'user_preferences.g.dart';

/// Non-sensitive user-data cache. Speaks **domain entities**, never DTOs.
///
/// Persistence uses a versioned internal schema (`v: 1`) so backend renames
/// don't invalidate stored sessions and so future migrations have a clear
/// hook. An unrecognized version is treated as "no cached user" — the worst
/// case is one extra profile fetch.
class UserPreferences {
  UserPreferences(this._prefs);

  final SharedPreferences _prefs;

  static const String _key = 'app.user.v1';
  static const int _schemaVersion = 1;

  Future<void> saveUser(UserProfile user) async {
    await _prefs.setString(
      _key,
      jsonEncode({
        'v': _schemaVersion,
        'id': user.id,
        'name': user.name,
        'email': user.email,
        'phone': user.phone,
      }),
    );
  }

  UserProfile? readUser() {
    final raw = _prefs.getString(_key);
    if (raw == null) return null;
    try {
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      if (decoded['v'] != _schemaVersion) return null;
      final id = decoded['id'];
      if (id is! int) return null;
      return UserProfile(
        id: id,
        name: (decoded['name'] as String?) ?? '',
        email: (decoded['email'] as String?) ?? '',
        phone: decoded['phone'] as String?,
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> clearUser() => _prefs.remove(_key);
}

@Riverpod(keepAlive: true)
UserPreferences userPreferences(Ref ref) {
  return UserPreferences(ref.watch(sharedPreferencesProvider));
}
