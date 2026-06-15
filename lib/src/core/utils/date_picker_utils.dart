import 'package:crud_app/src/core/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class DatePickerUtils {
  const DatePickerUtils._();

  static Future<DateTime?> showAppDatePicker(
    BuildContext context, {
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) {
    final colors = context.colors;

    return showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime(2000),
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: colors.primary,
              onPrimary: colors.onPrimary,
              onSurface: colors.onSurface,
            ),
          ),
          child: child!,
        );
      },
    );
  }
}
