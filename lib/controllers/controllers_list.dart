import 'package:get/get.dart';
import 'package:satyam_wallpaper/controllers/wallpaper_data_controller.dart';

class Controllers{
  static Future<void> getInit() async {
    Get.put(WallpaperDataController());
  }
}
