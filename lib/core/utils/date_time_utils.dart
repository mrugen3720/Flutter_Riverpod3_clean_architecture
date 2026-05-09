import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../enum/date_time_formatter.dart';

class DateTimeUtil {
  static String? changeDateFormat({
    required String? inputDate,
    required DateTimeFormatter inputFormat,
    required DateTimeFormatter outputFormat,
  }) {
    if (inputDate == null || inputDate.isEmpty) return null;

    try {
      final inputFormatter = DateFormat(inputFormat.pattern);
      final dateTime = inputFormatter.parseStrict(inputDate);

      if (outputFormat.pattern.contains('d_suffix')) {
        final day = dateTime.day;
        final suffix = getDayNumberSuffix(day);

        switch (outputFormat) {
          case DateTimeFormatter.MMMM_d_suffix_yyyy:
            return "${DateFormat('MMMM d').format(dateTime)}$suffix ${DateFormat('yyyy').format(dateTime)}";
          case DateTimeFormatter.d_suffix_MMM_yyyy:
            return "${DateFormat('d').format(dateTime)}$suffix ${DateFormat('MMM yyyy').format(dateTime)}";
          case DateTimeFormatter.d_suffix_MMMM_yyyy:
            return "${DateFormat('d').format(dateTime)}$suffix ${DateFormat('MMMM yyyy').format(dateTime)}";
          case DateTimeFormatter.d_suffix:
            return "${DateFormat('d').format(dateTime)}$suffix";
          default:
            break;
        }
      }

      final outputFormatter = DateFormat(outputFormat.pattern);
      return outputFormatter.format(dateTime);
    } catch (_) {
      return null;
    }
  }

  static String getDayNumberSuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  TimeOfDay stringToTimeOfDay(String timeString) {
    final parts = timeString.split(":");
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }

  static DateTime stringToDateTime({required String dateTimeString, required DateTimeFormatter outputFormat}) {
    return DateFormat(outputFormat.pattern).parse(dateTimeString);
  }

  static String dateTimeToString({required DateTime dateTime, required DateTimeFormatter outputFormat}) {
    return DateFormat(outputFormat.pattern).format(dateTime);
  }

  bool isToday({required DateTime? date}) {
    if (date == null) return false;
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  TimeOfDay getFutureTimeOfDay({int offsetMinutes = 30}) {
    final now = DateTime.now();
    final future = now.add(Duration(minutes: offsetMinutes));
    return TimeOfDay(hour: future.hour, minute: future.minute);
  }

  TimeOfDay? getMinSelectableTime(DateTime? date, {int offsetMinutes = 30}) {
    if (date == null) return null;

    if (isToday(date: date)) {
      final now = DateTime.now();
      final future = now.add(Duration(minutes: offsetMinutes));

      if (future.day != now.day) {
        return null;
      }

      return TimeOfDay(hour: future.hour, minute: future.minute);
    }

    return null;
  }

  String formatDateWithTimeToUtcIsoString(DateTime date, TimeOfDay time) {
    final combined = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    return combined.toUtc().toIso8601String();
  }

  String formatUtcToLocal({
    required String? utcString,
    DateTimeFormatter outputFormatter = DateTimeFormatter.dd_MM_yyyy,
  }) {
    if (utcString == null || utcString.isEmpty) {
      return "";
    }
    try {
      final utcDateTime = DateTime.parse(utcString);
      final localDateTime = utcDateTime.toLocal();
      final formatted = DateFormat(outputFormatter.pattern).format(localDateTime);
      return "\u200E$formatted";
    } catch (e) {
      return "";
    }
  }
}

String formatDateOrEmpty(DateTime? date, {DateTimeFormatter outputFormatter = DateTimeFormatter.dd_MM_yyyy}) {
  return date != null ? DateFormat(outputFormatter.pattern).format(date) : '';
}

extension TimeOfDayFormatExt on TimeOfDay {
  String formatTo12Hour() {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, hour, minute);
    return DateFormat('hh:mm a').format(dt);
  }

  String formatTo24HourWithSeconds() {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, hour, minute);
    return DateFormat('HH:mm:ss').format(dt);
  }
}
