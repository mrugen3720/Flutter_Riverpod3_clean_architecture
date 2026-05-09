import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';

/// Domain entity for an authenticated user.
///
/// Pure Dart — no `package:flutter`, no JSON annotations. Mapping from the
/// wire DTO ([UserDto]) lives in `data/mappers/auth_mapper.dart` and is the
/// single boundary at which backend renames can be absorbed.
@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    required int id,
    @Default('') String name,
    @Default('') String email,
    String? phone,
  }) = _UserProfile;
}
