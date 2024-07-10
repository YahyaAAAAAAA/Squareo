import 'package:Squareo/data/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

class CustomColors {
  CustomColors() {
    themeSwitch();
  }

  //bg colors
  Color mainColor1 = const Color(0xFF3F3E36).withOpacity(0.5);

  Color mainColor2 = const Color.fromARGB(255, 41, 46, 48);

  Color textColor = const Color.fromARGB(255, 255, 255, 255);

  Color bgSheetColor = const Color.fromARGB(255, 39, 44, 46);

  List<MeshGradientPoint> points = [
    MeshGradientPoint(
      position: const Offset(
        0,
        1,
      ),
      color: const Color(0xFFDDD9D7),
    ),
    MeshGradientPoint(
      position: const Offset(
        0,
        1,
      ),
      color: const Color.fromARGB(255, 23, 144, 148),
    ),
    MeshGradientPoint(
      position: const Offset(
        1,
        1,
      ),
      color: const Color.fromARGB(255, 185, 88, 104),
    ),
    MeshGradientPoint(
      position: const Offset(
        0.5,
        0,
      ),
      color: const Color.fromARGB(255, 149, 110, 73),
    ),
  ];

  List<MeshGradientPoint> pointsLight = [
    MeshGradientPoint(
      position: const Offset(
        0,
        1,
      ),
      color: const Color(0xFFDDD9D7),
    ),
    MeshGradientPoint(
      position: const Offset(
        0,
        1,
      ),
      color: const Color.fromARGB(255, 23, 144, 148),
    ),
    MeshGradientPoint(
      position: const Offset(
        1,
        1,
      ),
      color: const Color.fromARGB(255, 185, 88, 104),
    ),
    MeshGradientPoint(
      position: const Offset(
        0.5,
        0,
      ),
      color: const Color.fromARGB(255, 149, 110, 73),
    ),
  ];

  List<MeshGradientPoint> poinstDark = [
    MeshGradientPoint(
      position: const Offset(
        0,
        1,
      ),
      color: const Color(0xFF585756),
    ),
    MeshGradientPoint(
      position: const Offset(
        0,
        1,
      ),
      color: const Color(0xFF093A3B),
    ),
    MeshGradientPoint(
      position: const Offset(
        1,
        1,
      ),
      color: const Color(0xFF4A232A),
    ),
    MeshGradientPoint(
      position: const Offset(
        0.5,
        0,
      ),
      color: const Color(0xFF3C2C1D),
    ),
  ];

  //database
  final _myBox = Hive.box('myBox');
  Database db = Database();

  //checks for theme
  void themeSwitch() {
    //check theme value for the first time run
    if (_myBox.get("THEME") == null) {
      db.createInitialDataTheme();
    } else {
      db.loadDataTheme();
    }

    //decides the theme
    if (db.themeSwitch == 0) {
      mainColor1 = const Color(0xFF363C3F).withOpacity(0.5);
      mainColor2 = const Color.fromARGB(255, 41, 46, 48);
      textColor = const Color.fromARGB(255, 255, 255, 255);
      bgSheetColor = const Color.fromARGB(255, 39, 44, 46);
      points = [
        MeshGradientPoint(
          position: const Offset(
            0,
            1,
          ),
          color: const Color(0xFFDDD9D7),
        ),
        MeshGradientPoint(
          position: const Offset(
            0,
            1,
          ),
          color: const Color(0xFF179094),
        ),
        MeshGradientPoint(
          position: const Offset(
            1,
            1,
          ),
          color: const Color(0xFFB95868),
        ),
        MeshGradientPoint(
          position: const Offset(
            0.5,
            0,
          ),
          color: const Color(0xFF956E49),
        ),
      ];
    } else if (db.themeSwitch == 1) {
      mainColor1 = const Color(0xFF363C3F).withOpacity(0.5);
      mainColor2 = const Color.fromARGB(255, 41, 46, 48);
      textColor = const Color.fromARGB(255, 255, 255, 255);
      bgSheetColor = const Color.fromARGB(255, 39, 44, 46);
      points = [
        MeshGradientPoint(
          position: const Offset(
            0,
            1,
          ),
          color: const Color(0xFF585756),
        ),
        MeshGradientPoint(
          position: const Offset(
            0,
            1,
          ),
          color: const Color(0xFF093A3B),
        ),
        MeshGradientPoint(
          position: const Offset(
            1,
            1,
          ),
          color: const Color(0xFF4A232A),
        ),
        MeshGradientPoint(
          position: const Offset(
            0.5,
            0,
          ),
          color: const Color(0xFF3C2C1D),
        ),
      ];
    }
  }

  //used as the lock icon bg color (not used anymore)
  Color lockColor = Colors.red.shade700;
  Color unlockColor = Colors.green.shade700;

  Color transparent = Colors.transparent;

  //shop items ranks
  Color uncommon = Colors.green;
  Color rare = Colors.blue;
  Color epic = Colors.purple;
  Color legendary = Colors.yellow;

  List<Color> gradesColor = [
    Colors.grey.shade100,
    const Color(0xFFEEEEEE),
    Colors.grey.shade300,
    Colors.grey.shade400,
  ];

  List<Color> aPlus = [
    const Color(0xFFFFD700),
    const Color(0xFFE6E200),
    const Color(0xFFEBE809),
    const Color(0xFFB39700),
  ];

