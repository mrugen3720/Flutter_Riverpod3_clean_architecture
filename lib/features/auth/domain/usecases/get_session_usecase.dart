import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

class GetSessionUseCase {
  const GetSessionUseCase(this._repo);
  final AuthRepository _repo;

  Future<AuthSession?> call() => _repo.currentSession();
}
