import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/env/env.dart';
import '../../core/theme/app_colors.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final bool isWithServerUrl;
  final double? height;
  final double? width;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;

  const CachedImage({
    super.key,
    required this.imageUrl,
    this.isWithServerUrl = false,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(0),
      child: CachedNetworkImage(
        imageUrl: isWithServerUrl ? imageUrl : "${Env.serverUrl}$imageUrl",
        height: height,
        width: width,
        fit: fit,
        placeholder: (context, url) =>
            placeholder ??
            Container(
              height: height,
              width: width,
              color: Colors.grey.shade200,
              child: const Center(
                child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
              ),
            ),
        errorWidget: (context, url, error) =>
            errorWidget ??
            Container(
              height: height,
              width: width,
              color: Colors.grey.shade300,
              child: const Icon(Icons.broken_image, color: Colors.grey),
            ),
      ),
    );
  }
}
