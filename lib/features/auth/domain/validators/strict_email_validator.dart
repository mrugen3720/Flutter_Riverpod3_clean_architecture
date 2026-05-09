import 'validation_result.dart';

/// Validates that an email address follows standard RFC-5322 format.
///
/// This is a strict email-only validator for registration. For the login
/// screen we use [EmailOrPhoneValidator] which accepts both.
class EmailValidator {
  const EmailValidator();

  static final RegExp _email = RegExp(
    r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$',
  );

  ValidationResult validate(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return const Invalid('Please enter email address');
    }
    if (!_email.hasMatch(trimmed)) {
      return const Invalid('Enter a valid email address');
    }
    return const Valid();
  }
}
