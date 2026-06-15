import 'package:intl/intl.dart';

class DateTimeUtils {
  const DateTimeUtils._();

  static String formatDate(DateTime date) {
    return DateFormat('HH:mm - MMMM dd').format(date);
  }
}
