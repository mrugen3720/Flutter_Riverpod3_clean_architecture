import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/enum/load_status.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_style.dart';
import '../../../../shared/widgets/common_filled_button.dart';
import '../../../../shared/widgets/common_text_field.dart';
import '../notifiers/registration_notifier.dart';

/// A production-quality registration screen with:
/// - Animated profile avatar picker (camera / gallery)
/// - First name, last name, email, phone fields
/// - Real-time field validation with inline errors
/// - Disabled submit button until all fields are filled
/// - Animated loading overlay during mock API call
/// - Success snackbar + auto-redirect to login with email autofill
class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _firstNameCtrl;
  late final TextEditingController _lastNameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _phoneCtrl;

  late final FocusNode _firstNameFocus;
  late final FocusNode _lastNameFocus;
  late final FocusNode _emailFocus;
  late final FocusNode _phoneFocus;

  late final AnimationController _avatarAnimCtrl;
  late final Animation<double> _avatarScale;

  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _firstNameCtrl = TextEditingController();
    _lastNameCtrl = TextEditingController();
    _emailCtrl = TextEditingController();
    _phoneCtrl = TextEditingController();

    _firstNameFocus = FocusNode();
    _lastNameFocus = FocusNode();
    _emailFocus = FocusNode();
    _phoneFocus = FocusNode();

    // Subtle bounce animation for the avatar on first paint.
    _avatarAnimCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _avatarScale = CurvedAnimation(
      parent: _avatarAnimCtrl,
      curve: Curves.elasticOut,
    );
    _avatarAnimCtrl.forward();

    // Wire controllers → notifier (deferred to avoid build-phase mutation).
    final notifier = ref.read(registrationProvider.notifier);
    _firstNameCtrl.addListener(
      () => notifier.updateFirstName(_firstNameCtrl.text),
    );
    _lastNameCtrl.addListener(
      () => notifier.updateLastName(_lastNameCtrl.text),
    );
    _emailCtrl.addListener(() => notifier.updateEmail(_emailCtrl.text));
    _phoneCtrl.addListener(() => notifier.updatePhone(_phoneCtrl.text));
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _avatarAnimCtrl.dispose();
    super.dispose();
  }

  // ─── image picker ───────────────────────────────────────────────────────

  Future<void> _showImageSourceSheet() async {
    final notifier = ref.read(registrationProvider.notifier);

    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _ImageSourceSheet(
        onCamera: () async {
          Navigator.pop(context);
          final file = await _picker.pickImage(
            source: ImageSource.camera,
            maxWidth: 512,
            maxHeight: 512,
            imageQuality: 80,
          );
          if (file != null) {
            notifier.setProfileImage(file.path);
            _avatarAnimCtrl.reset();
            unawaited(_avatarAnimCtrl.forward());
          }
        },
        onGallery: () async {
          Navigator.pop(context);
          final file = await _picker.pickImage(
            source: ImageSource.gallery,
            maxWidth: 512,
            maxHeight: 512,
            imageQuality: 80,
          );
          if (file != null) {
            notifier.setProfileImage(file.path);
            _avatarAnimCtrl.reset();
            unawaited(_avatarAnimCtrl.forward());
          }
        },
      ),
    );
  }

  // ─── submit ─────────────────────────────────────────────────────────────

  Future<void> _onSubmit() async {
    FocusScope.of(context).unfocus();
    final notifier = ref.read(registrationProvider.notifier);
    final email = await notifier.callRegisterApi();

    if (email != null && mounted) {
      // Wait briefly so the user sees the success snackbar.
      await Future.delayed(const Duration(milliseconds: 600));
      if (mounted) {
        // Pop back to login, passing the email for autofill.
        context.pop(email);
      }
    }
  }

  // ─── build ──────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registrationProvider);
    final notifier = ref.read(registrationProvider.notifier);
    final colors = Theme.of(context).colorScheme;
    final isLoading = state.loadStatus == LoadStatus.loading;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            // ── scrollable form ──
            CustomScrollView(
              slivers: [
                // ── header ──
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Back button
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: IconButton(
                            onPressed: isLoading ? null : () => context.pop(),
                            icon: const Icon(Icons.arrow_back_ios_new_rounded),
                            tooltip: 'Back to login',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Create Account',
                          style: AppTextStyle.extraBold(28),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Fill in your details to get started',
                          style: AppTextStyle.medium(14, AppColors.hintColor),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),

                // ── avatar ──
                SliverToBoxAdapter(
                  child: Center(
                    child: ScaleTransition(
                      scale: _avatarScale,
                      child: _ProfileAvatar(
                        imagePath: state.profileImagePath,
                        hasError: state.fieldErrors.containsKey('profile'),
                        errorText: state.fieldErrors['profile'],
                        onTap: isLoading ? null : _showImageSourceSheet,
                      ),
                    ),
                  ),
                ),

                // ── form fields ──
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 28, 24, 120),
                  sliver: SliverList.list(
                    children: [
                      // First & Last name side-by-side
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CommonTextField(
                              textEditingController: _firstNameCtrl,
                              focusNode: _firstNameFocus,
                              labelText: 'First Name',
                              textInputType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              textCapitalization: TextCapitalization.words,
                              nextFocusNode: _lastNameFocus,
                              loadStatus: state.loadStatus,
                              errorMessage: state.fieldErrors['firstName'],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: CommonTextField(
                              textEditingController: _lastNameCtrl,
                              focusNode: _lastNameFocus,
                              labelText: 'Last Name',
                              textInputType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              textCapitalization: TextCapitalization.words,
                              nextFocusNode: _emailFocus,
                              loadStatus: state.loadStatus,
                              errorMessage: state.fieldErrors['lastName'],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Email
                      CommonTextField(
                        textEditingController: _emailCtrl,
                        focusNode: _emailFocus,
                        labelText: 'Email Address',
                        textInputType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        nextFocusNode: _phoneFocus,
                        loadStatus: state.loadStatus,
                        errorMessage: state.fieldErrors['email'],
                        prefixIcon:
                            Icon(Icons.email_outlined, color: colors.outline),
                      ),
                      const SizedBox(height: 20),

                      // Phone
                      CommonTextField(
                        textEditingController: _phoneCtrl,
                        focusNode: _phoneFocus,
                        labelText: 'Phone Number',
                        textInputType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        loadStatus: state.loadStatus,
                        errorMessage: state.fieldErrors['phone'],
                        maxLength: 15,
                        inputFormat: [
                          FilteringTextInputFormatter.allow(RegExp(r'[\d+]')),
                        ],
                        prefixIcon: Icon(
                          Icons.phone_outlined,
                          color: colors.outline,
                        ),
                      ),
                      const SizedBox(height: 36),

                      // Submit
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: notifier.isFormFilled ? 1.0 : 0.5,
                        child: CommonFilledButton(
                          onPressed: notifier.isFormFilled && !isLoading
                              ? _onSubmit
                              : null,
                          buttonText: 'Create Account',
                          status: state.loadStatus,
                          buttonColor: AppColors.primary,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // "Already have an account? Sign In"
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: 'Already have an account? ',
                            style: AppTextStyle.medium(
                              14,
                              AppColors.hintColor,
                            ),
                            children: [
                              WidgetSpan(
                                alignment: PlaceholderAlignment.baseline,
                                baseline: TextBaseline.alphabetic,
                                child: Semantics(
                                  button: true,
                                  label: 'Sign in',
                                  child: InkWell(
                                    onTap: isLoading
                                        ? null
                                        : () => context.pop(),
                                    child: Text(
                                      'Sign In',
                                      style: AppTextStyle.bold(
                                        14,
                                        AppColors.primary,
                                        TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // ── loading overlay ──
            if (isLoading)
              ColoredBox(
                color: colors.surface.withValues(alpha: 0.6),
                child: const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ─── profile avatar widget ──────────────────────────────────────────────────

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({
    required this.imagePath,
    required this.hasError,
    this.errorText,
    this.onTap,
  });

  final String? imagePath;
  final bool hasError;
  final String? errorText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final hasImage = imagePath != null;

    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Circle avatar
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: hasError
                        ? AppColors.redColor
                        : hasImage
                            ? AppColors.primary
                            : colors.outlineVariant,
                    width: hasError ? 2 : 3,
                  ),
                  boxShadow: hasImage
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.25),
                            blurRadius: 16,
                            spreadRadius: 2,
                          ),
                        ]
                      : null,
                ),
                child: ClipOval(
                  child: hasImage
                      ? Image.file(
                          File(imagePath!),
                          fit: BoxFit.cover,
                          width: 110,
                          height: 110,
                        )
                      : Container(
                          color: colors.surfaceContainerHighest,
                          child: Icon(
                            Icons.person_outline_rounded,
                            size: 48,
                            color: colors.outline,
                          ),
                        ),
                ),
              ),

              // Camera badge
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                    border: Border.all(
                      color: colors.surface,
                      width: 2.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.35),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.camera_alt_rounded,
                    size: 16,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (hasError && errorText != null) ...[
          const SizedBox(height: 8),
          Text(
            errorText!,
            style: AppTextStyle.medium(12, AppColors.redColor),
          ),
        ],
      ],
    );
  }
}

// ─── bottom sheet for image source selection ─────────────────────────────────

class _ImageSourceSheet extends StatelessWidget {
  const _ImageSourceSheet({
    required this.onCamera,
    required this.onGallery,
  });

  final VoidCallback onCamera;
  final VoidCallback onGallery;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colors.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Choose Profile Photo',
                style: AppTextStyle.semiBold(18),
              ),
              const SizedBox(height: 6),
              Text(
                'Select an image from camera or gallery',
                style: AppTextStyle.regular(13, AppColors.hintColor),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _SourceOption(
                      icon: Icons.camera_alt_rounded,
                      label: 'Camera',
                      onTap: onCamera,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _SourceOption(
                      icon: Icons.photo_library_rounded,
                      label: 'Gallery',
                      onTap: onGallery,
                    ),
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

class _SourceOption extends StatelessWidget {
  const _SourceOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Material(
      color: colors.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.12),
                ),
                child: Icon(icon, color: AppColors.primary, size: 26),
              ),
              const SizedBox(height: 10),
              Text(label, style: AppTextStyle.medium(14)),
            ],
          ),
        ),
      ),
    );
  }
}
