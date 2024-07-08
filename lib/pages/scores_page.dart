import 'package:Squareo/compnents/custom_icons.dart';
import 'package:Squareo/compnents/grades_button.dart';
import 'package:Squareo/compnents/gradient_text.dart';
import 'package:Squareo/pages/levels_page.dart';
import 'package:Squareo/utils/colors.dart';
import 'package:Squareo/utils/square.dart';
import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:get/get.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

class ScoresPage extends StatefulWidget {
  const ScoresPage({super.key});

  @override
  State<ScoresPage> createState() => _ScoresPageState();
}

class _ScoresPageState extends State<ScoresPage> {
  //colors
  CustomColors c = CustomColors();

  late bool lockedLevels;

  Square square = Square();

  late List<double> gradesCounts;

  late List<double> gradesNumerical;

  late List<Color> colors;

  late int timeSum;
  late int movesSum;
  late double gradeSum;
  late int wonLevels;
  late int wonGrades;
  late double avg;

  @override
  void initState() {
    square.hiveDataCheck();

    //show locked levels in ListView
    lockedLevels = false;

    //set grades count to 0's
    gradesCounts = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

    gradesNumerical = [4.0, 3.75, 3.5, 3.25, 3.0, 2.75, 2.5, 2.0, 1.75, 1.5];

    //bar gradients
    colors = [c.bgSheetColor, c.bgSheetColor];

    timeSum = 0;
    movesSum = 0;
    gradeSum = 0;
    wonLevels = 0;
    wonGrades = 0;

    //collect grades counts
    for (int i = 0; i < square.db.scores.length; i++) {
      if (square.db.scores[i][2] == 'A+') {
        gradesCounts[0] += 1;
      } else if (square.db.scores[i][2] == 'A') {
        gradesCounts[1] += 1;
      } else if (square.db.scores[i][2] == 'A-') {
        gradesCounts[2] += 1;
      } else if (square.db.scores[i][2] == 'B+') {
        gradesCounts[3] += 1;
      } else if (square.db.scores[i][2] == 'B') {
        gradesCounts[4] += 1;
      } else if (square.db.scores[i][2] == 'B-') {
        gradesCounts[5] += 1;
      } else if (square.db.scores[i][2] == 'C+') {
        gradesCounts[6] += 1;
      } else if (square.db.scores[i][2] == 'C') {
        gradesCounts[7] += 1;
      } else if (square.db.scores[i][2] == 'C-') {
        gradesCounts[8] += 1;
      } else if (square.db.scores[i][2] == 'D') {
        gradesCounts[9] += 1;
      }
    }

    //gets sum of total time & moves
    for (int i = 0; i < square.db.scores.length; i++) {
      if (square.db.scores[i][0] != 0) {
        wonLevels++;
        timeSum += square.db.scores[i][0] as int;
        movesSum += square.db.scores[i][1] as int;
      }
    }

    //gets sum of total grades (numerical)
    for (int i = 0; i < gradesCounts.length; i++) {
      if (gradesCounts[i] != 0) {
        wonGrades += gradesCounts[i].toInt();
        gradeSum += gradesCounts[i] * gradesNumerical[i];
      }
    }

    avg = gradeSum / wonGrades;

    super.initState();
  }

