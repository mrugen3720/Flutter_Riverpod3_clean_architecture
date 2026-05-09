import 'package:image_picker/image_picker.dart';

class AppValidator {
  static bool isEmpty(String? value) {
    return value == null || value.isEmpty;
  }

  static bool isEmail(String em) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(em);
  }

  static bool isMobile(String mobile) {
    String pattern = r'^(05)(5|0|3|6|4|9|1|8|7)([0-9]{7})$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(mobile);
  }

  static bool isDigitsOnly(String data) {
    RegExp regex = RegExp(r'^\d+$');
    return regex.hasMatch(data);
  }

  static bool isPasswordValid(String value) {
    final regex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,}$');
    return regex.hasMatch(value);
  }

  static String? emptyValidator({required String? value, required String errorString}) {
    if (value?.isEmpty ?? true) {
      return errorString;
    } else {
      return null;
    }
  }

  static bool isValidFile(String path) {
    final ext = path.toLowerCase().substring(path.lastIndexOf('.'));
    return imageExtensions.contains(ext);
  }

  static Future<bool> imageSize(XFile file) async {
    final bytes = (await file.readAsBytes()).lengthInBytes;
    final kb = bytes / 1024;
    final mb = kb / 1024;

    if (mb <= 10) {
      return true;
    } else {
      return false;
    }
  }

  static const imageExtensions = [".jpg", ".png", ".jpeg", ".heic", ".heif", ".webp"];
}
