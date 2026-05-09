import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'core/storage/shared_preferences_provider.dart';

void main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    FlutterError.onError = (details) {
      debugPrint('🔴 FlutterError: ${details.exception}');
      debugPrint('🔴 Stack: ${details.stack}');
    };

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Async-init dependencies are awaited here once and injected via
    // ProviderScope overrides so downstream providers can consume them
    // synchronously.
    final prefs = await SharedPreferences.getInstance();

    runApp(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
        child: const MyApp(),
      ),
    );
  }, (error, stack) {
    debugPrint('🔴 Uncaught error: $error');
    debugPrint('🔴 Stack: $stack');
  });
}
