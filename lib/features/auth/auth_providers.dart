import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/di/app_providers.dart';
import '../../core/env/env.dart';
import '../../core/storage/secure_token_storage.dart';
import '../../core/storage/user_preferences.dart';
import 'data/datasources/auth_api.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/get_session_usecase.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/logout_usecase.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
AuthApi authApi(Ref ref) {
  return AuthApi(ref.watch(apiClientProvider), baseUrl: Env.baseUrl);
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(
    api: ref.watch(authApiProvider),
    tokenStorage: ref.watch(secureTokenStorageProvider),
    userPreferences: ref.watch(userPreferencesProvider),
  );
}

@Riverpod(keepAlive: true)
LoginUseCase loginUseCase(Ref ref) =>
    LoginUseCase(ref.watch(authRepositoryProvider));

@Riverpod(keepAlive: true)
LogoutUseCase logoutUseCase(Ref ref) =>
    LogoutUseCase(ref.watch(authRepositoryProvider));

@Riverpod(keepAlive: true)
GetSessionUseCase getSessionUseCase(Ref ref) =>
    GetSessionUseCase(ref.watch(authRepositoryProvider));
