import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/failure.dart';
import '../entities/auth_session.dart';

/// Contract that every concrete auth data source must satisfy. Defined in
/// the domain layer so neither the use case nor the presentation layer ever
/// imports `data/`.
abstract class AuthRepository {
  Future<Either<Failure, AuthSession>> login({
    required String emailOrPhone,
    required String password,
    String deviceType,
    String deviceToken,
  });

  Future<Either<Failure, AuthSession>> signUp({
    required Map<String, dynamic> body,
  });

  Future<Either<Failure, Unit>> forgotPassword({
    required String emailOrPhone,
  });

  Future<Either<Failure, Unit>> verifyOtp({
    required String emailOrPhone,
    required String otp,
  });

  Future<Either<Failure, Unit>> logout();

  /// Reads the locally persisted session, or `null` if the user is not
  /// currently authenticated.
  Future<AuthSession?> currentSession();
}
