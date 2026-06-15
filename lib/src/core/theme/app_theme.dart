import 'package:crud_app/src/core/dimensions/app_color.dart';
import 'package:crud_app/src/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_system_ui.dart';

part 'interface/app_theme_interface.dart';
part 'app_theme_data.dart';

class AppTheme extends InheritedWidget {
  const AppTheme({super.key, required this.theme, required super.child});

  final AppThemeData theme;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return oldWidget is AppTheme && oldWidget.theme != theme;
  }

  static AppThemeData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppTheme>()!.theme;
  }
}
