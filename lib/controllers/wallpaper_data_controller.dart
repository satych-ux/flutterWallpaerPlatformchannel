import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:satyam_wallpaper/models/wallpaper_model.dart';
import 'package:satyam_wallpaper/network/network_response.dart';

import '../network/network_class.dart';
import '../network/web_urls.dart';
import '../utils/common_methods.dart';
import '../utils/strings.dart';

class WallpaperDataController extends GetxController
    implements GetxService, NetworkResponse {
  bool _isLoading = true;
  PixelDataModel? _pixelDataModelLocal;
  List<Photos>? _listOfPhotosLocal;

  bool get isLoading => _isLoading;
  PixelDataModel? get pixelDataModelLocal => _pixelDataModelLocal;
  List<Photos>? get listOfPhotosLocal => _listOfPhotosLocal;

  Future<void> getPhotos(BuildContext context) async {
    NetworkClass(
            endPoint: WebUrl.curated,
            networkResponse: this,
            queryCode: WebUrl.curatedCode)
        .getApiService(context: context, showLoader: false);
  }

  @override
  Future<void> onResponse(
      {required requestCode,
      required response,
      required BuildContext context,
      required String message,
      required bool activeLoader}) async {
    switch (requestCode) {
      case WebUrl.curatedCode:
        CommonMethods.printSpecificLog(
            requestCode.toString(), response.toString());
        final pixelDataModel = pixelDataModelFromJson(response.toString());
        debugPrint(pixelDataModel.toString());

        _pixelDataModelLocal = pixelDataModel;
        _listOfPhotosLocal = _pixelDataModelLocal?.photos;

        _isLoading = false;
        update();
        break;
    }
  }

  @override
  Future<void> onError(
      {required requestCode,
      required response,
      required BuildContext context,
      required String message,
      required bool activeLoader}) async {
    switch (requestCode) {
      case WebUrl.curatedCode:
        CommonMethods.printSpecificLog(
            requestCode.toString(), response.toString());
        CommonMethods.showCustomSnackBar(Str.responseError);
        break;
    }
  }
}
