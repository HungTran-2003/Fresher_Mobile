import 'package:finance/src/core/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

enum TimeGreeting {
  morning,
  noon,
  afternoon,
  evening,
  night;

  static TimeGreeting fromDateTime(DateTime dateTime) {
    final hour = dateTime.hour;
    if (hour >= 5 && hour < 11) {
      return TimeGreeting.morning;
    } else if (hour >= 11 && hour < 14) {
      return TimeGreeting.noon;
    } else if (hour >= 14 && hour < 18) {
      return TimeGreeting.afternoon;
    } else if (hour >= 18 && hour < 22) {
      return TimeGreeting.evening;
    } else {
      return TimeGreeting.night;
    }
  }

  String getGreeting(BuildContext context) {
    switch (this) {
      case TimeGreeting.morning:
        return context.s.goodMorning;
      case TimeGreeting.noon:
        return context.s.goodNoon;
      case TimeGreeting.afternoon:
        return context.s.goodAfternoon;
      case TimeGreeting.evening:
        return context.s.goodEvening;
      case TimeGreeting.night:
        return context.s.goodNight;
    }
  }
}
