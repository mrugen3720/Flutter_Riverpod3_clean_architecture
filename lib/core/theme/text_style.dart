import 'package:flutter/widgets.dart';

import 'app_colors.dart';

/// Project typography. Returns **non-null** [TextStyle] so call sites don't
/// need `!` everywhere.
class AppTextStyle {
  const AppTextStyle._();

  static TextStyle regular(double size, [Color? color]) =>
      _base(FontWeight.w400, size, color);

  static TextStyle medium(double size, [Color? color, TextDecoration? deco]) =>
      _base(FontWeight.w500, size, color, deco);

  static TextStyle semiBold(double size, [Color? color]) =>
      _base(FontWeight.w600, size, color);

  static TextStyle bold(double size, [Color? color, TextDecoration? deco]) =>
      _base(FontWeight.w700, size, color, deco);

  static TextStyle light(double size, [Color? color]) =>
      _base(FontWeight.w200, size, color);

  static TextStyle extraBold(double size, [Color? color]) =>
      _base(FontWeight.w800, size, color);

  static TextStyle _base(
    FontWeight weight,
    double size, [
    Color? color,
    TextDecoration? decoration,
  ]) {
    return TextStyle(
      fontWeight: weight,
      fontSize: size,
      decoration: decoration ?? TextDecoration.none,
      decorationColor: decoration != null ? AppColors.primary : null,
      color: color ?? AppColors.blackColor,
    );
  }
}
