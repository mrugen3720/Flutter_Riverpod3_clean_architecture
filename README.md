<![CDATA[<div align="center">

# 🏗️ Flutter Riverpod Clean Architecture

**A production-ready Flutter boilerplate with Riverpod 3.x, strict Clean Architecture, and enterprise-grade infrastructure.**

[![Flutter](https://img.shields.io/badge/Flutter-3.10+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.10+-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Riverpod](https://img.shields.io/badge/Riverpod-3.x-00B0FF)](https://riverpod.dev)
[![Architecture](https://img.shields.io/badge/Architecture-Clean-brightgreen)]()
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Style](https://img.shields.io/badge/Style-flutter__lints-blue)](https://pub.dev/packages/flutter_lints)

</div>

---

## 📖 Overview

A batteries-included Flutter starter template designed for teams building **scalable, maintainable, and testable** mobile applications. It enforces strict Clean Architecture with feature-first vertical slices, ensuring every layer has a single responsibility and clear dependency direction.

### Who is this for?

- **Teams** starting a new Flutter product who want architecture guardrails from day one
- **Solo developers** who want a production-grade scaffold without weeks of boilerplate
- **Architects** looking for a reference implementation of Clean Architecture with Riverpod 3.x

### Key Capabilities

- 🔐 **Secure Auth Flow** — Login, registration, OTP, forgot/reset password with token management
- 🌐 **Enterprise Networking** — Dio + Retrofit with retry, SSL pinning, log redaction, and connectivity awareness
- 🧱 **Strict Layer Separation** — Domain never imports data or presentation; enforced by convention
- ⚡ **Code Generation** — Freezed entities, Riverpod generators, JSON serialization, and Retrofit clients
- 🎨 **Material 3 Theming** — Light/dark mode via `ColorScheme.fromSeed`, centralized spacing & typography
- 🔑 **Secure Storage** — Keychain (iOS) / EncryptedSharedPreferences (Android) with legacy migration
- 🌍 **Multi-Environment** — `dev` / `staging` / `prod` flavors with compile-time `--dart-define-from-file`
- 📄 **Cursor Pagination** — Reusable `PaginatedAsyncNotifier<T>` base class for infinite lists

---

## 📸 Screenshots

> Screenshots will be added once the UI is finalized.

| Splash | Login | Registration |
|--------|-------|--------------|
| _Coming soon_ | _Coming soon_ | _Coming soon_ |

---

## ✨ Features

| Category | Details |
|----------|---------|
| **Authentication** | Login, registration, OTP verification, forgot/reset password, session persistence |
| **Offline Awareness** | Connectivity monitoring via `InternetConnectionChecker`; requests short-circuit when offline |
| **API Integration** | Type-safe Retrofit clients per feature, generic `ApiResponse<T>` envelope |
| **Error Handling** | Sealed `Failure` type (Freezed) with `Either<Failure, T>` returns; `FailureMapper` as single translation point |
| **Validation** | Domain-layer sealed `ValidationResult` (Valid/Invalid) with per-field error propagation |
| **Dark Mode** | System-adaptive via Material 3 `ColorScheme.fromSeed` |
| **Security** | SSL certificate pinning (prod), log redaction of sensitive fields, secure token storage |
| **Pagination** | Reusable cursor-based `PaginatedAsyncNotifier<T>` with partial-failure resilience |
| **Navigation** | Declarative `go_router` with session-driven redirects — no imperative navigation in notifiers |

---

## 🛠 Tech Stack

| Layer | Technology | Version |
|-------|-----------|---------|
| **Framework** | Flutter | 3.10+ |
| **Language** | Dart | ^3.10.7 |
| **Architecture** | Clean Architecture (feature-first vertical slices) | — |
| **State Management** | Riverpod 3.x + `riverpod_generator` | ^3.3.1 |
| **Navigation** | go_router | ^17.2.3 |
| **Networking** | Dio + Retrofit | ^5.9.2 / ^4.7.1 |
| **Serialization** | Freezed + json_serializable | ^3.2.5 / ^6.9.0 |
| **Error Modeling** | dartz (`Either<Failure, T>`) | ^0.10.1 |
| **Secure Storage** | flutter_secure_storage | ^9.2.2 |
| **Local Storage** | shared_preferences | ^2.5.5 |
| **Connectivity** | internet_connection_checker | ^3.0.1 |
| **SSL Pinning** | crypto (SHA-256 leaf cert) | ^3.0.5 |
| **Image Loading** | cached_network_image | ^3.4.1 |
| **Animations** | Lottie | ^3.3.2 |
| **Linting** | flutter_lints | ^6.0.0 |
| **Code Gen** | build_runner | ^2.15.0 |

---

## 🏛 Project Architecture

### Philosophy

This project follows **Strict Clean Architecture** organized as **feature-first vertical slices**. Each feature is a self-contained module with its own `domain`, `data`, and `presentation` layers, while cross-cutting concerns live in `core/`.

### Why Clean Architecture?

1. **Testability** — Domain logic is pure Dart with zero Flutter dependencies
2. **Replaceability** — Swap Dio for `http`, or SharedPreferences for Hive, without touching business logic
3. **Team scalability** — Multiple developers work on different features without merge conflicts
4. **Onboarding speed** — Every feature follows the same template; learn one, understand all

### Layer Diagram

```
┌─────────────────────────────────────────────────┐
│                 Presentation                     │
│   Screens · Widgets · Notifiers · States         │
│   (ConsumerWidget, ref.watch, ref.read)          │
└──────────────────────┬──────────────────────────┘
                       │ depends on
┌──────────────────────▼──────────────────────────┐
│                   Domain                         │
│   Entities · Use Cases · Abstract Repositories   │
│   Validators · Pure Dart (no Flutter imports)    │
└──────────────────────▲──────────────────────────┘
                       │ implements
┌──────────────────────┴──────────────────────────┐
│                    Data                          │
│   DTOs · Mappers · Retrofit APIs · Repo Impls   │
│   (Dio, SharedPreferences, SecureStorage)        │
└─────────────────────────────────────────────────┘
```

### Dependency Rules (strictly enforced)

| Rule | Description |
|------|-------------|
| **Domain is pure** | `domain/*` imports nothing from `data/`, `presentation/`, or `package:flutter` |
| **Presentation reads domain** | Screens/notifiers import domain entities and the feature's `*_providers.dart` — **never** `data/*` directly |
| **Data implements domain** | Repository implementations live in `data/` and implement abstract contracts defined in `domain/` |
| **No imperative navigation** | Notifiers flip session state; the router's `redirect` handles navigation declaratively |
| **No BuildContext in notifiers** | All notifiers are context-free for testability |

### Data Flow (Login Example)

```
User taps "Sign In"
  └─▶ LoginScreen (button onPressed)
      └─▶ AuthNotifier.callLoginApi()
          ├─▶ _validateLogin() → state.fieldErrors (inline errors)
          └─▶ LoginUseCase → AuthRepositoryImpl.login()
              ├─▶ AuthApi.login() (Retrofit → Dio)
              ├─▶ AuthMapper.toSession() (DTO → Entity)
              ├─▶ SecureTokenStorage.write(token)
              └─▶ UserPreferences.saveUser(profile)
              ▼
              Either<Failure, AuthSession>
              ├─ Left  ──▶ state.errorMessage + SnackBar
              └─ Right ──▶ SessionController.markLoggedIn()
                             └─▶ goRouter redirect → /home
```

---

## 📁 Folder Structure

```
lib/
├── app/                          # App shell
│   ├── app.dart                  # MaterialApp.router with theme + routing
│   └── splash_screen.dart        # Splash shown during session bootstrap
├── core/                         # Cross-cutting infrastructure
│   ├── constants/                # Provider and app-level constants
│   ├── di/                       # Top-level Riverpod providers (Dio client)
│   ├── enum/                     # Shared enums (DateTimeFormatter, LoadStatus)
│   ├── env/                      # Compile-time flavor config (Env class)
│   ├── exceptions/               # Sealed Failure (Freezed) + FailureMapper
│   ├── network/                  # BaseRepository, connectivity, retry, SSL pinning
│   ├── notifications/            # Cross-feature unread count state
│   ├── pagination/               # Reusable PaginatedAsyncNotifier<T>
│   ├── services/api_service/     # ApiResponse envelope, interceptor, log redactor
│   ├── session/                  # SessionController (drives router redirects)
│   ├── storage/                  # SecureTokenStorage, UserPreferences, SharedPreferences provider
│   ├── theme/                    # AppTheme, AppColors, AppTextStyle, AppSpacing, Gap
│   └── utils/                    # AppLogger, dialog helpers, validators, date utils
├── features/
│   └── auth/                     # Auth feature (reference implementation)
│       ├── domain/               # Entities, abstract repo, use cases, validators
│       ├── data/                 # DTOs, mappers, Retrofit API, repo implementation
│       ├── presentation/         # Notifiers, states (Freezed), screens
│       └── auth_providers.dart   # All Riverpod wiring for auth
├── gen/                          # Reserved for generated assets (flutter_gen, etc.)
├── generated/                    # Reserved for generated code
├── routing/                      # GoRouter config, AppRoute enum, RouteTracker
├── shared/                       # Reusable UI primitives
│   ├── widgets/                  # CommonTextField, CommonFilledButton, CachedImage, etc.
│   └── bottom_sheets/           # Reusable bottom sheet components
└── main.dart                     # Bootstrap: SharedPreferences init → ProviderScope
```

### Adding a New Feature

Clone the `auth` feature structure. Each new feature gets:

```
features/<feature_name>/
├── domain/
│   ├── entities/
│   ├── repositories/        # Abstract repository contract
│   ├── usecases/
│   └── validators/          # Optional: domain-level validators
├── data/
│   ├── datasources/         # Retrofit API interface
│   ├── models/              # DTOs (Freezed + json_serializable)
│   ├── mappers/             # DTO ↔ Entity mappers
│   └── repositories/        # Repository implementation
├── presentation/
│   ├── notifiers/           # Riverpod notifiers + Freezed states
│   └── screens/             # ConsumerStatefulWidget screens
└── <feature>_providers.dart  # Riverpod wiring for the feature
```

> 📘 See [`lib/features/auth/README.md`](lib/features/auth/README.md) for the complete feature template guide.

---

## 🧠 State Management

### Riverpod 3.x with Code Generation

State management uses **Riverpod 3.x** with the `riverpod_generator` package for type-safe, compile-time verified providers.

| Pattern | Usage |
|---------|-------|
| `@riverpod` functions | Stateless providers (APIs, repositories, use cases) |
| `@riverpod` classes | Stateful notifiers (form state, session state) |
| `@Riverpod(keepAlive: true)` | Singletons that survive widget disposal (Dio, storage, session) |
| `ref.watch` + `select` | Fine-grained UI rebuilds — screens watch only the slice they need |
| `ref.read` | One-shot reads in event handlers (button taps) |
| `ref.listen` | Side effects (bridging Riverpod → `ChangeNotifier` for go_router) |

### State Architecture

```dart
// Freezed value class — immutable, equatable, copyable
@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool isLoading,
    @Default('') String email,
    @Default('') String password,
    String? errorMessage,
    @Default({}) Map<String, String> fieldErrors,
  }) = _AuthState;
}
```

- **No snackbars for validation** — field errors propagate via `state.fieldErrors` to `CommonTextField.errorMessage`
- **Snackbars for transport failures** — network/server errors surface via `DialogUtils.showSnackBar`
- **UI controllers stay in widgets** — `TextEditingController` / `FocusNode` live in `_ScreenState.dispose()`, never in notifiers

---

## 💉 Dependency Injection

All DI is handled through **Riverpod providers** — no service locator, no `GetIt`, no manual singletons.

### Provider Graph (Auth Feature)

```
LoginScreen (ConsumerStatefulWidget)
   │ ref.watch(authProvider.select(...))
   ▼
AuthNotifier ──ref.read──▶ LoginUseCase / LogoutUseCase
                                │
                                ▼
                          AuthRepository (abstract, in domain/)
                                ▲
                                │ implements
                          AuthRepositoryImpl
                                │
                                ▼
                          AuthApi (Retrofit) · SecureTokenStorage · UserPreferences
```

### Registering New Dependencies

1. Create your provider in `<feature>_providers.dart` or `core/di/app_providers.dart`
2. Use `@riverpod` (auto-disposed) or `@Riverpod(keepAlive: true)` (singleton)
3. Inject dependencies via `ref.watch(otherProvider)` in the provider body
4. Run `dart run build_runner build` to generate the `.g.dart` file

---

## 🧭 Routing

### Declarative go_router with Session-Driven Redirects

```dart
redirect: (context, state) {
  final session = ref.read(sessionControllerProvider);
  return session.when(
    loading: () => /* pin to splash */,
    error:   (_, __) => /* fall back to sign-in */,
    data:    (status) => switch (status) {
      SessionStatus.loggedIn  => /* redirect to /home if on auth path */,
      SessionStatus.loggedOut => /* redirect to /sign_in if on protected path */,
    },
  );
}
```

### Available Routes

| Route | Path | Description |
|-------|------|-------------|
| `splash` | `/splash` | Loading screen during session bootstrap |
| `signIn` | `/sign_in` | Login screen |
| `signUp` | `/sign_up` | Registration screen |
| `otp` | `/otp` | OTP verification |
| `forgotPassword` | `/forgot_password` | Password recovery |
| `resetPassword` | `/reset_password` | Password reset |
| `home` | `/home` | Main app screen (protected) |
| `profile` | `/profile` | User profile (protected) |

### Key Design Decisions

- **`refreshListenable`** bridges Riverpod → go_router via a `ChangeNotifier` that listens to `sessionControllerProvider`
- **`scheduleMicrotask`** defers notifications to avoid "provider modified during build" errors
- **`rootNavigatorKey`** enables overlay surfaces (snackbars, modals) without `BuildContext`

---

## 🌐 API & Networking

### Architecture

```
Feature Notifier
    └─▶ UseCase
        └─▶ Repository (abstract in domain/)
            └─▶ RepositoryImpl extends BaseRepository (in data/)
                └─▶ safeApiCall() / safeApiResponseCall()
                    └─▶ Retrofit API Interface
                        └─▶ Dio Client
                            ├── ApiInterceptors (auth headers, connectivity, logging)
                            ├── RetryInterceptor (GET-only, 3 attempts, exponential backoff)
                            └── SSL Pinning (prod-only, SHA-256 leaf cert)
```

### Key Components

| Component | File | Purpose |
|-----------|------|---------|
| `BaseRepository` | `core/network/base_repository.dart` | `safeApiCall` wraps Dio errors into `Either<Failure, T>` |
| `ApiInterceptors` | `core/services/api_service/interceptor.dart` | Injects auth/API-key headers, checks connectivity, redacts logs |
| `RetryInterceptor` | `core/network/retry_interceptor.dart` | GET-only retries (max 3, exponential backoff: 200ms, 400ms) |
| `FailureMapper` | `core/exceptions/failure_mapper.dart` | Single canonical DioException → Failure translation |
| `LogRedactor` | `core/services/api_service/log_redactor.dart` | Strips `Authorization`, `password`, `token`, `otp`, etc. from logs |
| `ApiResponse<T>` | `core/services/api_service/api_response.dart` | Generic envelope with `status`, `code`, `message`, `data`, `links` |

### Error Model

```dart
sealed class Failure with _$Failure {
  const factory Failure.network();
  const factory Failure.timeout();
  const factory Failure.cancelled();
  const factory Failure.unauthorized([String? message]);
  const factory Failure.forbidden([String? message]);
  const factory Failure.notFound([String? message]);
  const factory Failure.validation(Map<String, List<String>> errors, {String? message});
  const factory Failure.server({int? code, String? message});
  const factory Failure.forceUpdate(String message);
  const factory Failure.unknown(String message);
}
```

---

## 🔐 Security

| Feature | Implementation |
|---------|---------------|
| **Token Storage** | `flutter_secure_storage` — Keychain (iOS), EncryptedSharedPreferences (Android, minSdk ≥ 23) |
| **Legacy Migration** | Old `SharedPreferences` `_auth_token` auto-migrates to secure storage on first read |
| **SSL Pinning** | SHA-256 leaf-cert validation (prod only); disabled in dev/staging for proxy inspection |
| **Secrets Management** | All secrets via `--dart-define-from-file`; `env/prod.json` is gitignored |
| **Log Redaction** | `LogRedactor` strips 20+ sensitive field names before any log output |
| **Debug Gating** | All transport logging is `kDebugMode`-gated; zero log output in release builds |

---

## 🌍 Environment Configuration

### Flavors

| Flavor | Android `applicationId` | App Name | SSL Pinning |
|--------|------------------------|----------|-------------|
| `dev` | `com.example.cleanarch.dev` | Clean Arch Dev | ❌ Off |
| `staging` | `com.example.cleanarch.staging` | Clean Arch Staging | ❌ Off |
| `prod` | `com.example.cleanarch` | Clean Architecture | ✅ Active |

### Environment Files

```
env/
├── dev.json              # ✅ Tracked — safe defaults for local development
├── staging.json          # ✅ Tracked — replace API_KEY before use
├── prod.json.example     # ✅ Tracked — template only
└── prod.json             # 🚫 Gitignored — real production secrets
```

### Environment Variables

| Key | Purpose |
|-----|---------|
| `FLAVOR` | Drives feature gates and SSL pinning activation (`dev`/`staging`/`prod`) |
| `BASE_URL` | Retrofit API base URL (trailing slash required) |
| `SERVER_URL` | Asset/image URL prefix |
| `API_KEY` | Static API key sent in the `KEY` request header |
| `ALLOWED_CERT_FINGERPRINTS` | Comma-separated SHA-256 leaf cert hashes (prod only) |

> 📘 See [`env/README.md`](env/README.md) for full environment setup details, including iOS scheme configuration.

---

## 🚀 Getting Started

### Prerequisites

| Tool | Version |
|------|---------|
| Flutter SDK | ≥ 3.10 |
| Dart SDK | ≥ 3.10.7 |
| Android Studio / Xcode | Latest stable |
| Java | 17+ (for Android builds) |

### Setup

```bash
# 1. Clone the repository
git clone https://github.com/<your-org>/flutter_riverpod_clean_architecture.git
cd flutter_riverpod_clean_architecture

# 2. Install dependencies
flutter pub get

# 3. Run code generation
dart run build_runner build --delete-conflicting-outputs

# 4. Run the app (dev flavor)
flutter run --flavor dev --dart-define-from-file=env/dev.json
```

### Production Setup

```bash
# 1. Create your production env file
cp env/prod.json.example env/prod.json
# 2. Fill in real values (API keys, cert fingerprints)
# 3. Build
flutter build apk --flavor prod --dart-define-from-file=env/prod.json
flutter build ios --flavor prod --dart-define-from-file=env/prod.json
```

> ⚠️ **iOS flavors** require manual Xcode scheme setup. See [`env/README.md`](env/README.md) for step-by-step instructions.

---

## 🔧 Build Commands

```bash
# ─── Development ──────────────────────────────────
flutter run --flavor dev --dart-define-from-file=env/dev.json

# ─── Staging ──────────────────────────────────────
flutter run --flavor staging --dart-define-from-file=env/staging.json --release

# ─── Production ───────────────────────────────────
flutter build apk --flavor prod --dart-define-from-file=env/prod.json
flutter build ios --flavor prod --dart-define-from-file=env/prod.json

# ─── Code Generation ─────────────────────────────
dart run build_runner build --delete-conflicting-outputs
dart run build_runner watch  # continuous generation during development

# ─── Analysis & Formatting ───────────────────────
flutter analyze
dart format .

# ─── Testing ─────────────────────────────────────
flutter test
```

---

## 🧪 Testing

### Current State

The project includes a placeholder test structure. Real test coverage is planned for a future milestone (M2).

```
test/
└── widget_test.dart    # Placeholder — to be replaced with real coverage
```

### Planned Testing Strategy

| Type | Target | Tools |
|------|--------|-------|
| **Unit Tests** | Validators, use cases, mappers, failure mapper | `flutter_test` |
| **Notifier Tests** | Auth notifier state transitions | `flutter_test` + Riverpod testing utilities |
| **Repository Tests** | Repository impl with mocked APIs | `flutter_test` + `mockito` |
| **Widget Tests** | Screen rendering, form interactions | `flutter_test` |
| **Integration Tests** | Full auth flow end-to-end | `integration_test` |

### Testability by Design

- **Domain layer** is pure Dart — test without Flutter or any framework
- **Repositories** are abstract — inject mock implementations in tests
- **Notifiers** are context-free — test state transitions without widget trees
- **Providers** can be overridden via `ProviderScope.overrides` in tests

---

## 📏 Code Standards & Conventions

### Linting

Configured via `analysis_options.yaml` with strict rules:

```yaml
analyzer:
  errors:
    unused_import: error
    unawaited_futures: error
    avoid_print: error

linter:
  rules:
    unawaited_futures: true
    avoid_print: true
    require_trailing_commas: true
    prefer_single_quotes: true
    prefer_relative_imports: true
    use_build_context_synchronously: true
    avoid_dynamic_calls: true
```

### Naming Conventions

| Item | Convention | Example |
|------|-----------|---------|
| Files | `snake_case` | `auth_repository_impl.dart` |
| Classes | `PascalCase` | `AuthRepositoryImpl` |
| Providers | `camelCase` + `Provider` suffix (auto-generated) | `authRepositoryProvider` |
| Feature dirs | `snake_case` | `features/auth/` |
| DTOs | `PascalCase` + `Dto` suffix | `LoginResponseDto` |
| Entities | `PascalCase` (no suffix) | `AuthSession`, `UserProfile` |
| Use Cases | `PascalCase` + `UseCase` suffix | `LoginUseCase` |

### Architecture Principles

- **No hardcoded colors/spacing** — use `AppColors`, `AppSpacing`, `AppTextStyle`
- **No `print()` statements** — use `AppLogger` (enforced as lint error)
- **No imperative navigation in notifiers** — flip session state, let router decide
- **Generated files excluded from analysis** — `*.g.dart`, `*.freezed.dart`, `lib/gen/**`

---

## 📐 Scalability & Maintainability

### How the Project Scales

| Concern | Strategy |
|---------|----------|
| **New features** | Clone the `auth` vertical slice template — each feature is fully self-contained |
| **New API endpoints** | Add to feature's Retrofit API → abstract repo → repo impl → use case → notifier |
| **New environments** | Add a `<flavor>.json` to `env/` and a product flavor in `build.gradle.kts` |
| **Paginated lists** | Extend `PaginatedAsyncNotifier<T>` and implement `fetchPage(cursor)` |
| **Team growth** | Feature-first structure minimizes merge conflicts across teams |

### Reusability Patterns

- `BaseRepository.safeApiCall` / `safeApiResponseCall` — every network call goes through one error boundary
- `PaginatedAsyncNotifier<T>` — reusable cursor pagination for any entity type
- `CommonTextField` / `CommonFilledButton` — shared UI primitives with consistent styling
- `ValidationResult` (sealed) — reusable domain validators with zero Flutter coupling
- `Gap` widget — spacing shorthand replacing `SizedBox(height: n)` boilerplate

---

## 🤝 Contributing

### Branch Naming

```
feature/<feature-name>     # New features
bugfix/<issue-description> # Bug fixes
hotfix/<critical-fix>      # Production hotfixes
refactor/<area>            # Code improvements
```

### Commit Conventions

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
feat(auth): add biometric login support
fix(network): handle 429 rate limiting correctly
refactor(core): extract BaseRepository from feature repos
docs(readme): update architecture diagram
```

### Pull Request Workflow

1. Create a feature branch from `main`
2. Run `flutter analyze` — must pass with zero errors
3. Run `dart format .` — must produce no changes
4. Run `dart run build_runner build --delete-conflicting-outputs` — generated files must be committed
5. Open PR with description following the template
6. At least one approval required before merge

### Before Every Change

> 📘 Read [`docs/ARCHITECTURE_REMEDIATION.md`](docs/ARCHITECTURE_REMEDIATION.md) — Section 11 (change protocol), Section 12 (self-review), Section 13 (anti-pattern detection).

---

## ⚠️ Known Limitations

| Item | Status | Notes |
|------|--------|-------|
| `riverpod_lint` disabled | ⏳ Blocked | Analyzer 7.x/8.x conflict with `build_runner ^2.15`. Re-enable when upstream ships compatible releases. |
| iOS flavor schemes | 🔧 Manual | Must be configured manually in Xcode (no CLI automation). See `env/README.md`. |
| Test coverage | 📋 Placeholder | Real unit/widget/integration tests planned for M2 milestone. |
| Asset pipeline | 🔜 Not active | `assets/` directories and custom fonts are commented out in `pubspec.yaml`. |
| Some routes are stubs | 🔜 WIP | `forgotPassword`, `otp`, `home`, `profile` routes render empty `Scaffold()`. |

---

## 🔮 Future Improvements

- [ ] **Test suite** — Unit, widget, and integration tests with coverage reporting
- [ ] **CI/CD pipeline** — GitHub Actions for lint, test, build, and deploy
- [ ] **Localization** — `intl` / `flutter_localizations` with ARB files
- [ ] **Deep linking** — Universal links (iOS) and App Links (Android) via go_router
- [ ] **Push notifications** — FCM integration with notification feature module
- [ ] **Biometric auth** — Fingerprint/FaceID via `local_auth`
- [ ] **Offline-first** — Local database (Drift/Isar) with sync strategy
- [ ] **Feature flags** — Remote config for gradual rollouts
- [ ] **Crashlytics** — Firebase Crashlytics for production error tracking
- [ ] **Re-enable `riverpod_lint`** — Once analyzer 8.x compatibility ships

---

## 📚 Further Reading

| Document | Purpose |
|----------|---------|
| [`ARCHITECTURE.md`](ARCHITECTURE.md) | High-level architecture overview, layer rules, DI graph, security model |
| [`docs/ARCHITECTURE_REMEDIATION.md`](docs/ARCHITECTURE_REMEDIATION.md) | Exhaustive remediation history, change protocol, self-review checklist |
| [`lib/features/auth/README.md`](lib/features/auth/README.md) | Reference feature template — clone this for new features |
| [`env/README.md`](env/README.md) | Full flavor/environment setup guide including iOS scheme instructions |

---

<div align="center">

**Built with ❤️ using Flutter & Clean Architecture**

</div>
]]>
# Flutter_Riverpod3_clean_architecture
