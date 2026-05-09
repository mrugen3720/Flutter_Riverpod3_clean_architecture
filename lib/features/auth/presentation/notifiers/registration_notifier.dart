import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/enum/load_status.dart';
import '../../../../core/utils/dialog_utils.dart';
import '../../../../core/utils/logger_util.dart';
import '../../domain/validators/name_validator.dart';
import '../../domain/validators/phone_validator.dart';
import '../../domain/validators/strict_email_validator.dart';
import '../../domain/validators/validation_result.dart';
import 'registration_state.dart';

part 'registration_notifier.g.dart';

/// Presentation-layer controller for the registration screen.
///
/// Follows the same patterns as [AuthNotifier]:
/// - Depends only on domain validators (no data-layer coupling)
/// - Holds pure value-class state ([RegistrationState])
/// - UI controllers live in the widget's `State`
///
/// Uses a **mock API** that simulates a 2-second network delay. When your
/// real backend is ready, swap the `_submitToApi()` body with a proper use
/// case injected via `ref.read(registerUseCaseProvider)`.
@riverpod
class RegistrationNotifier extends _$RegistrationNotifier {
  // ─── domain validators ──────────────────────────────────────────────────
  static const _firstNameValidator = NameValidator('First name');
  static const _lastNameValidator = NameValidator('Last name');
  static const _emailValidator = EmailValidator();
  static const _phoneValidator = PhoneValidator();

  // ─── field keys ─────────────────────────────────────────────────────────
  static const _firstNameField = 'firstName';
  static const _lastNameField = 'lastName';
  static const _emailField = 'email';
  static const _phoneField = 'phone';
  static const _profileField = 'profile';

  @override
  RegistrationState build() => const RegistrationState();

  // ─── form mutations ─────────────────────────────────────────────────────

  void updateFirstName(String value) {
    state = state.copyWith(
      firstName: value,
      fieldErrors: _withoutKey(state.fieldErrors, _firstNameField),
    );
  }

  void updateLastName(String value) {
    state = state.copyWith(
      lastName: value,
      fieldErrors: _withoutKey(state.fieldErrors, _lastNameField),
    );
  }

  void updateEmail(String value) {
    state = state.copyWith(
      email: value,
      fieldErrors: _withoutKey(state.fieldErrors, _emailField),
    );
  }

  void updatePhone(String value) {
    state = state.copyWith(
      phone: value,
      fieldErrors: _withoutKey(state.fieldErrors, _phoneField),
    );
  }

  void setProfileImage(String path) {
    state = state.copyWith(
      profileImagePath: path,
      fieldErrors: _withoutKey(state.fieldErrors, _profileField),
    );
  }

  // ─── computed helpers ───────────────────────────────────────────────────

  /// Returns `true` when all required fields have non-empty values and
  /// a profile image is selected. Used by the UI to enable/disable the
  /// submit button (visual hint only — full validation runs on submit).
  bool get isFormFilled =>
      state.firstName.trim().isNotEmpty &&
      state.lastName.trim().isNotEmpty &&
      state.email.trim().isNotEmpty &&
      state.phone.trim().isNotEmpty &&
      state.profileImagePath != null;

  // ─── submit ─────────────────────────────────────────────────────────────

  /// Validates all fields, hits the mock API, and returns the registered
  /// email on success (so the login screen can autofill it).
  Future<String?> callRegisterApi() async {
    if (!_validateAll()) return null;

    state = state.copyWith(loadStatus: LoadStatus.loading, errorMessage: null);

    try {
      final response = await _submitToApi();
      state = state.copyWith(loadStatus: LoadStatus.success);

      DialogUtils.showSnackBar(
        response['message'] as String,
        snackbarType: SnackbarType.success,
      );

      // Return the email so the caller can pass it back to LoginScreen.
      return state.email.trim();
    } catch (e) {
      state = state.copyWith(
        loadStatus: LoadStatus.failure,
        errorMessage: e.toString(),
      );
      logger.e('callRegisterApi failed: $e');
      DialogUtils.showSnackBar(
        'Registration failed. Please try again.',
        snackbarType: SnackbarType.failure,
      );
      return null;
    }
  }

  // ─── mock API ───────────────────────────────────────────────────────────

  Future<Map<String, dynamic>> _submitToApi() async {
    // Simulate 2-second network delay
    await Future.delayed(const Duration(seconds: 2));

    return {
      'status': true,
      'message': 'Registration successful',
      'user': {
        'firstName': state.firstName.trim(),
        'lastName': state.lastName.trim(),
        'email': state.email.trim(),
      },
    };
  }

  // ─── validation ─────────────────────────────────────────────────────────

  bool _validateAll() {
    final errors = <String, String>{};

    final firstNameResult = _firstNameValidator.validate(state.firstName);
    if (firstNameResult is Invalid) {
      errors[_firstNameField] = firstNameResult.message;
    }

    final lastNameResult = _lastNameValidator.validate(state.lastName);
    if (lastNameResult is Invalid) {
      errors[_lastNameField] = lastNameResult.message;
    }

    final emailResult = _emailValidator.validate(state.email);
    if (emailResult is Invalid) {
      errors[_emailField] = emailResult.message;
    }

    final phoneResult = _phoneValidator.validate(state.phone);
    if (phoneResult is Invalid) {
      errors[_phoneField] = phoneResult.message;
    }

    if (state.profileImagePath == null) {
      errors[_profileField] = 'Please select a profile picture';
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
