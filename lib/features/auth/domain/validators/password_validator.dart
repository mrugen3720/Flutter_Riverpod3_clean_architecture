import 'validation_result.dart';

/// Minimum-bar password rule: ≥ 8 chars, contains at least one letter and at
/// least one digit. Tightening (symbols, casing) lives at the backend so the
/// app's surface area stays small.
class PasswordValidator {
  const PasswordValidator();

  static final RegExp _hasLetter = RegExp(r'[A-Za-z]');
  static final RegExp _hasDigit = RegExp(r'\d');

  ValidationResult validate(String value) {
    if (value.isEmpty) {
      return const Invalid('Please enter password');
    }
    if (value.length < 8) {
      return const Invalid('Password must be at least 8 characters');
    }
    if (!_hasLetter.hasMatch(value) || !_hasDigit.hasMatch(value)) {
      return const Invalid('Password must include letters and digits');
    }
    return const Valid();
  }
}
