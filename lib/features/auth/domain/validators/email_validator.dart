import 'validation_result.dart';

/// Validates a single field that the backend treats as either an email or a
/// phone number (the project's auth surface accepts either in the same
/// input). Empty values fail; otherwise the value must match a simplified
/// RFC-5322 email regex OR a 7–15 digit phone (E.164-ish, accepting an
/// optional leading `+`).
class EmailOrPhoneValidator {
  const EmailOrPhoneValidator();

  static final RegExp _email = RegExp(
    r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$',
  );

  static final RegExp _phone = RegExp(r'^\+?\d{7,15}$');

  ValidationResult validate(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return const Invalid('Please enter email or phone');
    }
    if (_email.hasMatch(trimmed) || _phone.hasMatch(trimmed)) {
      return const Valid();
    }
    return const Invalid('Enter a valid email address or phone number');
  }
}
