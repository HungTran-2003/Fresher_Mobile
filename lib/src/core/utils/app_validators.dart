import 'package:finance/src/core/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class AppValidators {
  const AppValidators._();

  static String? validateFullName(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.s.enterFullNameError;
    }
    return null;
  }

  static String? validateEmail(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.s.enterEmailError;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return context.s.enterValidEmailError;
    }
    return null;
  }

  static String? validateMobile(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.s.enterMobileNumberError;
    }
    return null;
  }

  static String? validateDateOfBirth(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.s.enterDobError;
    }
    return null;
  }

  static String? validatePassword(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.s.enterPasswordError;
    }
    if (value.length < 6) {
      return context.s.passwordLengthError;
    }
    return null;
  }

  static String? validateConfirmPassword(
    BuildContext context,
    String? value,
    String password,
  ) {
    if (value == null || value.trim().isEmpty) {
      return context.s.enterConfirmPasswordError;
    }
    if (value != password) {
      return context.s.passwordsDoNotMatchError;
    }
    return null;
  }

  static String? validateRequired(
    BuildContext context,
    String? value,
    String errorMsg,
  ) {
    if (value == null || value.trim().isEmpty) {
      return errorMsg;
    }
    return null;
  }
}
