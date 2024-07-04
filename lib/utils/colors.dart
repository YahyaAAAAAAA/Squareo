import 'package:Squareo/data/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

class CustomColors {
  CustomColors() {
    colorSwitch();
  }

  //bg colors
  Color mainColor1 = const Color(0xFF363C3F).withOpacity(0.5);

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
  void colorSwitch() {
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
    const Color.fromARGB(255, 247, 113, 135),
    const Color(0xFFF1DAB7),
    const Color.fromARGB(255, 36, 219, 226),
  ];

  //squares colors , (in strings cuz i'm scared of Hive)
  Color c = const Color(0xFF4CAF50);
  Color cc = const Color(0xFF81C784);
  Color ccc = const Color(0xFF388E3C);

  RxString wrongColor = "0xFFE3D3D3".obs;

  RxString green = "0xFF4CAF50 ".obs;
  RxString green300 = "0xFF81C784 ".obs;
  RxString green700 = "0xFF388E3C ".obs;

  RxString blue = "0xFF2196F3".obs;
  RxString blue300 = "0xFF64B5F6".obs;
  RxString blue700 = "0xFF1976D2".obs;

  RxString yellow = "0xFFFFEB3B".obs;
  RxString yellowAccent = "0xFFFFFF00".obs;
  RxString yellow200 = "0xFFFFF176".obs;

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

  RxString red = "0xFFF44336".obs;
  RxString red300 = "0xFFE57373".obs;
  RxString red700 = "0xFFD32F2F".obs;

  RxString white = "0xFF5B5B5B".obs;
  RxString turquoise = "0xFF40E0D0".obs;
}
