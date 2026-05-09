import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_style.dart';
import '../../../../routing/app_routes.dart';
import '../../../../shared/widgets/common_filled_button.dart';
import '../../../../shared/widgets/common_text_field.dart';
import '../notifiers/auth_notifier.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final FocusNode _emailFocus;
  late final FocusNode _passwordFocus;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(
      text: kDebugMode ? 'user@yopmail.com' : '',
    );
    _passwordController = TextEditingController(
      text: kDebugMode ? 'Test@1234' : '',
    );
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();

    // Seed initial form state with debug values, then forward subsequent
    // edits to the notifier so it can submit without reading widget state.
    //
    // The initial seed is deferred via `Future.microtask` because `initState`
    // runs during the widget-tree build phase, and Riverpod prohibits provider
    // mutations at that time.
    final notifier = ref.read(authProvider.notifier);
    Future.microtask(() {
      notifier.updateEmail(_emailController.text);
      notifier.updatePassword(_passwordController.text);
    });

    _emailController
        .addListener(() => notifier.updateEmail(_emailController.text));
    _passwordController
        .addListener(() => notifier.updatePassword(_passwordController.text));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final showPassword = ref.watch(
      authProvider.select((s) => s.showPassword),
    );
    final loadStatus = ref.watch(
      authProvider.select((s) => s.loadStatus),
    );
    final emailError = ref.watch(
      authProvider.select((s) => s.fieldErrors['email']),
    );
    final passwordError = ref.watch(
      authProvider.select((s) => s.fieldErrors['password']),
    );
    final notifier = ref.read(authProvider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 18),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            ListView(
              children: [
                const SizedBox(height: 60),
                Text('Welcome Back', style: AppTextStyle.extraBold(24)),
                const SizedBox(height: 5),
                Text(
                  'Sign in to your account to continue',
                  style: AppTextStyle.medium(14, AppColors.textColor),
                ),
                const SizedBox(height: 40),
                Column(
                  spacing: 20,
                  children: [
                    CommonTextField(
                      textEditingController: _emailController,
                      focusNode: _emailFocus,
                      labelText: 'Email or Phone',
                      textInputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      nextFocusNode: _passwordFocus,
                      loadStatus: loadStatus,
                      errorMessage: emailError,
                    ),
                    CommonTextField(
                      textEditingController: _passwordController,
                      focusNode: _passwordFocus,
                      labelText: 'Password',
                      textInputType: TextInputType.visiblePassword,
                      maxLines: 1,
                      obscureText: showPassword,
                      loadStatus: loadStatus,
                      errorMessage: passwordError,
                      suffixIcon: IconButton(
                        onPressed: notifier.togglePasswordVisibility,
                        tooltip: showPassword
                            ? 'Show password'
                            : 'Hide password',
                        iconSize: 20,
                        icon: Icon(
                          showPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.hintColor,
                        ),
                      ),
                    ),
                    Semantics(
                      button: true,
                      label: 'Forgot password',
                      child: InkWell(
                        onTap: () =>
                            context.push(AppRoute.forgotPassword.path),
                        child: Align(
                          alignment: AlignmentDirectional.bottomEnd,
                          child: Text(
                            'Forgot password?',
                            style: AppTextStyle.bold(
                              14,
                              AppColors.primary,
                              TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    CommonFilledButton(
                      onPressed: notifier.callLoginApi,
                      status: loadStatus,
                      buttonText: 'Sign In',
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.viewInsetsOf(context).top,
                  ),
                  child: const SizedBox(height: 100),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 22),
              child: RichText(
                text: TextSpan(
                  text: "Don't have an account? ",
                  style: AppTextStyle.medium(14, AppColors.blackColor),
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: Semantics(
                        button: true,
                        label: 'Sign up',
                        child: InkWell(
                          onTap: () async {
                            final email = await context
                                .push<String>(AppRoute.signUp.path);
                            if (email != null && email.isNotEmpty) {
                              _emailController.text = email;
                            }
                          },
                          child: Text(
                            'Sign Up',
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
    );
  }
}
