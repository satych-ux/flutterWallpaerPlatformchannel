import 'package:flutter/material.dart';
import 'package:satyam_wallpaper/wallpaper.dart';

import 'controllers/controllers_list.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Controllers.getInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light),
      home: Wallpaper(),
    );
  }
}
