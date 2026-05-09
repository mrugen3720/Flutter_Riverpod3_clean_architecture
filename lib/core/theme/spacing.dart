import 'package:flutter/widgets.dart';

/// Centralized spacing scale. Every screen / component should pull from this
/// scale rather than hardcoding pixel values, so a future redesign or
/// device-class adaptation has a single dial to turn.
class AppSpacing {
  const AppSpacing._();

  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
}

/// Shorthand for symmetric `SizedBox(width: size, height: size)`. Saves a
/// noisy `SizedBox(height: 16)` boilerplate in vertical layouts and renders
/// identically in both axes when used inline.
class Gap extends StatelessWidget {
  const Gap(this.size, {super.key});
  final double size;

  static const Gap xs = Gap(AppSpacing.xs);
  static const Gap sm = Gap(AppSpacing.sm);
  static const Gap md = Gap(AppSpacing.md);
  static const Gap lg = Gap(AppSpacing.lg);
  static const Gap xl = Gap(AppSpacing.xl);

  @override
  Widget build(BuildContext context) =>
      SizedBox(width: size, height: size);
}
