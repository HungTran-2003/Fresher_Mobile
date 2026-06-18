import 'package:flutter/material.dart';
import 'package:crud_app/src/core/utils/extensions/context_extensions.dart';

enum ProductSortFilter {
  defaultSort(null, null),
  nameAsc('name', 'asc'),
  nameDesc('name', 'desc'),
  priceAsc('price', 'asc'),
  priceDesc('price', 'desc'),
  stockAsc('stock', 'asc'),
  stockDesc('stock', 'desc'),
  updatedAtDesc('updated_at', 'desc');

  final String? sortBy;
  final String? sortOrder;
  const ProductSortFilter(this.sortBy, this.sortOrder);

  String getLabel(BuildContext context) {
    switch (this) {
      case ProductSortFilter.defaultSort:
        return context.s.defaultSort;
      case ProductSortFilter.nameAsc:
        return context.s.nameAsc;
      case ProductSortFilter.nameDesc:
        return context.s.nameDesc;
      case ProductSortFilter.priceAsc:
        return context.s.priceAsc;
      case ProductSortFilter.priceDesc:
        return context.s.priceDesc;
      case ProductSortFilter.stockAsc:
        return context.s.stockAsc;
      case ProductSortFilter.stockDesc:
        return context.s.stockDesc;
      case ProductSortFilter.updatedAtDesc:
        return context.s.updatedAtDesc;
    }
  }

  static ProductSortFilter fromValues(String? sortBy, String? sortOrder) {
    return ProductSortFilter.values.firstWhere(
      (e) => e.sortBy == sortBy && e.sortOrder == sortOrder,
      orElse: () => ProductSortFilter.defaultSort,
    );
  }
}
