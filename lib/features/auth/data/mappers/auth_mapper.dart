import '../../domain/entities/auth_session.dart';
import '../../domain/entities/user_profile.dart';
import '../models/login_response_dto.dart';
import '../models/user_dto.dart';

/// Pure DTO ↔ entity translation. The single boundary at which backend
/// renames must be absorbed; nothing past this layer should reference DTO
/// types or `JsonKey` annotations.
class AuthMapper {
  const AuthMapper._();

  /// Converts a [LoginResponseDto] to an [AuthSession].
  ///
  /// Returns `null` when the wire payload is missing the bearer token —
  /// callers should treat that case as an invariant violation
  /// (`Failure.unknown`) since the backend should never report a successful
  /// login without one.
  static AuthSession? toSession(LoginResponseDto dto) {
    final token = dto.token;
    if (token == null || token.isEmpty) return null;
    return AuthSession(
      token: token,
      user: dto.user == null ? null : toUserProfile(dto.user!),
    );
  }

  /// Converts a [UserDto] to a [UserProfile]. Returns `null` if the wire
  /// payload is missing the user id (the only invariant this entity enforces).
  static UserProfile? toUserProfile(UserDto dto) {
    final id = dto.id;
    if (id == null) return null;
    return UserProfile(
      id: id,
      name: dto.name ?? '',
      email: dto.email ?? '',
      phone: dto.phone,
    );
  }
}
