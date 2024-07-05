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

class Level_14 extends StatefulWidget {
  const Level_14({super.key});

  @override
  State<Level_14> createState() => _Level_14State();
}

class _Level_14State extends State<Level_14> {
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
  late Target teal;
  late Target deepOrange;
  late Target pink300;
  late Target red;
  late Target amber;
  late Target purple;

  @override
  void initState() {
    square.hiveDataCheck();

    teal = Target(index: 3, color: c.teal);
    deepOrange = Target(index: 4, color: c.deepOrange);
    pink300 = Target(index: 14, color: c.pink300);
    red = Target(index: 10, color: c.red);
    amber = Target(index: 20, color: c.amber);
    purple = Target(index: 21, color: c.purple);

    //steps starts in 0
    g.steps.value = 0;

    //set up level number
    g.level.value = 14;

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
      g.targets = [deepOrange, pink300, red, amber, teal, purple];
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

      await g.colorSwitch(amber, pink300);
      await g.delay(duration: 800);

      await g.colorSwitch(red, purple);
      await g.delay(duration: 500);

      g.toGivenPath(pink300, [13, 12, 7, 6, 1]);
      g.toGivenPath(red, [11, 16, 17, 18]);
      await g.toPath(amber, 0);

      g.toGivenPath(teal, [8, 7, 6, 11]);
      g.toPath(red, 15);
      await g.toPath(purple, 9);

      await g.toGivenPath(deepOrange, [3, 2, 7, 6, 5, 10]);

      g.down(amber);
      g.down(pink300);
      await g.down(purple);

      await g.down(purple);

      await g.toPath(purple, 16);

      g.colorSwitch(deepOrange, teal);
      g.toPath(pink300, 8);
      g.toPath(teal, 13);
      await g.toPath(purple, 18);

      // g.colorSwitch(purple, amber);
      g.right(amber);
      g.right(deepOrange);
      await g.right(red, lastMove: true);

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
