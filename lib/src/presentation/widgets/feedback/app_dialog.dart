import 'dart:async';

import 'package:crud_app/src/core/theme/app_theme.dart';
import 'package:crud_app/src/core/utils/extensions/context_extensions.dart';
import 'package:crud_app/src/presentation/widgets/inputs/buttons/app_filled_button.dart';
import 'package:flutter/material.dart';

enum DialogType {
  infoAlert, // Informational dialog with a single button (e.g., "OK")
  infoConfirmation, // Informational confirmation dialog with actions (e.g., "OK" / "Cancel")
  errorAlert, // Error dialog with a single button
  errorConfirmation, // Error confirmation dialog with actions (e.g., "Yes" / "No")
}

extension DialogTypeExt on DialogType {
  bool get isDeclinedButtonVisible {
    switch (this) {
      case DialogType.infoAlert:
        return false; // No decline button for info alert
      case DialogType.infoConfirmation:
        return true; // Decline button is visible
      case DialogType.errorAlert:
        return false; // No decline button for error alert
      case DialogType.errorConfirmation:
        return true; // Decline button is visible
    }
  }

  Color getConfirmButtonColor(BuildContext context) {
    switch (this) {
      case DialogType.infoAlert:
        return AppTheme.of(context).appColorScheme.primary;
      case DialogType.infoConfirmation:
        return AppTheme.of(context).appColorScheme.primary;
      case DialogType.errorAlert:
        return AppTheme.of(context).appColorScheme.errorContainer;
      case DialogType.errorConfirmation:
        return AppTheme.of(context).appColorScheme.errorContainer;
    }
  }
}

enum DialogAction {
  confirmed, // User has confirmed the action
  declined, // User has declined the action
  dismissed, // User has dismissed the dialog
}

class AppDialog {
  static Future<DialogAction> show({
    required BuildContext context,
    required DialogType dialogType,
    required String titleText,
    required String messageText,
    required String confirmButtonText,
    String declineButtonText = '',
    Widget? headerIcon,
    double? buttonRadius,
  }) async {
    final result = await showDialog<dynamic>(
      context: context,
      barrierDismissible: false,
      barrierColor: context.colors.outline, // Light mode
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(24),
          ),
          backgroundColor: context.colors.onPrimary,
          scrollable: true,
          title: Center(
            child: Text(
              titleText,
              style: context.textThemes.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          content: SizedBox(
            width: 328,
            child: messageText.isNotEmpty
                ? Text(
                    messageText,
                    style: context.textThemes.bodyMedium,
                    textAlign: TextAlign.center,
                  )
                : null,
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            Row(
              spacing: 12,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (dialogType.isDeclinedButtonVisible)
                  Expanded(
                    flex: 1,
                    child: AppFilledButton(
                      title: declineButtonText,
                      borderRadius: buttonRadius,
                      color: context.colors.primary,
                      titleStyle: context.textThemes.titleSmall.copyWith(
                        color: context.colors.onSurface,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(DialogAction.declined);
                      },
                    ),
                  ),
                Expanded(
                  flex: 1,
                  child: AppFilledButton(
                    title: confirmButtonText,
                    borderRadius: buttonRadius,
                    titleStyle: context.textThemes.titleSmall.copyWith(
                      color: dialogType == DialogType.errorConfirmation
                          ? context.colors.onPrimary
                          : context.colors.onSurface,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(DialogAction.confirmed);
                    },
                    color: dialogType.getConfirmButtonColor(context),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );

    if (result is DialogAction) {
      return result;
    }
    return DialogAction.dismissed;
  }
}
