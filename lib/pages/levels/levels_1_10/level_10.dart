import 'package:Squareo/models/target.dart';
import 'package:Squareo/state/target_controller.dart';
import 'package:flutter/material.dart';
import 'package:Squareo/compnents/app_bar.dart';
import 'package:Squareo/compnents/main_grid.dart';
import 'package:Squareo/compnents/scaffold_bottom.dart';
import 'package:Squareo/utils/colors.dart';
import 'package:Squareo/utils/square.dart';
import 'package:get/get.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

class Level_10 extends StatefulWidget {
  const Level_10({super.key});

  @override
  State<Level_10> createState() => _Level_10State();
}

class _Level_10State extends State<Level_10> {
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

  //individual targets put in targets list
  late Target purple;
  late Target purple300;
  late Target purple700;
  late Target yellow;
  late Target yellowAccent;
  late Target yellow200;

  @override
  void initState() {
    square.hiveDataCheck();

    purple = Target(index: 16, color: c.purple);
    purple300 = Target(index: 4, color: c.purple300);
    purple700 = Target(index: 8, color: c.purple700);
    yellow = Target(index: 12, color: c.yellow);
    yellowAccent = Target(index: 19, color: c.yellowAccent);
    yellow200 = Target(index: 23, color: c.yellow200);

    //steps starts in 0
    g.steps.value = 0;

    //set up level number
    g.level.value = 10;

    //passing context
    g.context = context;

    //increment tries
    if (square.db.scores[g.level.value - 1][2] != 'A+') {
      square.db.scores[g.level.value - 1][3] += 1;
      square.db.updateDataBase();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //make sure startTime only called once , same with showAlert
      square.startTimer(context, _start);
      square.showAlert(context, _start);

      //initlize the grid size [rows,columns] (must be called)
      g.gridSize = [rowsSize, columnSize];
      //initlize the targets (must be called to reset the values on restart)
      g.targets = [
        purple,
        purple300,
        purple700,
        yellow,
        yellowAccent,
        yellow200
      ];
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
      g.toPath(purple300, 6);
      g.toPath(purple700, 21);
      await g.toPath(purple, 0);
      g.toPath(yellow, 10);
      await g.toPath(yellowAccent, 3);
      g.toPath(purple300, 9);
      await g.toPath(yellow200, 12);
      g.toPath(yellow, 4);
      await g.toPath(purple, 18);
      g.toPath(purple700, 13);
      g.toPath(purple, 16);
      await g.toPath(yellow, 20);
      await g.right(purple, lastMove: true);

      //post frame callback end
    });

    super.initState();
  }

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
                title: "Level ${g.level}",
                unlockFlag: g.unlockFlag.value,
                coins: square.db.coins,
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
        ));
  }
}
