import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/session/session_controller.dart';

/// Initial route while [SessionController] resolves the persisted session.
/// The router's `redirect` is responsible for transitioning away — this
/// widget exists only to keep the bootstrap provider alive and to give the
/// user something to look at.
class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(sessionControllerProvider);
    return const Scaffold(
      body: Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}
