import 'dart:ui';

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final Color backgroundColor;
  final Color? foregroundColor;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final double elevation;
  final double toolbarHeight;
  final bool automaticallyImplyLeading;
  final Gradient? gradient;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final bool showDivider;
  final double blurIntensity;

  const CustomAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.backgroundColor = Colors.transparent,
    this.foregroundColor,
    this.actions,
    this.leading,
    this.centerTitle = true,
    this.elevation = 0,
    this.toolbarHeight = kToolbarHeight,
    this.automaticallyImplyLeading = true,
    this.gradient,
    this.borderRadius,
    this.padding,
    this.showDivider = false,
    this.blurIntensity = 0,
  }) : assert(title == null || titleWidget == null, 'Cannot provide both a title and a titleWidget');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveForegroundColor = foregroundColor ??
        (backgroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white);

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurIntensity,
          sigmaY: blurIntensity,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            gradient: gradient,
            boxShadow: elevation > 0
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: elevation * 2,
                      offset: Offset(0, elevation),
                    )
                  ]
                : null,
          ),
          child: SafeArea(
            bottom: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    height: toolbarHeight,
                    child: Row(
                      children: [
                        if (leading != null)
                          leading!
                        else if (automaticallyImplyLeading)
                          _buildDefaultLeading(context, effectiveForegroundColor) ?? const SizedBox(),
                        Expanded(
                          child: centerTitle
                              ? Center(
                                  child: _buildTitle(context, effectiveForegroundColor, theme),
                                )
                              : _buildTitle(context, effectiveForegroundColor, theme),
                        ),
                        if (actions != null) ...actions!,
                      ],
                    ),
                  ),
                ),
                if (showDivider)
                  const Divider(
                    height: 1,
                    thickness: 0.5,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget? _buildDefaultLeading(BuildContext context, Color iconColor) {
    final canPop = Navigator.canPop(context);
    if (!canPop) return null;

    return IconButton(
      onPressed: () => Navigator.maybePop(context),
      icon: const Icon(Icons.arrow_back),
    );
  }

  Widget _buildTitle(BuildContext context, Color textColor, ThemeData theme) {
    if (titleWidget != null) return titleWidget!;

    return Text(
      title ?? '',
      style: theme.textTheme.headlineLarge?.copyWith(
        color: textColor,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        toolbarHeight + (showDivider ? 1 : 0),
      );
}
