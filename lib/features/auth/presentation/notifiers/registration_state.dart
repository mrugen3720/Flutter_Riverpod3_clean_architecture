import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/enum/load_status.dart';

part 'registration_state.freezed.dart';

/// Pure value-object state for the registration UI.
///
/// Mirrors the [AuthState] pattern: holds raw form values plus inline
/// field errors populated by domain validators. Flutter framework objects
/// (`TextEditingController`, `FocusNode`) live in widget state.
@freezed
abstract class RegistrationState with _$RegistrationState {
  const factory RegistrationState({
    @Default('') String firstName,
    @Default('') String lastName,
    @Default('') String email,
    @Default('') String phone,
    /// Absolute file path of the selected profile image, or null.
    String? profileImagePath,
    @Default(LoadStatus.initial) LoadStatus loadStatus,
    String? errorMessage,
    @Default(<String, String>{}) Map<String, String> fieldErrors,
  }) = _RegistrationState;
}
