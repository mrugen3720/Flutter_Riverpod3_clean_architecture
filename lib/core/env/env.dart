/// Compile-time environment configuration.
///
/// Every value is sourced from `String.fromEnvironment` so it can be set per
/// build via `--dart-define=...` (or `--dart-define-from-file=env/<flavor>.json`).
///
/// **Production builds MUST override:** `BASE_URL`, `API_KEY`, `FLAVOR`,
/// `ALLOWED_CERT_FINGERPRINTS`. The default values below are intentionally
/// dev-targeted and must not be relied upon in release pipelines.
///
/// This file is the **only** location in the repository allowed to declare
/// values like `apiKey = "..."` (see Section 13 of the remediation blueprint).
library;

enum Flavor { dev, staging, prod }

class Env {
  const Env._();

  // ─── flavor ──────────────────────────────────────────────────────────────
  static const String _flavorRaw =
      String.fromEnvironment('FLAVOR', defaultValue: 'dev');

  static Flavor get flavor => switch (_flavorRaw.toLowerCase()) {
        'prod' || 'production' => Flavor.prod,
        'stg' || 'staging' => Flavor.staging,
        _ => Flavor.dev,
      };

  static bool get isProd => flavor == Flavor.prod;
  static bool get isStaging => flavor == Flavor.staging;
  static bool get isDev => flavor == Flavor.dev;

  // ─── network ─────────────────────────────────────────────────────────────
  /// Base URL for the API. Must end with a trailing slash to compose
  /// reliably with relative endpoint paths.
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://api.example.com/api/',
  );

  /// Server root (used for image/asset prefixes).
  static const String serverUrl = String.fromEnvironment(
    'SERVER_URL',
    defaultValue: 'https://api.example.com/',
  );

  /// Static API key sent in the `KEY` header.
  ///
  /// Default value retained for local dev compatibility only — production
  /// pipelines MUST override via `--dart-define=API_KEY=...`.
  static const String apiKey = String.fromEnvironment(
    'API_KEY',
    defaultValue: 'app\$123',
  );

  // ─── cert pinning ────────────────────────────────────────────────────────
  /// Comma-separated SHA-256 fingerprints (uppercase, no `:` separators) of
  /// the leaf certificate(s) the prod build is allowed to trust.
  ///
  /// Provide via:
  ///   `--dart-define=ALLOWED_CERT_FINGERPRINTS=AABB...,CCDD...`
  ///
  /// Empty in non-prod flavors and as the default; pinning is then skipped.
  static const String _certFingerprintsRaw = String.fromEnvironment(
    'ALLOWED_CERT_FINGERPRINTS',
    defaultValue: '',
  );

  static List<String> get allowedCertFingerprints {
    if (_certFingerprintsRaw.isEmpty) return const <String>[];
    return _certFingerprintsRaw
        .split(',')
        .map((f) => f.trim().toUpperCase().replaceAll(':', ''))
        .where((f) => f.isNotEmpty)
        .toList(growable: false);
  }
}
