import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonMethods {
  static Future<void> printLog(String content) async {
    log("Log :====> $content");
  }

  static Future<void> printSpecificLog(String logName, String content) async {
    log("$logName :====> $content");
  }

  static Future<void> showCustomSnackBar(String message,
      {bool isError = false}) async {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: isError ? Colors.red : Get.theme.colorScheme.secondary,
      message: message,
      duration: const Duration(seconds: 3),
      snackStyle: SnackStyle.FLOATING,
      margin: const EdgeInsets.all(4.0),
      borderRadius: 4.0,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    ));
  }
}
