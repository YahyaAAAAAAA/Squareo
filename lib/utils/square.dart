import 'dart:async';
import 'package:Squareo/compnents/custom_icons.dart';
import 'package:Squareo/compnents/gradient_text.dart';
import 'package:Squareo/compnents/square_clipper.dart';
import 'package:Squareo/pages/levels/levels_11_20/level_11.dart';
import 'package:Squareo/pages/levels/levels_11_20/level_12.dart';
import 'package:Squareo/pages/levels/levels_11_20/level_13.dart';
import 'package:Squareo/pages/levels/levels_11_20/level_14.dart';
import 'package:Squareo/pages/levels/levels_11_20/level_15.dart';
import 'package:Squareo/pages/levels/levels_11_20/level_16.dart';
import 'package:Squareo/pages/levels/levels_11_20/level_17.dart';
import 'package:Squareo/pages/levels/levels_11_20/level_18.dart';
import 'package:Squareo/pages/levels/levels_11_20/level_19.dart';
import 'package:Squareo/pages/levels/levels_11_20/level_20.dart';
import 'package:Squareo/pages/levels/leves_21_30/level_21.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:numeral/numeral.dart';
import 'package:Squareo/data/database.dart';
import 'package:Squareo/utils/colors.dart';
import 'package:Squareo/pages/levels/levels_1_10/level_1.dart';
import 'package:Squareo/pages/levels/levels_1_10/level_10.dart';
import 'package:Squareo/pages/levels/levels_1_10/level_2.dart';
import 'package:Squareo/pages/levels/levels_1_10/level_3.dart';
import 'package:Squareo/pages/levels/levels_1_10/level_4.dart';
import 'package:Squareo/pages/levels/levels_1_10/level_5.dart';
import 'package:Squareo/pages/levels/levels_1_10/level_6.dart';
import 'package:Squareo/pages/levels/levels_1_10/level_7.dart';
import 'package:Squareo/pages/levels/levels_1_10/level_8.dart';
import 'package:Squareo/pages/levels/levels_1_10/level_9.dart';
import 'package:Squareo/pages/levels_page.dart';
import 'package:vertical_percent_indicator/vertical_percent_indicator.dart';

class Square {
  //to access colors easily
  CustomColors c = CustomColors();

  //to displays words rather than the timer numbers
  List<String> dialogTexts = ["circle_1", "circle_3", "circle_2", "circle_1"];
  List<Color> dialogColors_2 = [
    const Color.fromARGB(255, 149, 110, 73),
    const Color.fromARGB(255, 149, 110, 73),
    const Color.fromARGB(255, 185, 88, 104),
    const Color.fromARGB(255, 23, 144, 148),
  ];

  //set to true after initState finishes , this enables the user to reorder the list
  bool activeDrag = false;

  //temp value for testing
  bool numbersFlag = false;

  //temp value for testing dialogs barrier
  bool barrierDismiss = false;

  //display dialog after winning
  bool showDialogFlag = false;

  //display a lock icon till last move it changes it to unlock
  bool unlockFlag = false;

  //! total levels made (currently 12) change till 30
  int totalLevels = 17;

  //for comparing best grade
  List<String> grades = [
    'A+',
    'A',
    'A-',
    'B+',
    'B',
    'B-',
    'C+',
    'C',
    'C-',
    'D',
  ];

  //timer of 3 seconds
  late Timer timer;

  AudioPlayer player = AudioPlayer();

  //have local database
  final _myBox = Hive.box('myBox');
  Database db = Database();

