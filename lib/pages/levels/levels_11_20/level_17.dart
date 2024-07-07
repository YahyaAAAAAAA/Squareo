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

class Level_17 extends StatefulWidget {
  const Level_17({super.key});

  @override
  State<Level_17> createState() => _Level_17State();
}

class _Level_17State extends State<Level_17> {
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
  late Target lightBlue;
  late Target indigo300;
  late Target lightBlue300;
  late Target indigo;
  late Target lightBlue700;
  late Target cyan700;
  late Target cyan;
  late Target cyan300;

  @override
  void initState() {
    square.hiveDataCheck();

    lightBlue = Target(index: 1, color: c.lightBlue);
    lightBlue300 = Target(index: 22, color: c.lightBlue300);
    lightBlue700 = Target(index: 11, color: c.lightBlue700);
    indigo = Target(index: 2, color: c.indigo);
    indigo300 = Target(index: 23, color: c.indigo300);
    cyan700 = Target(index: 14, color: c.cyan700);
    cyan = Target(index: 3, color: c.cyan);
    cyan300 = Target(index: 21, color: c.cyan300);

    //steps starts in 0
    g.steps.value = 0;

    //set up level number
    g.level.value = 17;

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
        indigo300,
        lightBlue300,
        indigo,
        lightBlue700,
        lightBlue,
        cyan700,
        cyan,
        cyan300
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
      g.down(lightBlue);
      g.down(cyan);
      g.up(indigo300);
      g.up(cyan300);
      g.toPath(indigo, 12);
      await g.left(cyan700);

      g.colorSwitch(indigo, lightBlue300);
      g.left(lightBlue);
      await g.left(cyan300);

      g.colorSwitch(lightBlue, cyan);
      g.right(cyan);
      await g.right(indigo300);

      g.colorSwitch(lightBlue700, cyan700);
      g.up(indigo);
      await g.up(lightBlue300);

      await g.to(lightBlue700, lightBlue700.index, lastMove: true);

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
