import 'dart:async';
import 'package:Squareo/models/target.dart';
import 'package:Squareo/utils/breadth_first.dart';
import 'package:Squareo/utils/colors.dart';
import 'package:Squareo/utils/square.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reorderable_grid_view/entities/order_update_entity.dart';
import 'package:get/get.dart';

class TargetsController extends GetxController {
  // grid size with rows and columns
  // gridSize[0] -> rows
  // gridSize[1] -> columns
  List<int> gridSize = [];

  //list of targets (colored squares)
  List<Target> targets = [];

  //colors
  CustomColors c = CustomColors();

  //duration controller
  RxInt duration = 3000.obs;

  //set to true after initState finishes , this enables the user to reorder the list
  RxBool activeDrag = false.obs;

  //display a lock icon till last move it changes it to unlock
  RxBool unlockFlag = false.obs;

  //counts the number of steps the player took to win .
  RxInt steps = 0.obs;

  //this is the currnet level , it mus be provided and cannot be changed throw the same leve .
  RxInt level = 1.obs;

  //for level 21 and above, win condition on second position
  bool secondIndex = false;

  //starts counting after last move is done , then calculate the diff when player wins
  Rx<DateTime> startTime = DateTime.now().obs;

  //build context , initialized in initState in every level
  late BuildContext context;

  //main grid list
  RxList list = [].obs;

  //square instance
  Square square = Square();

  //used in toPath method
  BreadthFirstSearch breadthFirst = BreadthFirstSearch();

  //returns the main list of squares (targets and non-targets)
  List generateList() {
    //get indexes of targets in seperate list
    List l = [];
    for (int i = 0; i < targets.length; i++) {
      l.insert(i, targets[i].index);
    }
    //generate main list based on colors
    return List.generate(
      gridSize[0] * gridSize[1],
      growable: true,
      (index) {
        if (l.contains(index)) {
          return [index, targets[l.indexOf(index)].color];
        } else {
          return [index, c.wrongColor];
        }
      },
    );
  }

  //indicates when player won
  void playerWon(List<Target> listOfTargets) async {
    // declare win case condition
    if (listOfTargets.every((element) =>
        element.color ==
        list[secondIndex ? element.secondIndex : element.initIndex][1])) {
      //calculate final timer , based on it we decide the points earned
      var finalTime =
          DateTime.now().difference(startTime.value).inSeconds.ceil();

      //disable drage after win
      activeDrag = RxBool(false);

      //dividing by 0
      if (finalTime == 0) {
        finalTime = 1;
      }

      //calculate grade
      String grade = square.calculateGrade(
          tCount: targets.length,
          level: level.value,
          moves: steps.value,
          time: finalTime);

      //plays sounds
      if (grade == 'A+') {
        square.playSound('a+');
      } else {
        square.playSound('win');
      }
      //await here so we can display (new best) before updating the database
      await Future.delayed(
        const Duration(milliseconds: 300),
        () {
          square.showWinAlert(
            context,
            level.value + 1,
            time: finalTime,
            steps: steps,
            coins: square.calculateCoins(finalTime, steps.value, level.value),
            grade: grade,
          );
        },
      );

      //same reson up
      Future.delayed(
        Duration(milliseconds: 400),
        () {
          //stores (time,moves,grade)
          square.calculateBestScores(finalTime, level.value, steps.value);
          square.storeGrade(level.value, grade);
        },
      );

      //unlocks next level
      square.unlockNextLevel(level.value);
    }
  }

  //reorder the main list on dragging
  void onListReorder(List<OrderUpdateEntity> orderUpdateEntities) {
    for (final orderUpdateEntity in orderUpdateEntities) {
      final fruit = list.removeAt(orderUpdateEntity.oldIndex);
      list.insert(orderUpdateEntity.newIndex, fruit);
    }
    steps++;
    playerWon(targets);
  }

  //change indiviual targets color
  Future<void> colorChange(String newColor, Target t) async {
    //

    //update the color for win condition
    t.color.value = newColor;
    //update list for grid visual
    list[t.index][1] = newColor;
  }

  //switch 2 targets colors
  Future<void> colorSwitch(Target t1, Target t2) async {
    //sound

    //causing state update
    t1.color.value = t1.color.value;

    //switching
    list[t1.index][1] = t2.color.value;
    list[t2.index][1] = t1.color.value;
  }

  //change all targets color with a new one
  Future<void> colorChangeAll(String newColor, String oldColor) async {
    //sound

    for (int i = 0; i < list.length; i++) {
      //update list for grid visual
      if (list[i][1] == oldColor) {
        list[i][1] = newColor;
      }
    }
    for (int i = 0; i < targets.length; i++) {
      //update the color for win condition
      if (targets[i].color.value == oldColor) {
        targets[i].color.value = newColor;
      }
    }
  }

  //to skip current level and unlocks it
  void skipLevel() {
    square.unlockNextLevel(level.value);
    square.showSkipAlert(context, level.value + 1);
  }

  //3 seconds delay till the start dialogs finish
  Future delay({int duration = 3000}) async {
    await Future.delayed(
      Duration(milliseconds: duration),
      () {},
    );
  }

  //called with last move to activate drag , unlockIcon , reset duration and time
  void isLastMove(bool lastMove) {
    if (lastMove) {
      activeDrag = RxBool(true);
      unlockFlag = RxBool(true);
      startTime = Rx(DateTime.now());
      //reset the duration value in the end
      duration.value = 3000;
    }
  }

