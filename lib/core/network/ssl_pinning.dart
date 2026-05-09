import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import '../env/env.dart';

/// Configures SHA-256 leaf-certificate pinning on [dio] for the prod flavor.
///
/// In `dev` and `staging` this is a no-op so that proxies (Charles, mitmproxy)
/// keep working for inspection. In `prod` the validator compares each
/// presented certificate's DER SHA-256 against the allowlist provided via
/// `--dart-define=ALLOWED_CERT_FINGERPRINTS=AABB...,CCDD...`.
///
/// If the allowlist is empty in a prod build the function falls open (default
/// trust store applies) but emits a loud warning in debug mode so the
/// misconfiguration is visible during integration testing. Production CI
/// pipelines MUST treat an empty allowlist as a failure.
void configureSslPinning(Dio dio) {
  if (!Env.isProd) return;

  final fingerprints = Env.allowedCertFingerprints;
  if (fingerprints.isEmpty) {
    if (kDebugMode) {
      debugPrint(
        '⚠️  SSL pinning is enabled by flavor but '
        'ALLOWED_CERT_FINGERPRINTS is empty. Builds will run without '
        'pinning until fingerprints are passed via --dart-define.',
      );
    }
    return;
  }

  final adapter = dio.httpClientAdapter;
  if (adapter is! IOHttpClientAdapter) return;

  adapter.validateCertificate = (
    X509Certificate? cert,
    String host,
    int port,
  ) {
    if (cert == null) return false;
    final fingerprint = sha256
        .convert(cert.der)
        .toString()
        .toUpperCase()
        .replaceAll(':', '');
    return fingerprints.contains(fingerprint);
  };
}
