
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants/color_const.dart';
void customSnackbar(String? title, String? subtitle, Color? bgColor,
    Color? textColor, IconData? logoIcon) {
  Get.snackbar(
    title ?? 'Notice', // Default title
    subtitle ?? '',    // Default subtitle
    snackPosition: SnackPosition.TOP,
    backgroundColor: bgColor ?? Colors.grey, // Default background color
    colorText: textColor ?? Colors.black,    // Default text color
    icon: logoIcon != null
        ? Icon(logoIcon, color: AppColors.onPrimary)
        : null, // Default or null icon
    duration: const Duration(seconds: 3), // Ensure duration is set
  );
}


