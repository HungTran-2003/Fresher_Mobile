import 'package:finance/generated/l10n.dart';

enum FilterTime { day, week, month }

extension FilterTimeExt on FilterTime {
  String get label {
    switch (this) {
      case FilterTime.day:
        return S.current.daily;
      case FilterTime.week:
        return S.current.weekly;
      case FilterTime.month:
        return S.current.monthly;
    }
  }

  String get groupBy {
    switch (this) {
      case FilterTime.day:
        return 'day';
      case FilterTime.week:
        return 'week';
      case FilterTime.month:
        return 'month';
    }
  }
}
