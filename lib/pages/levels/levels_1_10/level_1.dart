import 'package:Squareo/state/target_controller.dart';
import 'package:Squareo/models/target.dart';
import 'package:Squareo/utils/breadth_first.dart';
import 'package:flutter/material.dart';
import 'package:Squareo/compnents/app_bar.dart';
import 'package:Squareo/compnents/main_grid.dart';
import 'package:Squareo/compnents/scaffold_bottom.dart';
import 'package:Squareo/utils/colors.dart';
import 'package:Squareo/utils/square.dart';
import 'package:get/get.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

class Level_1 extends StatefulWidget {
  const Level_1({
    super.key,
  });

  @override
  State<Level_1> createState() => _Level_1State();
}

class _Level_1State extends State<Level_1> {
  //scroll controller , and keys for the list grid
  final _scrollController = ScrollController();
  final _gridViewKey = GlobalKey();

  //colors
  CustomColors c = CustomColors();

  //this specifiy the number of columns , it must be provived and cannot be changed throw the same leve .
  late int columnSize = 4;

  //this specifiy the number of rows , it must be provived and cannot be changed throw the same leve .
  late int rowsSize = 3;

  //3 seconds starter time
  final int _start = 3;

  //square instance
  Square square = Square();

  //* state management below

  //getx controller instance
  late TargetsController g;

  //individual targets put in targets list
  late Target green;
  late Target green2;

  late BreadthFirstSearch breadthFirst;
  late List<int> path;

  @override
  void initState() {
    //data check
    square.hiveDataCheck();

    //initlize the target's objects
    green = Target(index: 0, color: c.green);
    green2 = Target(index: 10, color: c.green);

    //initlize the controller [rows,columns]
    g = Get.put(TargetsController());

    //steps starts in 0
    g.steps.value = 0;

    //set up level number
    g.level.value = 1;

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
      g.targets = [green, green2];
      //initlize the list (must be called to reset the list)
      g.list = g.generateList().obs;
      //the constant amount between moves (milliseconds)
      g.duration.value = 1000;
      //reset the lock and drag to false
      g.isLastMove(false);
      g.activeDrag.value = false;
      g.unlockFlag.value = false;

      //3 seconds till start dialogs finish
      await g.delay();

      //movements starts here
      await g.down(green);
      await g.right(green);
      await g.up(green);
      await g.up(green2, lastMove: true);

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
              title: "Level 1",
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
              unlockFlag: g.unlockFlag.value,
              c: c,
              showScafflodSheet: () => square.showScafflodSheet(
                  context, g.skipLevel, g.level.value + 1),
            ),
          ),
        ),
      ),
    );
  }
}