  List<Color> aPlusTries = [
    const Color(0xFFF77187),
    const Color(0xFFF1DAB7),
    const Color(0xFF24DBE2),
  ];

  //squares colors , (in strings cuz i'm scared of Hive)
  Color c = Colors.brown;
  Color cc = Colors.brown.shade300;
  Color ccc = Colors.brown.shade700;
  Color cccc = Colors.brown.shade900;

  RxString wrongColor = "0xFFE3D3D3".obs;

  RxString neonYellow = "0xFFFFFF00".obs;
  RxString neonRed = "0xFFFF0000".obs;
  RxString neonGreen = "0xFF00FF00".obs;
  RxString neonLightBlue = "0xFF00FFFF".obs;
  RxString neonPink = "0xFFFF00FF".obs;
  RxString neonPurple = "0xFF9D00FF".obs;
  RxString neonOrange = "0xFFFF6600".obs;
  RxString neonBlue = "0xFF0033FF".obs;

  RxString lima = "0xFF68BE25".obs;
  RxString lima300 = "0xFF95D266".obs;
  RxString lima700 = "0xFF3E7216".obs;

  RxString jungle = "0xFF25BE9A".obs;
  RxString jungle300 = "0xFF66D2B8".obs;
  RxString jungle700 = "0xFF16725C".obs;

  RxString violet = "0xFFBE25A5".obs;
  RxString violet300 = "0xFFD266C0".obs;
  RxString violet700 = "0xFF721663".obs;

  RxString prim_1 = "0xFFF77187".obs;
  RxString prim_2 = "0xFFF1DAB7".obs;
  RxString prim_3 = "0xFF24DBE2".obs;

  RxString lightBlue = "0xFF03A9F4 ".obs;
  RxString lightBlue300 = "0xFF4FC3F7 ".obs;
  RxString lightBlue700 = "0xFF0288D1 ".obs;

  RxString indigo = "0xFF3F51B5 ".obs;
  RxString indigo300 = "0xFF7986CB ".obs;
  RxString indigo700 = "0xFF303F9F ".obs;

  RxString deepPurple = "0xFF673AB7 ".obs;
  RxString deepPurple300 = "0xFF9575CD ".obs;
  RxString deepPurple700 = "0xFF512DA8 ".obs;

  RxString cyan = "0xFF00BCD4 ".obs;
  RxString cyan300 = "0xFF4DD0E1 ".obs;
  RxString cyan700 = "0xFF0097A7 ".obs;

  RxString green = "0xFF4CAF50 ".obs;
  RxString green300 = "0xFF81C784 ".obs;
  RxString green700 = "0xFF388E3C ".obs;

  RxString blue = "0xFF2196F3".obs;
  RxString blue300 = "0xFF64B5F6".obs;
  RxString blue700 = "0xFF1976D2".obs;

  RxString yellow = "0xFFFFEB3B".obs;
  RxString yellow200 = "0xFFFFF176".obs;

  RxString yellowAccent = "0xFFFFFF00".obs;
  RxString yellowAccent400 = "0xFFFFEA00".obs;

  RxString purple = "0xFF9C27B0".obs;
  RxString purple300 = "0xFFBA68C8".obs;
  RxString purple700 = "0xFF7B1FA2".obs;

  RxString amber = "0xFFFFC107".obs;
  RxString amber700d = "0xFFFFA000".obs;
  RxString amberAccent = "0xFFFFD740".obs;

  RxString teal = "0xFF009688".obs;
  RxString teal300 = "0xFF4DB6AC".obs;
  RxString teal700 = "0xFF00796B".obs;

  RxString tealAccent = "0xFF64FFDA".obs;
  RxString tealAccent300 = "0xFF1DE9B6".obs;
  RxString tealAccent700 = "0xFF00BFA5".obs;

  RxString red = "0xFFF44336".obs;
  RxString red300 = "0xFFE57373".obs;
  RxString red700 = "0xFFD32F2F".obs;

  RxString mexRed = "0xFF9F2C23".obs;
  RxString mexRed300 = "0xFFB2564F".obs;
  RxString mexRed700 = "0xFF5F1A15".obs;

  RxString scarlet = "0xFFFA1200".obs;
  RxString scarlet300 = "0xFFFEB8B3".obs;
  RxString scarlet700 = "0xFFC80E00".obs;

  RxString orange = "0xFFFF9800".obs;
  RxString orange300 = "0xFFF57C00".obs;
  RxString orange700 = "0xFFFFB74D".obs;

  RxString deepOrange = "0xFFFF5722".obs;
  RxString deepOrange300 = "0xFFFF8A65".obs;
  RxString deepOrange700 = "0xFFE64A19".obs;

  RxString pink = "0xFFE91E63".obs;
  RxString pink300 = "0xFFF06292".obs;
  RxString pink700 = "0xFFC2185B".obs;

  RxString black = "0xFF404040".obs;
  RxString black300 = "0xFF5B5B5B".obs;
  RxString black700 = "0xFF242424".obs;

  RxString turquoise = "0xFF40E0D0".obs;
  RxString turquoise700 = "0xFF2D9D92".obs;
  RxString turquoise300 = "0xFF79E9DE".obs;

  RxString lochinvar = "0xFF77A09C".obs;
  RxString lochinvar700 = "0xFF1C615A".obs;
}
