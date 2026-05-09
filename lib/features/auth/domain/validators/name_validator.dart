import 'validation_result.dart';

/// Validates a name field (first name, last name).
///
/// Rules:
/// - Must not be empty
/// - Minimum 2 characters
/// - Only letters, spaces, hyphens, and apostrophes
class NameValidator {
  const NameValidator(this._fieldLabel);

  final String _fieldLabel;

  static final RegExp _allowed = RegExp(r"^[a-zA-Z\s\-']+$");

  ValidationResult validate(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return Invalid('Please enter $_fieldLabel');
    }
    if (trimmed.length < 2) {
      return Invalid('$_fieldLabel must be at least 2 characters');
    }
    if (!_allowed.hasMatch(trimmed)) {
      return Invalid('$_fieldLabel can only contain letters');
    }
    return const Valid();
  }
}
