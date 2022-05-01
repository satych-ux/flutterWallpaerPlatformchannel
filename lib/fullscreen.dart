import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:wallpaper_manager/wallpaper_manager.dart';

class FullScreen extends StatefulWidget {
  final String? imageurl;

  const FullScreen({Key? key, required this.imageurl}) : super(key: key);
  @override
  _FullScreenState createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  static const platform =
      MethodChannel('com.example.satyam_wallpaper/wallpaper');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: CachedNetworkImage(
                imageUrl: widget.imageurl.toString(),
              ),
            ),
          ),
          Container(
            height: 180,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    _wallpaperSet(1);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(15)),
                    height: 50,
                    width: 300,
                    child: const Center(
                      child: Text('Set Wallpaper',
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _wallpaperSet(2);
                  },
                  child: Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(15)),
                    child: const Center(
                      // ignore: unnecessary_const
                      child: Text('Set Lockscreen',
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _wallpaperSet(3);
                  },
                  child: Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(15)),
                    child: const Center(
                      // ignore: unnecessary_const
                      child: const Text('Set on both',
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _wallpaperSet(int whereToSetWallpaper) async {
    var file =
        await DefaultCacheManager().getSingleFile(widget.imageurl.toString());
    try {
      final int result = await platform
          .invokeMethod('setWallpaper', [file.path, whereToSetWallpaper]);
      debugPrint('Wallpaper set successfully $result');
    } on PlatformException catch (e) {
      debugPrint("issue in setting wp, failed !: '${e.message}'.");
    }
    Fluttertoast.showToast(
        msg: "Wallpaper set successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
    Navigator.pop(context);
  }
}
