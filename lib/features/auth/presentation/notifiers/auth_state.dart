import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/enum/load_status.dart';

part 'auth_state.freezed.dart';

/// Pure value-object state for the auth UI. Holds **no** Flutter framework
/// objects (`TextEditingController`, `FocusNode`) — those live in widget
/// state where their `dispose()` lifecycle is sound.
///
/// `fieldErrors` is populated by domain validators in task M10; for now it
/// is always empty.
@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default('') String email,
    @Default('') String password,
    @Default(true) bool showPassword,
    @Default(LoadStatus.initial) LoadStatus loadStatus,
    String? errorMessage,
    @Default(<String, String>{}) Map<String, String> fieldErrors,
  }) = _AuthState;
}
