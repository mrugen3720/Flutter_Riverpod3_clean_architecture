import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'secure_token_storage.g.dart';

/// Storage for the bearer token. Backed by:
///   - iOS: Keychain
///   - Android: EncryptedSharedPreferences (requires minSdk 23+)
///
/// The legacy `SharedPreferences` key (`_auth_token`) used pre-H6 is migrated
/// transparently on the first `read()` call so existing logged-in users are
/// not bounced to the sign-in screen by the upgrade.
class SecureTokenStorage {
  SecureTokenStorage(this._storage);

  final FlutterSecureStorage _storage;

  static const String _key = 'app.auth.token';
  static const String _legacyKey = '_auth_token';

  Future<String?> read() async {
    final token = await _storage.read(key: _key);
    if (token != null && token.isNotEmpty) return token;
    return _migrateLegacyIfPresent();
  }

  Future<void> write(String token) async {
    if (token.isEmpty) {
      await _storage.delete(key: _key);
      return;
    }
    await _storage.write(key: _key, value: token);
  }

  Future<void> delete() => _storage.delete(key: _key);

  Future<String?> _migrateLegacyIfPresent() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final legacy = prefs.getString(_legacyKey);
      if (legacy == null || legacy.isEmpty) return null;
      await _storage.write(key: _key, value: legacy);
      await prefs.remove(_legacyKey);
      return legacy;
    } catch (_) {
      // Best-effort migration. If SharedPreferences is unavailable we simply
      // return null and the caller treats the user as logged out.
      return null;
    }
  }
}

@Riverpod(keepAlive: true)
SecureTokenStorage secureTokenStorage(Ref ref) {
  return SecureTokenStorage(
    const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
      iOptions: IOSOptions(),
    ),
  );
}
