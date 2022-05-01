import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satyam_wallpaper/controllers/wallpaper_data_controller.dart';
import 'package:satyam_wallpaper/widgets/loading_screen.dart';

import 'fullscreen.dart';

class Wallpaper extends StatefulWidget {
  @override
  _WallpaperState createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {
  List images = [];
  int page = 1;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Get.find<WallpaperDataController>().getPhotos(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<WallpaperDataController>(
      builder: (wallDataController) {
        return !wallDataController.isLoading
            ? Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                        itemCount:
                            wallDataController.listOfPhotosLocal?.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 2,
                                crossAxisCount: 3,
                                childAspectRatio: 2 / 3,
                                mainAxisSpacing: 2),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FullScreen(
                                          imageurl: wallDataController
                                              .listOfPhotosLocal![index]
                                              .src!
                                              .large2x
                                              .toString())));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(155),
                              ),
                              child: Image.network(
                                wallDataController
                                    .listOfPhotosLocal![index].src!.tiny
                                    .toString(),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }),
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     loadmore();
                  //   },
                  //   child: Container(
                  //     height: 60,
                  //     width: double.infinity,
                  //     color: Colors.greenAccent,
                  //     child: Center(
                  //       child: Text('Load More',
                  //           style:
                  //               TextStyle(fontSize: 20, color: Colors.white)),
                  //     ),
                  //   ),
                  // )
                ],
              )
            : const LoadingScreen();
      },
    ));
  }
}
