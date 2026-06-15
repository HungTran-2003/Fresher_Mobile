import 'package:finance/src/core/assets/app_vectors.dart';
import 'package:finance/src/presentation/widgets/images/app_svg_image.dart';
import 'package:flutter/material.dart';

class CategoryUtils {
  static Widget getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'ic_car':
        return AppSvgImage(
          AppVectors.icCar,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        );
      case 'ic_food':
        return AppSvgImage(
          AppVectors.icFood,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        );
      case 'ic_rent':
        return AppSvgImage(
          AppVectors.icRent,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        );
      case 'ic_gift':
        return AppSvgImage(
          AppVectors.icGift,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        );
      case 'ic_house':
        return AppSvgImage(
          AppVectors.icHouse,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        );
      case 'ic_money':
        return AppSvgImage(
          AppVectors.icMoney,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        );
      case 'ic_saving':
        return AppSvgImage(
          AppVectors.icSaving,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        );
      case 'ic_tourism':
        return AppSvgImage(
          AppVectors.icTourism,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        );
      case 'ic_wedding':
        return AppSvgImage(
          AppVectors.icWedding,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        );
      case 'ic_medicine':
        return AppSvgImage(
          AppVectors.icMedicine,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        );
      case 'ic_shopping':
        return AppSvgImage(
          AppVectors.icShopping,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        );
      case 'ic_transport':
        return AppSvgImage(
          AppVectors.icTransport,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        );
      case 'ic_protection':
        return AppSvgImage(
          AppVectors.icProtection,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        );
      case 'ic_entertainment':
        return AppSvgImage(
          AppVectors.icEntertainment,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        );
      default:
        return AppSvgImage(
          AppVectors.icMoney,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        );
    }
  }
}
