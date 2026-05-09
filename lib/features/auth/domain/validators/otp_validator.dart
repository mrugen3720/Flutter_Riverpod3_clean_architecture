import 'validation_result.dart';

class OtpValidator {
  const OtpValidator({this.length = 6});
  final int length;

  ValidationResult validate(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return const Invalid('Please enter the OTP');
    }
    if (trimmed.length != length) {
      return Invalid('OTP must be $length digits');
    }
    if (!RegExp(r'^\d+$').hasMatch(trimmed)) {
      return const Invalid('OTP must contain only digits');
    }
    return const Valid();
  }
}
