import 'validation_result.dart';

/// Validates a phone number field.
///
/// Rules:
/// - Must not be empty
/// - 7–15 digits (E.164 compatible)
/// - Accepts optional leading `+`
class PhoneValidator {
  const PhoneValidator();

  static final RegExp _phone = RegExp(r'^\+?\d{7,15}$');

  ValidationResult validate(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return const Invalid('Please enter phone number');
    }
    if (!_phone.hasMatch(trimmed)) {
      return const Invalid('Enter a valid phone number (7–15 digits)');
    }
    return const Valid();
  }
}
