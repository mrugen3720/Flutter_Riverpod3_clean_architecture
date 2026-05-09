# Feature: `auth`

The reference implementation of the project's vertical-slice template. New features (`profile`, `notifications`, etc.) should clone this layout.

## Layout

```
features/auth/
├── domain/
│   ├── entities/
│   │   ├── auth_session.dart       # token + optional UserProfile
│   │   └── user_profile.dart       # id, name, email, phone
│   ├── repositories/
│   │   └── auth_repository.dart    # abstract; returns Future<Either<Failure, T>>
│   ├── usecases/
│   │   ├── login_usecase.dart
│   │   ├── logout_usecase.dart
│   │   └── get_session_usecase.dart
│   └── validators/
│       ├── validation_result.dart  # sealed Valid / Invalid
│       ├── email_validator.dart    # email-or-phone (the API accepts either)
│       ├── password_validator.dart
│       └── otp_validator.dart
├── data/
│   ├── datasources/
│   │   └── auth_api.dart           # Retrofit interface for /auth/*
│   ├── models/
│   │   ├── login_response_dto.dart
│   │   └── user_dto.dart
│   ├── mappers/
│   │   └── auth_mapper.dart        # DTO ↔ entity; the only place backend renames hit
│   └── repositories/
│       └── auth_repository_impl.dart
├── presentation/
│   ├── notifiers/
│   │   ├── auth_notifier.dart      # @riverpod class; Notifier<AuthState>
│   │   └── auth_state.dart         # Freezed value class — no controllers
│   └── screens/
│       └── login_screen.dart       # ConsumerStatefulWidget; owns controllers
└── auth_providers.dart             # All Riverpod wiring for the feature
```

## Provider graph

| Provider | Type | Purpose |
|---|---|---|
| `authApiProvider` | `AuthApi` | Retrofit client. Reads `apiClientProvider` + `Env.baseUrl`. |
| `authRepositoryProvider` | `AuthRepository` (abstract) | `AuthRepositoryImpl` consuming `AuthApi` + `SecureTokenStorage` + `UserPreferences`. |
| `loginUseCaseProvider` | `LoginUseCase` | Thin orchestration over the repo. |
| `logoutUseCaseProvider` | `LogoutUseCase` | |
| `getSessionUseCaseProvider` | `GetSessionUseCase` | Read locally cached session — used during cold-start bootstrap. |
| `authProvider` | `AuthState` | Form state for the login screen. |

## Login flow

```
User taps "Sign In"
  └─▶ LoginScreen.callLoginApi (button onPressed)
      └─▶ AuthNotifier.callLoginApi()
          ├─▶ _validateLogin() → state.fieldErrors (inline)
          └─▶ LoginUseCase → AuthRepositoryImpl.login()
              ├─▶ AuthApi.login()
              ├─▶ AuthMapper.toSession()
              ├─▶ SecureTokenStorage.write(token)
              └─▶ UserPreferences.saveUser(profile)
              ▼
              Either<Failure, AuthSession>
              ├─Left──▶ state.errorMessage + DialogUtils.showSnackBar
              └─Right─▶ SessionController.markLoggedIn()
                          └─▶ goRouter redirect → /home
```

## Things this feature does *not* do

- **Imperative navigation from the notifier.** Login success flips `SessionController`; the router decides the next route. No `context.go` or `goRouter.go` calls inside the notifier.
- **Persist DTOs.** Cached user is stored as `UserProfile` (entity) behind a versioned internal JSON shape (`UserPreferences`'s `v: 1`), so backend renames don't invalidate stored sessions.
- **Hold UI controllers in state.** `TextEditingController` / `FocusNode` live in `_LoginScreenState` and are disposed in `dispose()`.

## Adding a new auth endpoint

1. Add the method to `data/datasources/auth_api.dart`.
2. Add an abstract method to `domain/repositories/auth_repository.dart`.
3. Implement it in `data/repositories/auth_repository_impl.dart` using `safeApiCall` / `safeApiResponseCall`.
4. (Optional) Wrap it in a use case under `domain/usecases/`.
5. Wire the use case provider in `auth_providers.dart`.
6. Consume it from a notifier method via `ref.read(yourUseCaseProvider)`.
