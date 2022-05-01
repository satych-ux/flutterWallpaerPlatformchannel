import 'package:flutter/material.dart';
import 'package:satyam_wallpaper/utils/strings.dart';

import '../utils/common_methods.dart';

class NetworkResponse {
  Future<void> onResponse(
      {required requestCode,
      required dynamic response,
      required BuildContext context,
      required String message,
      required bool activeLoader}) async {
    CommonMethods.printSpecificLog("Request $requestCode", Str.responseSuccess);
    CommonMethods.printLog(response.toString());
  }

  Future<void> onError(
      {required requestCode,
      required dynamic response,
      required BuildContext context,
      required String message,
      required bool activeLoader}) async {}

  static Future<void> onSocketException() async {
    CommonMethods.showCustomSnackBar(Str.onSocketExceptionMessage,
        isError: true);
  }

  static Future<void> onServerError() async {
    CommonMethods.showCustomSnackBar(Str.onServerErrorMessage,
        isError: true);
  }

  static Future<void> onTimeoutException() async {
    CommonMethods.showCustomSnackBar(Str.onTimeoutExceptionMessage,
        isError: true);
  }
}
