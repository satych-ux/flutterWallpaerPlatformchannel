import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:satyam_wallpaper/utils/strings.dart';

import '../utils/common_methods.dart';

import 'network_response.dart';
import 'web_urls.dart';
import 'package:http/http.dart' as http;

class NetworkClass {
  String endPoint;
  NetworkResponse networkResponse;
  dynamic queryCode;
  Map<String, Map<String, dynamic>> payload = {};
  AlertDialog alertDialog = const AlertDialog();
  bool isActiveLoader = false;
  final Map<String, String> defaultGetHeader = {
    "Content-Type": "application/json",
    'Authorization': '563492ad6f91700001000001549d8c7fd2e840b9b32069f7d081240c',
  };

  NetworkClass({
    required this.endPoint,
    required this.networkResponse,
    required this.queryCode,
  });

  NetworkClass.fromNetwork({
    required this.endPoint,
    required this.networkResponse,
    required this.queryCode,
    required this.payload,
  });

  Future<void> getApiService(
      {required BuildContext context, required bool showLoader}) async {
    debugPrint('here-----------------------');
    debugPrint('here-----------------------');
    debugPrint('here-----------------------');
    debugPrint('here-----------------------');
    debugPrint('here-----------------------');
    debugPrint('here-----------------------');
    debugPrint('here-----------------------');
    debugPrint('here-----------------------');

    if (showLoader) {
      isActiveLoader = true;
      showLoaderDialog(context);
    }
    CommonMethods.printSpecificLog("BaseUrl", endPoint);
    CommonMethods.printLog(WebUrl.baseUrl + endPoint);
    try {
      Uri uri = Uri.parse(WebUrl.baseUrl + endPoint);
      final response = await http
          .get(uri, headers: defaultGetHeader)
          .timeout(const Duration(seconds: 30));

      debugPrint('++++++++++++++++++here-----------------------');

      if (response.statusCode <= 201) {
        if (showLoader) {
          if (isActiveLoader) {
            isActiveLoader = false;
            Navigator.pop(context);
          }
        }
        networkResponse.onResponse(
            requestCode: queryCode,
            activeLoader: showLoader,
            context: context,
            response: response.body.toString(),
            message: Str.responseSuccess);
      } else {
        if (showLoader) {
          if (isActiveLoader) {
            isActiveLoader = false;
            Navigator.pop(context);
          }
        }
        networkResponse.onError(
            requestCode: queryCode,
            activeLoader: showLoader,
            context: context,
            response: response.body.toString(),
            message: Str.responseError);
      }
    } on SocketException catch (e) {
      if (showLoader) {
        isActiveLoader = false;
        Navigator.pop(context);
      }
      switch (e.osError!.errorCode) {
        case 7:
          NetworkResponse.onSocketException();
          break;
        case 111:
          NetworkResponse.onServerError();
          break;
        default:
          NetworkResponse.onServerError();
          break;
      }
    } on TimeoutException {
      if (showLoader) {
        isActiveLoader = false;
        Navigator.pop(context);
      }
      NetworkResponse.onTimeoutException();
    } catch (error) {
      if (showLoader) {
        isActiveLoader = false;
        Navigator.pop(context);
      }
      networkResponse.onError(
          requestCode: queryCode,
          activeLoader: showLoader,
          response: "",
          context: context,
          message: Str.responseError);
    }
  }

  Future<void> showLoaderDialog(BuildContext context) async {
    alertDialog = AlertDialog(
      elevation: 0,
      backgroundColor: Colors.white.withOpacity(0),
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(
            color: Colors.purple,
          )
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      barrierColor: Colors.white.withOpacity(0),
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }
}
