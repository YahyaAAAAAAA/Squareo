import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:Squareo/pages/home_page.dart';
import 'package:flutter/services.dart';

void main() async {
  //init the Hive

  await Hive.initFlutter();

  // WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(500, 837),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
    windowButtonVisibility: false,
    maximumSize: Size(500, 837),
    minimumSize: Size(500, 837),
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  //opne a box
  await Hive.openBox('myBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //set orientations
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    //root
    return GetMaterialApp(
      home: HomePage(),
      theme: ThemeData(
          bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.transparent,
      )),
    );
  }
}
