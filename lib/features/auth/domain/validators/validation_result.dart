/// Pure validation outcome. Lives in `domain/` so validators are reusable
/// across feature notifiers, screens, and tests with zero Flutter coupling.
sealed class ValidationResult {
  const ValidationResult();

  bool get isValid => this is Valid;
  String? get messageOrNull =>
      this is Invalid ? (this as Invalid).message : null;
}

class Valid extends ValidationResult {
  const Valid();
}

class Invalid extends ValidationResult {
  const Invalid(this.message);
  final String message;
}
