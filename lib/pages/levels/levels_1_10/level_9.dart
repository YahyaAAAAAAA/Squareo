import 'package:Squareo/models/target.dart';
import 'package:Squareo/state/target_controller.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_reorderable_grid_view/entities/reorderable_entity.dart';
//import 'package:flutter_reorderable_grid_view/widgets/animated/reorderable_animated_container.dart';
//import 'package:flutter_reorderable_grid_view/widgets/animated/reorderable_animated_dragging_container.dart';
//import 'package:flutter_reorderable_grid_view/widgets/animated/reorderable_animated_opacity.dart';
//import 'package:flutter_reorderable_grid_view/widgets/animated/reorderable_animated_update_container.dart';
//import 'package:flutter_reorderable_grid_view/widgets/animated/reorderable_draggable.dart';
//import 'package:flutter_reorderable_grid_view/widgets/reorderable_scrolling_listener.dart';
import 'package:Squareo/compnents/app_bar.dart';
import 'package:Squareo/compnents/main_grid.dart';
import 'package:Squareo/compnents/scaffold_bottom.dart';
import 'package:Squareo/utils/colors.dart';

import 'package:Squareo/utils/square.dart';
import 'package:get/get.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

class Level_9 extends StatefulWidget {
  const Level_9({super.key});

  @override
  State<Level_9> createState() => _Level_9State();
}

class _Level_9State extends State<Level_9> {
  final _scrollController = ScrollController();
  final _gridViewKey = GlobalKey();

  CustomColors c = CustomColors();

  //this specifiy the number of columns , it must be provived and cannot be changed throw the same leve .
  final int columnSize = 5;

  //this specifiy the number of rows , it must be provived and cannot be changed throw the same leve .
  final int rowsSize = 5;

  final int _start = 3;

  Square square = Square();

  //getx controller instance
  final TargetsController g = Get.put(TargetsController());

  //individual targets put in targets list ^
  late Target amber;
  late Target white;
  late Target purple;
  late Target yellow;
  late Target amber2;
  late Target yellow2;

  //! for newer levels
  //* 1- declare targetN with the specified same on the board
  //* 2- declare initTargetN
  //* 3- change the color in _fruits with the crosspond in targetN + 1
  //* 4- alter the playerWin() based on targetN == "colorHex"
  //* 5- start making the movement in initState , order by duration
  //* 6- add in this widget's stack
  //  bottomSheet: TextButton(
  //        child: Text('data'),
  //        onPressed: () {
  //          showDialog(
  //            context: context,
  //            builder: (context) {
  //              return AlertDialog();
  //            },
  //          );
  //          cube.backToMenu(context);
  //        },
  //      ),
  //* 7- comment out 2 lines in cube => startTimer() method , you'll find'em there (for testing) + don't comment out anything here
  //* 8- make sure to edit cube.nextLevel , cube.unlockNextLevel after adding new level
  //* 9- to change color ->
  //correctColor_2 = colorChange(
  //            currentColor: correctColor_2,
  //            newColor: "0xFFFFFFFF",
  //            duration: 2900);

  @override
  void initState() {
    square.hiveDataCheck();

    amber = Target(index: 1, color: c.amber);
    white = Target(index: 8, color: c.white);
    purple = Target(index: 10, color: c.purple);
    yellow = Target(index: 14, color: c.yellow);
    amber2 = Target(index: 15, color: c.amber);
    yellow2 = Target(index: 23, color: c.yellow);

    //steps starts in 0
    g.steps.value = 0;

    //set up level number
    g.level.value = 9;

    //passing context
    g.context = context;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //make sure startTime only called once , same with showAlert
      square.startTimer(context, _start);
      square.showAlert(context, _start);

      //initlize the grid size [rows,columns] (must be called)
      g.gridSize = [rowsSize, columnSize];
      //initlize the targets (must be called to reset the values on restart)
      g.targets = [amber, white, purple, yellow, amber2, yellow2];
      //initlize the list (must be called to reset the list)
      g.list = g.generateList().obs;
      //the constant amount between moves (milliseconds)
      g.duration.value = 300;
      //reset the lock and drag to false
      g.isLastMove(false);
      g.activeDrag.value = false;
      g.unlockFlag.value = false;

      //3 seconds till start dialogs finish
      await g.delay();

      //movements starts here
      g.toPath(amber, 9);
      await g.toPath(amber2, 6);
      g.toPath(yellow, 11);
      await g.toPath(yellow2, 20);
      await g.down(purple);
      await g.toPath(purple, 24);
      g.toPath(yellow, 0);
      await g.down(white);
      await g.toPath(white, 16);
      //g.toPath(amber, 1);
      await g.toPath(amber2, 12);
      await g.up(purple);
      await g.up(purple);
      await g.toPath(amber2, 22);
      g.toPath(amber, 3);
      await g.toPath(purple, 2);
      g.toPath(yellow2, 0);
      await g.down(yellow);
      await g.toPath(yellow, 13, lastMove: true);

      //setState must be called to render the list (FOR SOME REASON !!!!!)
      setState(() {});

      //post frame callback end
    });

    super.initState();
  }

  // String colorChange(
  //     {required String currentColor,
  //     required String newColor,
  //     required int duration}) {
  //   Future.delayed(
  //     Duration(milliseconds: duration),
  //     () {
  //       for (int i = 0; i < _fruits.length; i++) {
  //         if (_fruits[i][1] == currentColor) {
  //           _fruits[i][1] = newColor;
  //         }
  //       }
  //     },
  //   );
  //   return newColor;
  // }

  @override
  void dispose() {
    square.timer.cancel();
    Get.delete<TargetsController>();
    _scrollController.dispose();
    square.player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) =>
          g.unlockFlag.value ? square.appBarBackToMenu(context) : null,
      child: MeshGradient(
        points: square.db.levelsBg == 0 ? c.pointsLight : c.poinstDark,
        options: MeshGradientOptions(blend: 3.5),
        child: Obx(
          () => Scaffold(
            appBar: AppBarBuild(
              appBarBackToMenu: () => square.appBarBackToMenu(context),
              textColor: c.textColor,
              unlockFlag: g.unlockFlag.value,
              coins: square.db.coins,
              title: "Level ${g.level}",
            ),
            backgroundColor: Colors.transparent,
            body: MainGrid(
              height: 220,
              padding: const EdgeInsets.all(23),
              unlockColor: c.unlockColor,
              lockColor: c.lockColor,
              onReorderList: g.onListReorder,
              unlockFlag: g.unlockFlag.value,
              textColor: c.textColor,
              scrollController: _scrollController,
              activeDrag: g.activeDrag.value,
              containerShadow: square.containerShadow,
              gridViewKey: _gridViewKey,
              columnSize: columnSize,
              generatedChildren: square.generateSquares(g.list),
              borderRadius: square.db.squaresBorderRadius,
            ),
            bottomSheet: ScaffoldBottom(
              c: c,
              unlockFlag: g.unlockFlag.value,
              showScafflodSheet: () => square.showScafflodSheet(
                context,
                g.skipLevel,
                g.level.value + 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
