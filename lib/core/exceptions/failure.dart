import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
sealed class Failure with _$Failure {
  const Failure._();

  const factory Failure.network() = NetworkFailure;
  const factory Failure.timeout() = TimeoutFailure;
  const factory Failure.cancelled() = CancelledFailure;
  const factory Failure.unauthorized([String? message]) = UnauthorizedFailure;
  const factory Failure.forbidden([String? message]) = ForbiddenFailure;
  const factory Failure.notFound([String? message]) = NotFoundFailure;
  const factory Failure.validation(
    Map<String, List<String>> errors, {
    String? message,
  }) = ValidationFailure;
  const factory Failure.server({int? code, String? message}) = ServerFailure;
  const factory Failure.forceUpdate(String message) = ForceUpdateFailure;
  const factory Failure.unknown(String message) = UnknownFailure;

  String get displayMessage => switch (this) {
        NetworkFailure() => 'No internet connection',
        TimeoutFailure() => 'Request timed out. Please try again.',
        CancelledFailure() => 'Request was cancelled.',
        UnauthorizedFailure(:final message) =>
          message ?? 'Your session has expired. Please log in again.',
        ForbiddenFailure(:final message) =>
          message ?? 'You do not have permission to perform this action.',
        NotFoundFailure(:final message) =>
          message ?? 'The requested resource was not found.',
        ValidationFailure(:final message) => message ?? 'Validation failed.',
        ServerFailure(:final message) => message ?? 'Server error.',
        ForceUpdateFailure(:final message) => message,
        UnknownFailure(:final message) => message,
      };
}
