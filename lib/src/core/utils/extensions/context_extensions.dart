import 'package:crud_app/src/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../generated/l10n.dart';

extension BuildContextExt on BuildContext {
  /// Truy cập nhanh vào đối tượng đa ngôn ngữ [S]
  S get s => S.of(this);

  AppColorScheme get colors => AppTheme.of(this).appColorScheme;

  AppTextTheme get textThemes => AppTheme.of(this).appTextTheme;
}

extension SExt on S {
  String get languageCode => Intl.getCurrentLocale();
}
