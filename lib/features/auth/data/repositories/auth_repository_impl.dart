import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/network/base_repository.dart';
import '../../../../core/services/api_service/api_response.dart';
import '../../../../core/storage/secure_token_storage.dart';
import '../../../../core/storage/user_preferences.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_api.dart';
import '../mappers/auth_mapper.dart';
import '../models/login_response_dto.dart';

/// Concrete [AuthRepository] backed by:
///   - [AuthApi] for transport,
///   - [SecureTokenStorage] for the bearer token, and
///   - [UserPreferences] for the cached user payload (persists the
///     domain entity, not the DTO — closes the M7 persisted-schema goal).
class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  AuthRepositoryImpl({
    required AuthApi api,
    required SecureTokenStorage tokenStorage,
    required UserPreferences userPreferences,
  })  : _api = api,
        _tokens = tokenStorage,
        _users = userPreferences;

  final AuthApi _api;
  final SecureTokenStorage _tokens;
  final UserPreferences _users;

  // ─── login ──────────────────────────────────────────────────────────────

  @override
  Future<Either<Failure, AuthSession>> login({
    required String emailOrPhone,
    required String password,
    String deviceType = 'mobile',
    String deviceToken = '',
  }) {
    return _authenticate(
      () => _api.login(jsonBody: {
        'email_or_phone': emailOrPhone,
        'password': password,
        'device_type': deviceType,
        'device_token': deviceToken,
      }),
    );
  }

  @override
  Future<Either<Failure, AuthSession>> signUp({
    required Map<String, dynamic> body,
  }) {
    return _authenticate(() => _api.signUp(jsonBody: body));
  }

  Future<Either<Failure, AuthSession>> _authenticate(
    Future<ApiResponse<LoginResponseDto>> Function() call,
  ) async {
    final result = await safeApiResponseCall(call);
    return result.fold<Future<Either<Failure, AuthSession>>>(
      (failure) async => Left(failure),
      (response) async {
        final dto = response.jsonData;
        if (dto == null) {
          return Left(
            Failure.server(code: response.code, message: response.message),
          );
        }
        final session = AuthMapper.toSession(dto);
        if (session == null) {
          return const Left(
            Failure.unknown('Authentication response is missing a token.'),
          );
        }
        await _tokens.write(session.token);
        if (session.user != null) {
          await _users.saveUser(session.user!);
        }
        return Right(session);
      },
    );
  }

  // ─── password / otp ─────────────────────────────────────────────────────

  @override
  Future<Either<Failure, Unit>> forgotPassword({
    required String emailOrPhone,
  }) async {
    final result = await safeApiResponseCall(
      () => _api.forgotPassword(jsonBody: {'email_or_phone': emailOrPhone}),
    );
    return result.map((_) => unit);
  }

  @override
  Future<Either<Failure, Unit>> verifyOtp({
    required String emailOrPhone,
    required String otp,
  }) async {
    final result = await safeApiResponseCall(
      () => _api.verifyOtp(jsonBody: {
        'email_or_phone': emailOrPhone,
        'otp': otp,
      }),
    );
    return result.map((_) => unit);
  }

  // ─── logout / current session ───────────────────────────────────────────

  @override
  Future<Either<Failure, Unit>> logout() async {
    final result = await safeApiResponseCall(_api.logout);
    // Clear local session regardless of server response — the user has
    // already signaled intent to leave the authed surface.
    await _tokens.delete();
    await _users.clearUser();
    return result.map((_) => unit);
  }

  @override
  Future<AuthSession?> currentSession() async {
    final token = await _tokens.read();
    if (token == null || token.isEmpty) return null;
    return AuthSession(token: token, user: _users.readUser());
  }
}
