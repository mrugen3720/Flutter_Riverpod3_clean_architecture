import 'dart:math';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CommonMethods {
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Future<bool> checkConnectivity() async {
    return await InternetConnectionChecker.instance.hasConnection;
  }

  static String generateUniqueId() {
    final random = Random();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final randomPart = random.nextInt(999999);
    return '$timestamp$randomPart';
  }

  static String makeShortForm(String? input) {
    if (input == null || input.trim().isEmpty) return "";

    input = input.replaceAll("_", " ");

    List<String> words = input.split(RegExp(r"\s+"));

    String result = "";

    for (var w in words) {
      if (w.trim().isEmpty || RegExp(r"^\d+$").hasMatch(w)) continue;

      var match = RegExp(r"[A-Za-z]").firstMatch(w);
      if (match != null) {
        result += match.group(0)!.toUpperCase();
      }
    }

    return result;
  }

  static String timeAgoShort(DateTime time) {
    final diff = DateTime.now().difference(time);

    if (diff.inMinutes < 1) {
      return "1 min";
    } else if (diff.inMinutes < 60) {
      return "${diff.inMinutes} min";
    } else if (diff.inHours < 24) {
      return "${diff.inHours} hour${diff.inHours == 1 ? "" : "s"}";
    } else {
      return "${diff.inDays} day${diff.inDays == 1 ? "" : "s"}";
    }
  }
}
