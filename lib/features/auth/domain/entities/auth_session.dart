import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_profile.dart';

part 'auth_session.freezed.dart';

/// A successfully authenticated session.
///
/// `token` is non-nullable: a session without a token is meaningless and the
/// mapper rejects such payloads at the data boundary. `user` is optional
/// because some flows (e.g. OTP-first login) authenticate the device before
/// the profile has been fetched.
@freezed
abstract class AuthSession with _$AuthSession {
  const factory AuthSession({
    required String token,
    UserProfile? user,
  }) = _AuthSession;
}
