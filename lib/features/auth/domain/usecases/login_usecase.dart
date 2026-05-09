import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/failure.dart';
import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  const LoginUseCase(this._repo);
  final AuthRepository _repo;

  Future<Either<Failure, AuthSession>> call({
    required String emailOrPhone,
    required String password,
  }) {
    return _repo.login(
      emailOrPhone: emailOrPhone,
      password: password,
    );
  }
}