  //* Movements methods below

  //makes target go UP 🙄 ⬆
  Future up(Target target, {bool lastMove = false}) async {
    //incase same is true , save init value
    var initDuration = duration.value;

    //handle the target from going out of bounds
    if (target.index - gridSize[1] < 0) {
      print('out of bounds UP');

      return target.index;
    }

    //switching in the list and changing the target index logic
    await Future.delayed(
      Duration(milliseconds: duration.value),
      () {
        final temp = list[target.index - gridSize[1]];
        list[target.index - gridSize[1]] = list[target.index];
        list[target.index] = temp;
        target.index = target.index - gridSize[1];
        duration.value = initDuration;
        isLastMove(lastMove);
      },
    );
  }

  //makes target go DOWN 😌 ⬇
  Future down(Target target, {bool lastMove = false}) async {
    //incase same is true , save init value
    var initDuration = duration.value;

    //handle the target from going out of bounds
    if (target.index + gridSize[1] > list.length) {
      print('out of bounds');

      return target.index;
    }

    //switching in the list and changing the target index logic
    await Future.delayed(
      Duration(milliseconds: duration.value),
      () {
        final temp = list[target.index + gridSize[1]];
        list[target.index + gridSize[1]] = list[target.index];
        list[target.index] = temp;
        target.index = target.index + gridSize[1];
        duration.value = initDuration;
        isLastMove(lastMove);
      },
    );
  }

  //makes target go RIGHT 😒 ➡
  Future right(Target target, {bool lastMove = false}) async {
    //incase same is true , save init value
    var initDuration = duration.value;

    //handle the target from going out of bounds
    if (target.index + 1 >= list.length) {
      print('out of bounds RIGHT');

      return target.index;
    }

    //switching in the list and changing the target index logic
    await Future.delayed(
      Duration(milliseconds: duration.value),
      () {
        final temp = list[target.index + 1];
        list[target.index + 1] = list[target.index];
        list[target.index] = temp;
        target.index = target.index + 1;
        duration.value = initDuration;
        isLastMove(lastMove);
      },
    );
  }

  //makes target go LEFT 😏 ⬅
  Future left(Target target, {bool lastMove = false}) async {
    //incase same is true , save init value
    var initDuration = duration.value;

    //handle the target from going out of bounds
    if (target.index - 1 < 0) {
      print('out of bounds LEFT');

      return target.index;
    }

    //switching in the list and changing the target index logic
    await Future.delayed(
      Duration(milliseconds: duration.value),
      () {
        final temp = list[target.index - 1];
        list[target.index - 1] = list[target.index];
        list[target.index] = temp;
        target.index = target.index - 1;
        duration.value = initDuration;
        isLastMove(lastMove);
      },
    );
  }

  //hides a target and moves it to new position
  Future<void> fade(Target t, int newIndex, {int duration = 500}) async {
    String temp = t.color.value;
    colorChange("0xFFE3D3D3", t);
    t.index = newIndex;
    await delay(duration: duration);
    colorChange(temp, t);
  }

  //moves target to another location (called with Breadth first algo) 😊
  Future to(Target target, int to, {bool lastMove = false}) async {
    //incase same is true , save init value
    var initDuration = duration.value;

    //handle the target from going out of bounds
    ////

    //switching in the list and changing the target index logic
    await Future.delayed(
      Duration(milliseconds: duration.value),
      () {
        final temp = list[to];
        list[to] = list[target.index];
        list[target.index] = temp;
        target.index = to;
        duration.value = initDuration;
        isLastMove(lastMove);
      },
    );
  }

  //moves target in a shortest path (breadth first algo)
  Future toPath(
    Target t,
    int goal, {
    bool lastMove = false,
    String color = '',
    bool canFlick = false,
  }) async {
    List<int> path =
        breadthFirst.bfs(t.index, goal, gridSize[0], gridSize[1]).cast<int>();

    String wrongC = c.wrongColor.value;
    String currentC = t.color.value;

    for (int i = 0; i < path.length; i++) {
      //color flick between current color and wrong color
      if (canFlick) {
        if (i == 1 || i == path.length - 1) {
          colorChange(currentC, t);
        } else {
          colorChange(wrongC, t);
        }
      }

      //color change
      if (color != '') {
        if (i == (path.length / 2).floor()) {
          currentC = color;

          colorChange(color, t);
        }
      }

      //moves
      await to(t, path[i],
          lastMove: ((i == path.length - 1) && lastMove) ? true : false);
    }
  }

  //moves target in a path of list of integers
  Future toGivenPath(
    Target t,
    List<int> path, {
    bool lastMove = false,
    String color = '',
    bool canFlick = false,
  }) async {
    String wrongC = c.wrongColor.value;
    String currentC = t.color.value;

    for (int i = 0; i < path.length; i++) {
      //color flick between current color and wrong color
      if (canFlick) {
        if (i == 1 || i == path.length - 1) {
          colorChange(currentC, t);
        } else {
          colorChange(wrongC, t);
        }
      }

      //color change
      if (color != '') {
        if (i == (path.length / 2).floor()) {
          colorChange(color, t);
        }
      }
      //moves
      await to(t, path[i],
          lastMove: ((i == path.length - 1) && lastMove) ? true : false);
    }
  }
}
