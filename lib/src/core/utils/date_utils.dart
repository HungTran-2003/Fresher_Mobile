import 'package:crud_app/configs/app_config.dart';
import 'package:intl/intl.dart';

class DateTimeUtils {
  const DateTimeUtils._();

  static String formatDate(DateTime date) {
    return DateFormat('HH:mm - MMMM dd').format(date);
  }

  static String formatString(String? dateStr, {String? format}) {
    if (dateStr == null || dateStr.isEmpty) return '';
    try {
      final dateTime = DateTime.parse(dateStr).toLocal();
      return DateFormat(
        format ?? AppConfigs.dateTimeDisplayFormat,
      ).format(dateTime);
    } catch (e) {
      return dateStr;
    }
  }
}
