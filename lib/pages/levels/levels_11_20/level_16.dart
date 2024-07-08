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

class Level_16 extends StatefulWidget {
  const Level_16({super.key});

  @override
  State<Level_16> createState() => _Level_16State();
}

class _Level_16State extends State<Level_16> {
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
  late Target yellow;
  late Target orange300;
  late Target yellow200;
  late Target orange;
  late Target yellowAccent;
  late Target orange700;
  late Target red;

  @override
  void initState() {
    square.hiveDataCheck();

    yellow = Target(index: 6, color: c.yellow);
    yellow200 = Target(index: 10, color: c.yellow200);
    yellowAccent = Target(index: 5, color: c.yellowAccent);
    orange = Target(index: 18, color: c.orange);
    orange300 = Target(index: 14, color: c.orange300);
    orange700 = Target(index: 19, color: c.orange700);
    red = Target(index: 12, color: c.red);

    //steps starts in 0
    g.steps.value = 0;

    //set up level number
    g.level.value = 16;

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
        orange300,
        yellow200,
        orange,
        yellowAccent,
        yellow,
        orange700,
        red
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
      g.up(yellowAccent);
      await g.down(orange700);

      g.toPath(yellowAccent, 3);
      await g.toPath(orange700, 21);

      g.colorSwitch(red, yellow);
      g.left(orange300);
      g.left(orange);
      g.right(yellow200);
      await g.right(yellow);

      g.colorSwitch(orange300, orange700);
      g.right(yellowAccent);
      g.left(orange700);
      g.down(orange300);
      g.up(yellow200);
      g.left(orange);
      await g.right(yellow);

      g.colorSwitch(yellowAccent, yellow200);
      g.down(yellowAccent);
      g.up(orange700);
      g.up(orange);
      g.down(yellow);
      g.right(yellow200);
      await g.left(orange300);

      g.down(yellow);
      await g.up(orange);

      g.up(orange);
      await g.down(yellow);

      g.toPath(orange, 2);
      await g.toPath(yellow, 22);

      g.left(orange300);
      g.right(yellow200);
      g.up(orange700);
      await g.down(yellowAccent, lastMove: true);

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
              canChange: true,
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