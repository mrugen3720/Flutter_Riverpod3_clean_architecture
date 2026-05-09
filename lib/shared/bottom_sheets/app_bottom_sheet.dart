import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/constants/provider_constants.dart';
import '../../core/enum/load_status.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/text_style.dart';
import '../../routing/app_router.dart';
import '../widgets/common_filled_button.dart';

class AppBottomSheet extends StatelessWidget {
  final VoidCallback onPositiveTap;
  final VoidCallback onNegativeTap;
  final String title;
  final String description;
  final String image;
  final String positiveText;
  final bool showBack;
  final LoadStatus status;
  final ValueNotifier<LoadStatus>? loadStatusNotifier;

  const AppBottomSheet({
    super.key,
    required this.onPositiveTap,
    required this.onNegativeTap,
    this.title = "",
    this.image = "",
    this.showBack = true,
    this.description = "Your account will be permanently deleted.",
    this.positiveText = "",
    this.status = LoadStatus.initial,
    this.loadStatusNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColors.whiteColor),
                child: Image.asset(image, fit: BoxFit.contain),
              ),
              const SizedBox(height: 24),
              Text(title, style: AppTextStyle.extraBold(20), textAlign: TextAlign.center),
              const SizedBox(height: 8),
              Text(
                description,
                style: AppTextStyle.medium(14, AppColors.blackColor.withValues(alpha: 0.6)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Row(
                spacing: 12,
                children: [
                  if (showBack)
                    Expanded(
                      child: GestureDetector(
                        onTap: onNegativeTap,
                        child: Container(
                          height: 58,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(kTextFieldBorderRadius),
                            color: AppColors.whiteColor,
                            border: Border.all(color: AppColors.blackColor),
                          ),
                          child: const Center(
                            child: Icon(Icons.arrow_back, color: AppColors.blackColor),
                          ),
                        ),
                      ),
                    ),
                  ValueListenableBuilder<LoadStatus>(
                    valueListenable: loadStatusNotifier ?? ValueNotifier(LoadStatus.initial),
                    builder: (_, loadStatus, __) {
                      return Expanded(
                        flex: 3,
                        child: CommonFilledButton(
                          onPressed: onPositiveTap,
                          buttonText: positiveText,
                          status: loadStatusNotifier?.value ?? LoadStatus.initial,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showConformationSheet({
  String image = "",
  String title = "",
  String description = "",
  String positiveText = "",
  String negative = "",
  LoadStatus status = LoadStatus.initial,
  final VoidCallback? onPositiveTap,
  final VoidCallback? onNegativeTap,
  bool showBack = true,
  final ValueNotifier<LoadStatus>? loadStatusNotifier,
}) {
  final rootContext = rootNavigatorKey.currentContext;
  if (rootContext == null) return;
  showModalBottomSheet<void>(
    context: rootContext,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => AppBottomSheet(
      onPositiveTap: () {
        onPositiveTap?.call();
      },
      onNegativeTap: () {
        onNegativeTap?.call();
      },
      title: title,
      description: description,
      positiveText: positiveText,
      image: image,
      showBack: showBack,
      status: status,
      loadStatusNotifier: loadStatusNotifier,
    ),
  );
}
