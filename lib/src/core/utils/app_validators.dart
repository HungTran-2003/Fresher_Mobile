import 'package:crud_app/src/core/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class AppValidators {
  const AppValidators._();

  static String? validateTaxIdOrId(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.s.taxIdOrIdError;
    }
    final cleanValue = value.trim();
    // MST/CCCD: 12 digits or 10 digits (with optional -XXX suffix)
    final regex = RegExp(r'^(\d{12}|\d{10}(-\d{3})?)$');
    if (!regex.hasMatch(cleanValue)) {
      return context.s.taxIdOrIdError;
    }
    return null;
  }

  static String? validateUsername(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.s.usernameError;
    }
    return null;
  }

  static String? validateLoginPassword(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return context.s.passwordLengthError;
    }
    if (value.length < 6 || value.length > 50) {
      return context.s.passwordLengthError;
    }
    return null;
  }

  static String? validateProductName(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.s.nameRequired;
    }
    return null;
  }

  static String? validateProductCode(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.s.codeRequired;
    }
    return null;
  }

  static String? validatePrice(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.s.priceRequired;
    }
    final price = double.tryParse(value);
    if (price == null || price <= 0) {
      return context.s.pricePositive;
    }
    return null;
  }

  static String? validateStock(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.s.stockRequired;
    }
    final stock = int.tryParse(value);
    if (stock == null) {
      return context.s.stockOnlyInteger;
    }
    if (stock < 0) {
      return context.s.stockNonNegative;
    }
    return null;
  }
}
