import 'package:flutter/material.dart';
import 'package:crud_app/src/core/utils/extensions/context_extensions.dart';

enum ProductStatusFilter {
  all(null),
  active(1),
  inactive(0);

  final int? value;
  const ProductStatusFilter(this.value);

  String getLabel(BuildContext context) {
    switch (this) {
      case ProductStatusFilter.all:
        return context.s.allStatuses;
      case ProductStatusFilter.active:
        return context.s.active;
      case ProductStatusFilter.inactive:
        return context.s.inactive;
    }
  }

  static ProductStatusFilter fromValue(int? value) {
    return ProductStatusFilter.values.firstWhere(
      (e) => e.value == value,
      orElse: () => ProductStatusFilter.all,
    );
  }
}
