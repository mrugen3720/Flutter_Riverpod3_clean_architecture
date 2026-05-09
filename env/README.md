# Flavor / environment configuration

This directory holds the per-flavor `--dart-define-from-file` payloads. They feed the compile-time constants in `lib/core/env/env.dart`.

## Usage

```bash
# dev (default while developing locally)
flutter run --flavor dev --dart-define-from-file=env/dev.json

# staging
flutter run --flavor staging --dart-define-from-file=env/staging.json --release

# prod
flutter run --flavor prod --dart-define-from-file=env/prod.json --release
flutter build apk --flavor prod --dart-define-from-file=env/prod.json
flutter build ios --flavor prod --dart-define-from-file=env/prod.json
```

## File layout

| File | Tracked? | Purpose |
| --- | --- | --- |
| `dev.json` | yes | Local development. Safe defaults. |
| `staging.json` | yes | Internal staging. Replace `API_KEY` before use. |
| `prod.json.example` | yes | Template only. Copy → `prod.json` in your local checkout, fill the real values, and **never commit `prod.json`**. |
| `prod.json` | **NO — gitignored** | Real production secrets and SSL pinning fingerprints. |

## What the keys do

| Key | Consumed in | Notes |
| --- | --- | --- |
| `FLAVOR` | `Env.flavor` (`dev`/`staging`/`prod`) | Drives feature gates and SSL pinning activation. |
| `BASE_URL` | Retrofit `@RestApi` + `apiServiceProvider` | Trailing slash required. |
| `SERVER_URL` | `CachedImage` and other asset prefixes. |  |
| `API_KEY` | `KEY` request header. | Production builds **must** override. |
| `ALLOWED_CERT_FINGERPRINTS` | `configureSslPinning` (prod only). | Comma-separated SHA-256 of leaf certs, uppercase, no `:`. |

## Android product flavors

`android/app/build.gradle.kts` defines `dev`, `staging`, and `prod` product flavors with distinct `applicationIdSuffix`es so all three can be installed side-by-side on a tester's device:

| Flavor | applicationId |
| --- | --- |
| `dev` | `com.example.cleanarch.dev` |
| `staging` | `com.example.cleanarch.staging` |
| `prod` | `com.example.cleanarch` |

## iOS schemes (manual setup)

iOS schemes can't be created from the CLI — open `ios/Runner.xcworkspace` in Xcode and:

1. **Product → Scheme → Manage Schemes…**
2. Duplicate `Runner` three times → `Runner-dev`, `Runner-staging`, `Runner-prod`.
3. For each scheme, edit **Run / Test / Archive → Build Configuration** and set it to a matching `Debug-dev` / `Release-staging` / `Release-prod` configuration (create those configurations under the project's **Info** tab if needed).
4. In each configuration, set `PRODUCT_BUNDLE_IDENTIFIER`:
   - `dev` → `com.example.cleanarch.dev`
   - `staging` → `com.example.cleanarch.staging`
   - `prod` → `com.example.cleanarch`
5. Pass `--flavor <name>` to `flutter` and the matching scheme will be used.