  //returns average grade
  String getGrade(double avg) {
    if (avg >= 4.0)
      return 'A+';
    else if (avg >= 3.75)
      return 'A';
    else if (avg >= 3.5)
      return 'A-';
    else if (avg >= 3.25)
      return 'B+';
    else if (avg >= 3.0)
      return 'B';
    else if (avg >= 2.75)
      return 'B-';
    else if (avg >= 2.5)
      return 'C+';
    else if (avg >= 2.0)
      return 'C';
    else if (avg >= 1.75)
      return 'C-';
    else
      return 'D';
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) =>
          Get.offAll(() => LevelsPage(), transition: Transition.leftToRight),
      child: MeshGradient(
        points: c.points,
        options: MeshGradientOptions(blend: 3.5),
        child: Scaffold(
          appBar: appBarBuild(context),
          backgroundColor: c.transparent,
          body: Column(
            children: [
              const SizedBox(height: 20),
              //top row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //total grades
                  totalGrades(context),
                  //average time,moves,grade
                  averageScores(context),
                ],
              ),
              Divider(
                color: c.textColor,
                thickness: 1.5,
                indent: 25,
                endIndent: 25,
              ),
              //scores list
              scoresList(),
            ],
          ),
        ),
      ),
    );
  }

  Expanded scoresList() {
    return Expanded(
      child: ListView.builder(
        itemCount: square.db.scores.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (square.db.scores[index][0] == 0 &&
              square.db.scores[index][1] == 0) {
            return lockedLevels
                ? Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        levelsCircleAvatar(index, false),
                        SizedBox(width: 20, height: 50),
                        Container(
                            width: 350,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text('')),
                      ],
                    ),
                  )
                : SizedBox();
          } else {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  levelsCircleAvatar(index, true),
                  SizedBox(width: 20, height: 70),
                  Container(
                    width: 350,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: c.mainColor1.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(
                            CustomIcons.duration_alt,
                            color: c.textColor,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Time : ${square.db.scores[index][0]}',
                            style: TextStyle(
                              color: c.textColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Abel',
                            ),
                          ),
                          const SizedBox(width: 15),
                          Icon(
                            CustomIcons.shoe_prints,
                            color: c.textColor,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Moves : ${square.db.scores[index][1]}',
                            style: TextStyle(
                              color: c.textColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Abel',
                            ),
                          ),
                          const SizedBox(width: 15),
                          Icon(
                            CustomIcons.splotch,
                            color: c.textColor,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          square.db.scores[index][2] == 'A+'
                              //if grade is A+
                              ? CustomPopup(
                                  backgroundColor: c.bgSheetColor,
                                  arrowColor: c.bgSheetColor,
                                  content: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        CustomIcons.motivation,
                                        color: square.db.scores[index][3] == 1
                                            ? const Color.fromARGB(
                                                255, 247, 113, 135)
                                            : const Color(0xFFFFD700),
                                        size: 32,
                                      ),
                                      const SizedBox(width: 10),
                                      GradientText(
                                        square.db.scores[index][3] == 1
                                            ? "In ${square.db.scores[index][3].toString()} Attempt"
                                            : "In ${square.db.scores[index][3].toString()} Attempts",
                                        style: TextStyle(
                                          color: c.bgSheetColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          fontFamily: 'Abel',
                                        ),
                                        gradient: LinearGradient(
                                          colors:
                                              square.db.scores[index][3] == 1
                                                  ? c.aPlusTries
                                                  : c.aPlus,
                                        ),
                                        children: [],
                                      ),
                                    ],
                                  ),
                                  child: GradientText(
                                    square.db.scores[index][2],
                                    style: TextStyle(
                                      color: c.textColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      fontFamily: 'PlaywritePL',
                                    ),
                                    gradient: LinearGradient(
                                      colors: square.db.scores[index][2] ==
                                                  'A+' &&
                                              square.db.scores[index][3] == 1
                                          ? c.aPlusTries
                                          : square.db.scores[index][2] == 'A+'
                                              ? c.aPlus
                                              : c.gradesColor,
                                    ),
                                    children: [],
                                  ),
                                )
                              //if grade not A+
                              : GradientText(
                                  square.db.scores[index][2],
                                  style: TextStyle(
                                    color: c.textColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontFamily: 'PlaywritePL',
                                  ),
                                  gradient: LinearGradient(
                                    colors: square.db.scores[index][2] == 'A+'
                                        ? c.aPlus
                                        : c.gradesColor,
                                  ),
                                  children: [],
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  GradesButton totalGrades(BuildContext context) {
    return GradesButton(
      c: c,
      icon: CustomIcons.test,
      text: 'Total Grades',
      onPressed: () => square.showBarChartDialog(
          context, gradesCounts, colors, defaultTextStyle('Abel')),
    );
  }

  GradesButton averageScores(BuildContext context) {
    return GradesButton(
      c: c,
      icon: CustomIcons.tachometer_alt_average,
      text: 'Average Scores',
      onPressed: () => square.showAverageDialog(
        context,
        wonLevels != 0 ? (timeSum / wonLevels).round() : 0,
        wonLevels != 0 ? (movesSum / wonLevels).round() : 0,
        getGrade(avg),
        defaultTextStyle('Abel'),
      ),
    );
  }

  //used in total grades button
  TextStyle defaultTextStyle(String font) {
    return TextStyle(
      color: c.textColor,
      fontFamily: font,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );
  }

  Container levelsCircleAvatar(int index, bool lock) {
    return Container(
      child: Column(
        children: [
          lock
              ? Text(
                  'Level',
                  style: TextStyle(
                    color: c.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                )
              : SizedBox(),
          SizedBox(height: 5),
          CircleAvatar(
            backgroundColor: c.textColor,
            child: FittedBox(
              child: lock
                  ? Text(
                      (index + 1).toString(),
                      style: TextStyle(
                        color: c.mainColor1,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Abel',
                      ),
                    )
                  : lock
                      ? Icon(
                          CustomIcons.unlock,
                          size: 25,
                          color: c.mainColor1,
                        )
                      : Icon(
                          CustomIcons.lock,
                          size: 25,
                          color: Colors.grey.shade500,
                        ),
            ),
          ),
        ],
      ),
    );
  }

  //appbar ,just ui
  AppBar appBarBuild(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: c.transparent,
      leading: TextButton(
        onPressed: () {
          ///method to go back to [HomePage]
          Get.offAll(() => LevelsPage(), transition: Transition.upToDown);
        },
        style: ButtonStyle(
          overlayColor: WidgetStatePropertyAll(c.textColor.withOpacity(0.2)),
        ),
        child: const Icon(
          CustomIcons.left,
          color: Colors.white,
          size: 25,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: c.bgSheetColor,
            ),
            child: Row(
              children: [
                Checkbox(
                  onChanged: (value) {
                    setState(() {
                      lockedLevels = !lockedLevels;
                    });
                  },
                  value: lockedLevels,
                  activeColor: c.textColor,
                  checkColor: c.mainColor1,
                  fillColor: WidgetStatePropertyAll(c.textColor),
                  side: BorderSide(
                      color: c.mainColor1.withOpacity(0.7), width: 2),
                  overlayColor:
                      WidgetStatePropertyAll(c.textColor.withOpacity(0.7)),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(
                    lockedLevels ? CustomIcons.unlock : CustomIcons.lock,
                    size: 20,
                    color: c.textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: Container(
          height: 1.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: c.textColor,
          ),
        ),
      ),
      title: Text(
        'Best Scores',
        style: TextStyle(
          fontFamily: 'Abel',
          color: c.textColor,
          fontSize: 41,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
