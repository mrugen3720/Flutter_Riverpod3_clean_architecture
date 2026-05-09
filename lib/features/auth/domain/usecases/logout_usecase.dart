import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/failure.dart';
import '../repositories/auth_repository.dart';

class LogoutUseCase {
  const LogoutUseCase(this._repo);
  final AuthRepository _repo;

  Future<Either<Failure, Unit>> call() => _repo.logout();
}
