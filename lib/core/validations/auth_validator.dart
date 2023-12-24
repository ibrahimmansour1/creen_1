import 'dart:developer';

import 'package:creen/core/utils/extensions/string.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;

class AuthValidator {
  static String? emailValidator(
    String? v, {
    bool isEmailRequired = true,
  }) {
    if (v!.isEmpty && isEmailRequired) {
      return 'email_required'.translate;
    }
    if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(v)) {
      return 'invalid_email'.translate;
    }
    return null;
  }

  static String? passwordConfirmationValidator(
    String? v, {
    required TextEditingController passwordController,
  }) {
    log('password_controller_data ${passwordController.text} $v ${passwordController.text.isNotEmpty}${(passwordController.text == v)}');
    if (v!.isEmpty && passwordController.text.isNotEmpty) {
      return 'password_confirmation_required'.translate;
    }
    if (passwordController.text.isNotEmpty && (passwordController.text != v)) {
      return 'password_mismatch'.translate;
    }
    return null;
  }

  static String? passwordValidator(String? v) {
    log('v is $v');
    if (v!.isEmpty) {
      return 'password_required'.translate;
    }
    return null;
  }

  static String? nameValidator(String? v) {
    if (v!.isEmpty) {
      return 'name_required'.translate;
    }
    return null;
  }

  static String? ageValidator(String? v) {
    if (v!.isEmpty) {
      return 'age_required'.translate;
    }
    return null;
  }

  static String? addressValidator(String? v) {
    if (v!.isEmpty) {
      return 'address_required'.translate;
    }
    return null;
  }

  static String? countryValidator(int? v) {
    if (v == null) {
      return 'country_required'.translate;
    }
    return null;
  }

  static String? cityValidator(int? v) {
    if (v == null) {
      return 'city_required'.translate;
    }
    return null;
  }

  static String? phoneValidator(String? value) {
    if (value!.isEmpty) {
      return 'phone_required'.translate;
    }

    if (value.length < 9 || value.length > 12) {
      return 'invalid_phone'.translate;
    }
    return null;
  }
}