  ///method to start a timer of 3 seconds -> goes to [showAlert] after that both are disposed
  void startTimer(BuildContext context, int start) {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          timer.cancel();
        } else {
          start--;
          //! temp (comment out while testing new level)
          Navigator.of(context).pop();
          showAlert(context, start);
        }
      },
    );
  }

  //show a dialog that is a timer of 3 seconds to start the movements of the cubes , must always be dissmissable
  void showAlert(BuildContext context, int start) {
    if (start == 0) {
      //play start sound
      playSound('count_end');
      return;
    } else {
      //play ready sound
      playSound('count');
      showGeneralDialog(
        context: context,
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: PopScope(
                canPop: false,
                child: Dialog(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: dialogColors_2[start],
                        radius: 60,
                        child: Image.asset(
                          'assets/images/${dialogTexts[start]}.png',
                          height: 110,
                          width: 110,
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            start.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: c.textColor,
                              fontSize: 30,
                              fontFamily: 'PlaywritePL',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: false,
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return const SizedBox();
        },
      );
    }
  }

  ///shows a dialog indicating a player won the level , from it you can go back to [levelsPage] , or [nextLevel]
  void showWinAlert(BuildContext context, int index,
      {var time = 0, var steps = 0, int coins = 0, String grade = ''}) {
    showGeneralDialog(
      context: context,
      barrierDismissible: barrierDismiss,
      transitionBuilder: (context, a1, a2, widget) {
        print(MediaQuery.of(context).size.width / 1.2);
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: PopScope(
              canPop: false,
              child: Dialog(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: 373,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.transparent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //tropy icon
                        Container(
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            color: c.mainColor1.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(60),
                            border: Border.all(
                              width: 1.5,
                              color: c.textColor,
                            ),
                          ),
                          child: Icon(
                            CustomIcons.trophy_star,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                        SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                color: c.mainColor1.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  //go back,restart,next buttons
                                  Container(
                                    width: 55,
                                    height: 55,
                                    decoration: BoxDecoration(
                                      color: c.mainColor1.withOpacity(1),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: TextButton(
                                      onPressed: () => backToMenu(context),
                                      style: ButtonStyle(
                                        shape: WidgetStatePropertyAll<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                        ),
                                        overlayColor: WidgetStatePropertyAll(
                                          c.textColor.withOpacity(0.2),
                                        ),
                                      ),
                                      child: FittedBox(
                                        child: Icon(
                                          CustomIcons.left,
                                          color: c.textColor,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 55,
                                    height: 55,
                                    decoration: BoxDecoration(
                                      color: c.mainColor1.withOpacity(1),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: TextButton(
                                      onPressed: () =>
                                          nextLevel(context, index - 1),
                                      style: ButtonStyle(
                                        shape: WidgetStatePropertyAll<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                        ),
                                        overlayColor: WidgetStatePropertyAll(
                                          c.textColor.withOpacity(0.2),
                                        ),
                                      ),
                                      child: FittedBox(
                                        child: Icon(
                                          CustomIcons.refresh,
                                          color: c.textColor,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 55,
                                    height: 55,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: c.mainColor1.withOpacity(1),
                                    ),
                                    child: TextButton(
                                      onPressed: () =>
                                          nextLevel(context, index),
                                      style: ButtonStyle(
                                        shape: WidgetStatePropertyAll<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                        ),
                                        overlayColor: WidgetStatePropertyAll(
                                          c.textColor.withOpacity(0.2),
                                        ),
                                      ),
                                      child: FittedBox(
                                        child: Icon(
                                          CustomIcons.right,
                                          color: c.textColor,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //time,moves,coins,grade display
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: c.mainColor1.withOpacity(1),
                                borderRadius: BorderRadius.circular(12),
                                //gradient: pinkGradient(),
                              ),
                              child: FittedBox(
                                child: TextButton.icon(
                                  onPressed: null,
                                  icon: Icon(
                                    CustomIcons.duration_alt,
                                    color: c.textColor,
                                    size: 20,
                                  ),
                                  label: RichText(
                                    text: TextSpan(
                                      text: 'Time : ${time.toString()} seconds',
                                      children: [
                                        TextSpan(
                                          text: db.scores[index - 2][0] > time
                                              ? '\nNew Best ★'
                                              : '',
                                          style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 213, 213, 213),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            fontFamily: 'Abel',
                                          ),
                                        ),
                                      ],
                                      style: TextStyle(
                                        color: c.textColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        fontFamily: 'Abel',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: c.mainColor1.withOpacity(1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: FittedBox(
                                child: TextButton.icon(
                                  onPressed: null,
                                  icon: Icon(
                                    CustomIcons.shoe_prints,
                                    color: c.textColor,
                                    size: 20,
                                  ),
                                  label: RichText(
                                    text: TextSpan(
                                      text: 'Moves : ${steps.toString()}',
                                      children: [
                                        TextSpan(
                                          text: db.scores[index - 2][1] >
                                                  steps.value
                                              ? '\nNew Best ★'
                                              : '',
                                          style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 213, 213, 213),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            fontFamily: 'Abel',
                                          ),
                                        ),
                                      ],
                                      style: TextStyle(
                                        color: c.textColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        fontFamily: 'Abel',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: c.mainColor1.withOpacity(1),
                                borderRadius: BorderRadius.circular(12),
                                //gradient: pinkGradient(),
                              ),
                              child: FittedBox(
                                child: TextButton.icon(
                                  onPressed: null,
                                  icon: Icon(
                                    CustomIcons.usd_square,
                                    color: c.textColor,
                                    size: 20,
                                  ),
                                  label: Text(
                                    ' +${coins.beautiful.toString()}',
                                    style: TextStyle(
                                        color: c.textColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        fontFamily: 'Abel'),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: c.mainColor1.withOpacity(1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: FittedBox(
                                child: TextButton.icon(
                                  onPressed: null,
                                  icon: Icon(
                                    CustomIcons.splotch,
                                    color: c.textColor,
                                    size: 20,
                                  ),
                                  label: GradientText(
                                    grade,
                                    style: TextStyle(
                                      color: c.textColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      fontFamily: 'PlaywritePL',
                                    ),
                                    gradient: LinearGradient(
                                      colors: grade == 'A+' &&
                                              db.scores[index - 2][3] == 1
                                          ? c.aPlusTries
                                          : grade == 'A+'
                                              ? c.aPlus
                                              : c.gradesColor,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: grades.indexOf(grade) <
                                                grades.indexOf(
                                                    db.scores[index - 2][2])
                                            ? '\nNew Best ★'
                                            : '',
                                        style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 213, 213, 213),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          fontFamily: 'Abel',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierLabel: '',
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return const SizedBox();
      },
    );
  }

  //method to go back to menu called by multiable widgets,methods
  void backToMenu(BuildContext context) {
    Get.offAll(() => LevelsPage(), transition: Transition.size);
  }

  ///shows a dialog to go back to [levelsPage], located in the app bar
  void appBarBackToMenu(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: Dialog(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        backToMenu(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: c.mainColor1.withOpacity(0.7),
                          border: Border.all(width: 1.5, color: c.textColor),
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: const Icon(
                          CustomIcons.left,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(
                        color: c.mainColor1.withOpacity(1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextButton(
                        onPressed: () {
                          backToMenu(context);
                        },
                        child: FittedBox(
                          child: Text(
                            'Back to Menu',
                            style: TextStyle(
                              color: c.textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        style: ButtonStyle(
                          shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          overlayColor: WidgetStatePropertyAll(
                            c.textColor.withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierLabel: '',
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return const SizedBox();
      },
    );
  }

  //shows a dialog asking to skip a level ? this calles (nextLevel)
  void showSkipAlert(BuildContext context, int index) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: Dialog(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () => nextLevel(context, index),
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: c.mainColor1.withOpacity(0.7),
                          border: Border.all(width: 1.5, color: c.textColor),
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: const Icon(
                          CustomIcons.right,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(
                        color: c.mainColor1.withOpacity(1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextButton(
                        onPressed: () => nextLevel(context, index),
                        style: ButtonStyle(
                          shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          overlayColor: WidgetStatePropertyAll(
                              c.textColor.withOpacity(0.2)),
                        ),
                        child: FittedBox(
                          child: Text(
                            'Skip Level',
                            style: TextStyle(
                              color: c.textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierLabel: '',
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return const SizedBox();
      },
    );
  }

  //shows a dialog to restart current level
  void showRestartAlert(BuildContext context, int index) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: Dialog(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () => nextLevel(context, index - 1),
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: c.mainColor1.withOpacity(0.7),
                          border: Border.all(width: 1.5, color: c.textColor),
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: const Icon(
                          CustomIcons.refresh,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(
                        color: c.mainColor1.withOpacity(1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextButton(
                        onPressed: () => nextLevel(context, index - 1),
                        child: FittedBox(
                          child: Text(
                            'Restart Level',
                            style: TextStyle(
                              color: c.textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        style: ButtonStyle(
                          shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          overlayColor: WidgetStatePropertyAll(
                            c.textColor.withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierLabel: '',
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return const SizedBox();
      },
    );
  }

  //gradient , might change later ? (not used anymore)
  LinearGradient winAlertGradient() {
    return LinearGradient(
      // begin: Alignment.topLeft,
      // end: Alignment.bottomRight,
      colors: [
        c.mainColor1,
        c.mainColor1,
      ],
    );
  }

  //shows the actual scaffold dialog with the ui , the onTap ui is seperate .
  void showScafflodSheet(
      BuildContext context, VoidCallback localSkipLevel, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 200,
          child: Container(
            decoration: BoxDecoration(
              color: c.bgSheetColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 350,
                    height: MediaQuery.of(context).size.height / 400,
                    decoration: BoxDecoration(
                      color: c.textColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(40),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: c.mainColor2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            color: c.mainColor1,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                            onPressed: () => appBarBackToMenu(context),
                            child: Icon(
                              CustomIcons.house_blank,
                              color: c.textColor,
                              size: 25,
                            ),
                            style: ButtonStyle(
                              shape: WidgetStatePropertyAll<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              overlayColor: WidgetStatePropertyAll(
                                c.textColor.withOpacity(0.2),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            color: c.mainColor1,
                            //border: Border.all(width: 3, color: c.textColor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                            onPressed: () => showRestartAlert(context, index),
                            child: Icon(
                              CustomIcons.refresh,
                              color: c.textColor,
                              size: 25,
                            ),
                            style: ButtonStyle(
                              shape: WidgetStatePropertyAll<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              overlayColor: WidgetStatePropertyAll(
                                  c.textColor.withOpacity(0.2)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            color: c.mainColor1,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                            onPressed: localSkipLevel,
                            child: Icon(
                              CustomIcons.right,
                              color: c.textColor,
                              size: 25,
                            ),
                            style: ButtonStyle(
                              shape: WidgetStatePropertyAll<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              overlayColor: WidgetStatePropertyAll(
                                  c.textColor.withOpacity(0.2)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //show a bar chart about grades (in scores page)
  Future<Object?> showBarChartDialog(BuildContext context, List<double> counts,
      List<Color>? colors, TextStyle textStyle) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 200),
      barrierLabel: '',
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              content: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: c.mainColor2,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          // alignment: Alignment.centerLeft,
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(c.mainColor1),
                            overlayColor: WidgetStatePropertyAll(
                              c.textColor.withOpacity(0.2),
                            ),
                          ),
                          icon: Icon(
                            Icons.clear,
                            color: c.textColor,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Total Grades',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: c.textColor,
                              fontFamily: 'Abel',
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: c.textColor,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        //this just so i can center the title (i'm sorry im so tired this the best i can come up with)
                        IconButton(
                          onPressed: null,
                          // alignment: Alignment.centerLeft,
                          icon: Icon(
                            null,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        VerticalBarIndicator(
                          percent: counts[0] / totalLevels,
                          header: counts[0].toInt().toString(),
                          width: 30,
                          footerStyle: textStyle,
                          headerStyle: textStyle,
                          footer: 'A+',
                          circularRadius: 12,
                          color: colors,
                        ),
                        VerticalBarIndicator(
                          percent: counts[1] / totalLevels,
                          header: counts[1].toString()[0],
                          width: 30,
                          headerStyle: textStyle,
                          footerStyle: textStyle,
                          footer: 'A',
                          circularRadius: 12,
                          color: colors,
                        ),
                        VerticalBarIndicator(
                          percent: counts[2] / totalLevels,
                          header: counts[2].toString()[0],
                          width: 30,
                          headerStyle: textStyle,
                          footerStyle: textStyle,
                          footer: 'A-',
                          circularRadius: 12,
                          color: colors,
                        ),
                      ],
                    ),
                    Divider(color: c.textColor, height: 1.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        VerticalBarIndicator(
                          width: 30,
                          percent: counts[3] / totalLevels,
                          header: counts[3].toString()[0],
                          headerStyle: textStyle,
                          footerStyle: textStyle,
                          footer: 'B+',
                          circularRadius: 12,
                          color: colors,
                        ),
                        VerticalBarIndicator(
                          percent: counts[4] / totalLevels,
                          header: counts[4].toString()[0],
                          width: 30,
                          headerStyle: textStyle,
                          footerStyle: textStyle,
                          footer: 'B',
                          circularRadius: 12,
                          color: colors,
                        ),
                        VerticalBarIndicator(
                          percent: counts[5] / totalLevels,
                          header: counts[5].toString()[0],
                          width: 30,
                          headerStyle: textStyle,
                          footerStyle: textStyle,
                          footer: 'B-',
                          circularRadius: 12,
                          color: colors,
                        ),
                      ],
                    ),
                    Divider(color: c.textColor, height: 1.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        VerticalBarIndicator(
                          width: 30,
                          percent: counts[6] / totalLevels,
                          header: counts[6].toString()[0],
                          headerStyle: textStyle,
                          footerStyle: textStyle,
                          footer: 'C+',
                          circularRadius: 12,
                          color: colors,
                        ),
                        VerticalBarIndicator(
                          percent: counts[7] / totalLevels,
                          header: counts[7].toString()[0],
                          width: 30,
                          headerStyle: textStyle,
                          footerStyle: textStyle,
                          footer: 'C',
                          circularRadius: 12,
                          color: colors,
                        ),
                        VerticalBarIndicator(
                          percent: counts[8] / totalLevels,
                          header: counts[8].toString()[0],
                          width: 30,
                          headerStyle: textStyle,
                          footerStyle: textStyle,
                          footer: 'C-',
                          circularRadius: 12,
                          color: colors,
                        ),
                        VerticalBarIndicator(
                          percent: counts[9] / totalLevels,
                          header: counts[9].toString()[0],
                          width: 30,
                          headerStyle: textStyle,
                          footerStyle: textStyle,
                          footer: 'D',
                          circularRadius: 12,
                          color: colors,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return const SizedBox();
      },
    );
  }

  //show time,moves,grades average (in scores page)
  Future<Object?> showAverageDialog(BuildContext context, int timeAvg,
      int movesAvg, String gradesAvg, TextStyle textStyle) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 200),
      barrierLabel: '',
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              content: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: c.mainColor2,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //title row
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          // alignment: Alignment.centerLeft,
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(c.mainColor1),
                            overlayColor: WidgetStatePropertyAll(
                              c.textColor.withOpacity(0.2),
                            ),
                          ),
                          icon: Icon(
                            Icons.clear,
                            color: c.textColor,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Average Scores',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: c.textColor,
                              fontFamily: 'Abel',
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: c.textColor,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        //this just so i can center the title (i'm sorry im so tired this the best i can come up with)
                        IconButton(
                          onPressed: null,
                          // alignment: Alignment.centerLeft,
                          icon: Icon(
                            null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextButton.icon(
                      onPressed: null,
                      label: Text(
                        'Average Time : $timeAvg seconds',
                        style: textStyle,
                      ),
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(c.mainColor1),
                        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      icon: Icon(
                        CustomIcons.duration_alt,
                        color: c.textColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton.icon(
                      onPressed: null,
                      label: Text(
                        'Average Moves : $movesAvg',
                        style: textStyle,
                      ),
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(c.mainColor1),
                        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      icon: Icon(
                        CustomIcons.shoe_prints,
                        color: c.textColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton.icon(
                      onPressed: null,
                      label: Text(
                        'Average Grade : $gradesAvg',
                        style: textStyle,
                      ),
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(c.mainColor1),
                        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      icon: Icon(
                        CustomIcons.splotch,
                        color: c.textColor,
                        size: 20,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return const SizedBox();
      },
    );
  }

  //responsible for generating the (INDIVIDUAL) squares in the main grid
  List<Widget> generateSquares(List fruits) {
    final generatedChildren = List.generate(
      fruits.length,
      (index) => AnimatedContainer(
        width: 50,
        height: 50,
        key: Key(fruits[index][0].toString()),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(db.squaresBorderRadius),
          color: Color(int.parse(fruits[index][1].toString()))
              .withOpacity(db.squaresBorderOpacity),
        ),
        duration: const Duration(milliseconds: 700),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ClipPath(
            clipper: fruits[index][1] == c.wrongColor ? null : innerDecider(),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(db.squaresBorderRadius),
                color: Color(int.parse(fruits[index][1].toString())),
                gradient: RadialGradient(
                  radius: 2,
                  colors: [
                    Color(int.parse(fruits[index][1].toString())),
                    Colors.white,
                    //0xFF89CFF0 <-baby blue and the normal
                  ],
                ),
              ),
              child: numbersFlag
                  ? Center(
                      child: Text(
                        index.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 21,
                        ),
                      ),
                    )
                  : Icon(
                      fruits[index][1] == c.wrongColor ? null : iconDecider(),
                      color: c.transparent.withOpacity(0.2),
                      size: db.squaresIcon == 3
                          ? 30
                          : db.squaresIcon == 2
                              ? 30
                              : 24,
                    ),
            ),
          ),
        ),
      ),
    );
    return generatedChildren;
  }

  //! squares numbers widget (replace the icon widget while testing)
  // Center(
  //       child: Text(
  //         index.toString(),
  //         textAlign: TextAlign.center,
  //         style: const TextStyle(
  //          fontWeight: FontWeight.bold,
  //          color: Colors.white,
  //          fontSize: 21,
  //         ),
  //        ),
  //       ),
  // Icon(
  //  fruits[index][1] == c.wrongColor ? null : iconDecider(),
  //   color: c.transparent.withOpacity(0.2),
  //    size: db.squaresIcon == 3
  //     ? 30
  //       : db.squaresIcon == 2
  //           ? 30
  //             : 24,
  //             ),

  //decides the square's inner clipPath (customiziton)
  CustomClipper<Path>? innerDecider() {
    return db.squaresInnerSquare == 0
        ? null
        : db.squaresInnerSquare == 2
            ? SquareHeartClipper()
            : db.squaresInnerSquare == 4
                ? SquareDiamondClipper()
                : db.squaresInnerSquare == 5
                    ? SquareSunClipper()
                    : db.squaresInnerSquare == 6
                        ? SquareSparkleClipper()
                        : db.squaresInnerSquare == 7
                            ? SquarePyramidClipper()
                            : db.squaresInnerSquare == 3
                                ? SquareStarClipper()
                                : SquareAndroidClipper();
  }

  //decides the square's icon (customiziton)
  IconData? iconDecider() {
    return db.squaresIcon == 0
        ? null
        : db.squaresIcon == 1
            ? CustomIcons.speech_bubble
            : db.squaresIcon == 2
                ? CustomIcons.eye_mask__2_
                : db.squaresIcon == 4
                    ? CustomIcons.spider
                    : db.squaresIcon == 5
                        ? CustomIcons.spooky
                        : db.squaresIcon == 6
                            ? CustomIcons.happy_face
                            : db.squaresIcon == 7
                                ? CustomIcons.hockey_mask
                                : db.squaresIcon == 8
                                    ? CustomIcons.poo
                                    : db.squaresIcon == 9
                                        ? CustomIcons.mask_carnival
                                        : db.squaresIcon == 10
                                            ? CustomIcons.bat
                                            : db.squaresIcon == 11
                                                ? CustomIcons.beauty_mask
                                                : db.squaresIcon == 12
                                                    ? CustomIcons.alien
                                                    : db.squaresIcon == 13
                                                        ? CustomIcons.eye
                                                        : db.squaresIcon == 14
                                                            ? CustomIcons.cube
                                                            : CustomIcons.mask;
  }

  //individual squares shadow (when dragged)
  List<BoxShadow> get containerShadow {
    return [
      BoxShadow(
        color: Color.fromARGB(153, 176, 176, 176),
        spreadRadius: 0,
        blurRadius: 10,
        offset: Offset(0, 0),
      ),
    ];
  }

  //calculates coins and add it database
  int calculateCoins(int time, int steps, int level) {
    hiveDataCheck();

    //coins = (Ct/time) + (Cm/moves) + (Cl * level)
    int coins = ((200 / time) + (100 / steps) + (80 * level)).ceil();

    db.coins += coins;
    db.updateDataBase();
    return coins;
  }

  //calculates grade (A+,A,...)
  String calculateGrade({
    required int tCount,
    required int level,
    required int moves,
    required int time,
  }) {
    String grade;
    int score = tCount + 3; //3 is the seconds (change with higher levels)
    int player = moves + time;

    if (player <= score) {
      grade = 'A+';
    } else if (player >= score + 1 && player <= score + 5) {
      grade = 'A';
    } else if (player >= score + 6 && player <= score + 10) {
      grade = 'A-';
    } else if (player >= score + 11 && player <= score + 15) {
      grade = 'B+';
    } else if (player >= score + 16 && player <= score + 20) {
      grade = 'B';
    } else if (player >= score + 21 && player <= score + 25) {
      grade = 'B-';
    } else if (player >= score + 25 && player <= score + 29) {
      grade = 'C+';
    } else if (player >= score + 30 && player <= score + 35) {
      grade = 'C';
    } else if (player >= score + 36 && player <= score + 39) {
      grade = 'C-';
    } else {
      grade = 'D';
    }

    return grade;
  }

  //calculates best grade and stores it, eg: (A+ > B) (C+ > C) .
  void storeGrade(int level, String grade) {
    hiveDataCheck();

    //*checks if it's first time win .
    if (db.scores[level - 1][2] == '') {
      db.scores[level - 1][2] = grade;
      db.updateDataBase();
    }

    //*checks if the current win have better grade
    if (grades.indexOf(grade) <= grades.indexOf(db.scores[level - 1][2])) {
      db.scores[level - 1][2] = grade;
      db.updateDataBase();
    }
  }

  //! changed with every level added
  //method to move to the next level in order (not completed till being done with every level) .
  void nextLevel(BuildContext context, int index) {
    if (index == 1) {
      Get.offAll(() => Level_1(), transition: Transition.size);
    }
    if (index == 2) {
      Get.offAll(() => Level_2(), transition: Transition.size);
    }
    if (index == 3) {
      Get.offAll(() => Level_3(), transition: Transition.size);
    }
    if (index == 4) {
      Get.offAll(() => Level_4(), transition: Transition.size);
    }
    if (index == 5) {
      Get.offAll(() => Level_5(), transition: Transition.size);
    }
    if (index == 6) {
      Get.offAll(() => Level_6(), transition: Transition.size);
    }
    if (index == 7) {
      Get.offAll(() => Level_7(), transition: Transition.size);
    }
    if (index == 8) {
      Get.offAll(() => Level_8(), transition: Transition.size);
    }
    if (index == 9) {
      Get.offAll(() => Level_9(), transition: Transition.size);
    }
    if (index == 10) {
      Get.offAll(() => Level_10(), transition: Transition.size);
    }
    if (index == 11) {
      Get.offAll(() => Level_11(), transition: Transition.size);
    }
    if (index == 12) {
      Get.offAll(() => Level_12(), transition: Transition.size);
    }
    if (index == 13) {
      Get.offAll(() => Level_13(), transition: Transition.size);
    }
    if (index == 14) {
      Get.offAll(() => Level_14(), transition: Transition.size);
    }
    if (index == 15) {
      Get.offAll(() => Level_15(), transition: Transition.size);
    }
    if (index == 16) {
      Get.offAll(() => Level_16(), transition: Transition.size);
    }
    if (index == 17) {
      Get.offAll(() => Level_17(), transition: Transition.size);
    }
    if (index == 18) {
      Get.offAll(() => Level_18(), transition: Transition.size);
    }
    if (index == 19) {
      Get.offAll(() => Level_19(), transition: Transition.size);
    }
    if (index == 20) {
      Get.offAll(() => Level_20(), transition: Transition.size);
    }
    if (index == 21) {
      Get.offAll(() => Level_21(), transition: Transition.size);
    }
  }

  //calcultes best score (least moves and least time)
  void calculateBestScores(int time, int level, int steps) {
    hiveDataCheck();

    //*checks if it's first time win .
    if (db.scores[level - 1][0] == 0) {
      db.scores[level - 1][0] = time;
      db.updateDataBase();
    }
    if (db.scores[level - 1][1] == 0) {
      db.scores[level - 1][1] = steps;
      db.updateDataBase();
    }

    //*checks if the current win have better scores (better = lower)
    if (db.scores[level - 1][0] > time) {
      db.scores[level - 1][0] = time;
      db.updateDataBase();
    }
    if (db.scores[level - 1][1] > steps) {
      db.scores[level - 1][1] = steps;
      db.updateDataBase();
    }
  }

  Future<void> playSound(String sound) async {
    String path = "sounds/$sound.mp3";
    await player.play(AssetSource(path));
  }

  //local data levelsList check
  void hiveDataCheck() {
    if (_myBox.get("LIST") == null) {
      db.createInitialDataList();
    } else {
      db.loadDataList();
    }
    if (_myBox.get("RADIUS") == null) {
      db.createInitialDataBorderRadius();
    } else {
      db.loadDataBorderRadius();
    }
    if (_myBox.get("OPA") == null) {
      db.createInitialDataBorderOpacity();
    } else {
      db.loadDataBorderOpacity();
    }
    if (_myBox.get("ICON") == null) {
      db.createInitialDataIcon();
    } else {
      db.loadDataIcon();
    }
    if (_myBox.get("INNER") == null) {
      db.createInitialDataInner();
    } else {
      db.loadDataInner();
    }
    if (_myBox.get("SCORES") == null) {
      db.createInitialDataScores();
    } else {
      db.loadDataScores();
    }
    if (_myBox.get("COINS") == null) {
      db.createInitialDataCoins();
    } else {
      db.loadDataCoins();
    }
    if (_myBox.get("BUY") == null) {
      db.createInitialDataBought();
    } else {
      db.loadDataBought();
    }
    if (_myBox.get("THEME") == null) {
      db.createInitialDataTheme();
    } else {
      db.loadDataTheme();
    }
    if (_myBox.get("BG") == null) {
      db.createInitialDataLevelBg();
    } else {
      db.loadDataLevelsBg();
    }
  }

  //! Don't not change
  ///method to unlock a level,used mainly to access the level in [levelsPage] , called after [playerWin] method , updates the databse list , doesn't harm since we relay on [nextLevel] to move to other levels
  void unlockNextLevel(int index) {
    hiveDataCheck();
    db.levelsUnlock[index] = true;
    db.updateDataBase();
  }
}
