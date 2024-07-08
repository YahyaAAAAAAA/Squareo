import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:Squareo/pages/home_page.dart';
import 'package:flutter/services.dart';

void main() async {
  //init the Hive

  await Hive.initFlutter();

  // WidgetsFlutterBinding.ensureInitialized();

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
