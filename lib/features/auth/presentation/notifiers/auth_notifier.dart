import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/enum/load_status.dart';
import '../../../../core/exceptions/failure.dart';
import '../../../../core/session/session_controller.dart';
import '../../../../core/utils/dialog_utils.dart';
import '../../../../core/utils/logger_util.dart';
import '../../auth_providers.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/validators/email_validator.dart';
import '../../domain/validators/password_validator.dart';
import '../../domain/validators/validation_result.dart';
import 'auth_state.dart';

part 'auth_notifier.g.dart';

/// Presentation-layer controller for the auth screens.
///
/// Depends only on **domain use cases** and the global [SessionController];
/// never on `data/`, transport types, or the router. Navigation happens
/// declaratively: this notifier flips the session state and the router's
/// `redirect` reacts.
///
/// Holds plain value-class state ([AuthState]); UI controllers are owned by
/// the screen so their `dispose()` lifecycle is sound.
@riverpod
class AuthNotifier extends _$AuthNotifier {
  LoginUseCase get _login => ref.read(loginUseCaseProvider);
  LogoutUseCase get _logout => ref.read(logoutUseCaseProvider);
  SessionController get _session =>
      ref.read(sessionControllerProvider.notifier);

  @override
  AuthState build() => const AuthState();

  // ─── form mutations ──────────────────────────────────────────────────────

  static const _emailValidator = EmailOrPhoneValidator();
  static const _passwordValidator = PasswordValidator();

  static const _emailField = 'email';
  static const _passwordField = 'password';

  void updateEmail(String value) {
    state = state.copyWith(
      email: value,
      fieldErrors: _withoutKey(state.fieldErrors, _emailField),
    );
  }

  void updatePassword(String value) {
    state = state.copyWith(
      password: value,
      fieldErrors: _withoutKey(state.fieldErrors, _passwordField),
    );
  }

  void togglePasswordVisibility() {
    state = state.copyWith(showPassword: !state.showPassword);
  }

  // ─── async actions ───────────────────────────────────────────────────────

  Future<void> callLoginApi() async {
    if (!_validateLogin()) return;

    state = state.copyWith(loadStatus: LoadStatus.loading, errorMessage: null);

    final result = await _login(
      emailOrPhone: state.email.trim(),
      password: state.password.trim(),
    );

    await result.fold(
      (failure) async {
        state = state.copyWith(
          loadStatus: LoadStatus.failure,
          errorMessage: failure.displayMessage,
        );
        logger.e('callLoginApi failed: ${failure.displayMessage}');
        await _surfaceFailure(failure);
      },
      (session) async {
        state = state.copyWith(
          loadStatus: LoadStatus.success,
          errorMessage: null,
        );
        _session.markLoggedIn();
      },
    );
  }

  Future<void> callLogoutApi() async {
    final result = await _logout();
    result.fold(
      (failure) {
        logger.e('callLogoutApi failed: ${failure.displayMessage}');
        DialogUtils.showSnackBar(
          failure.displayMessage,
          snackbarType: SnackbarType.failure,
        );
      },
      (_) {},
    );
    // Local session is cleared regardless of API outcome.
    _session.markLoggedOut();
  }

  // ─── private helpers ─────────────────────────────────────────────────────

  Future<void> _surfaceFailure(Failure failure) async {
    DialogUtils.showSnackBar(
      failure.displayMessage,
      snackbarType: SnackbarType.failure,
    );
    if (failure is UnauthorizedFailure) {
      await _logout();
      _session.markLoggedOut();
    }
  }

  /// Runs domain validators and writes inline field errors into state.
  /// Returns `true` only when every field is valid.
  bool _validateLogin() {
    final errors = <String, String>{};

    final emailResult = _emailValidator.validate(state.email);
    if (emailResult is Invalid) {
      errors[_emailField] = emailResult.message;
    }

    final passwordResult = _passwordValidator.validate(state.password);
    if (passwordResult is Invalid) {
      errors[_passwordField] = passwordResult.message;
    }

    state = state.copyWith(fieldErrors: errors);
    return errors.isEmpty;
  }

  static Map<String, String> _withoutKey(
    Map<String, String> source,
    String key,
  ) {
    if (!source.containsKey(key)) return source;
    final next = Map<String, String>.from(source)..remove(key);
    return next;
  }
}
