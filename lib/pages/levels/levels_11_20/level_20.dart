import 'package:Squareo/compnents/custom_icons.dart';
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

class Level_20 extends StatefulWidget {
  const Level_20({super.key});

  @override
  State<Level_20> createState() => _Level_20State();
}

class _Level_20State extends State<Level_20> {
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
  late Target red;
  late Target red300;
  late Target red700;
  late Target mexRed;
  late Target mexRed300;
  late Target mexRed700;
  late Target scarlet;
  late Target scarlet700;
  late Target scarlet300;

  @override
  void initState() {
    square.hiveDataCheck();

    mexRed700 = Target(index: 2, color: c.mexRed700);
    mexRed = Target(index: 6, color: c.mexRed);
    mexRed300 = Target(index: 8, color: c.mexRed300);
    red300 = Target(index: 10, color: c.red300);
    scarlet = Target(index: 12, color: c.scarlet);
    scarlet300 = Target(index: 14, color: c.scarlet300);
    red = Target(index: 16, color: c.red);
    red700 = Target(index: 18, color: c.red700);
    scarlet700 = Target(index: 22, color: c.scarlet700);

    //steps starts in 0
    g.steps.value = 0;

    //set up level number
    g.level.value = 20;

    //activate second index position
    g.secondIndex = true;

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
        mexRed300,
        red300,
        mexRed,
        red700,
        red,
        mexRed700,
        scarlet,
        scarlet700,
        scarlet300,
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

      mexRed700.secondIndex = mexRed700.initIndex + columnSize;
      scarlet700.secondIndex = scarlet700.initIndex - columnSize;
      mexRed.secondIndex = mexRed.initIndex - 1;
      mexRed300.secondIndex = mexRed300.initIndex + 1;
      red.secondIndex = red.initIndex - 1;
      red700.secondIndex = red700.initIndex + 1;
      red300.secondIndex = red300.initIndex + 1;
      scarlet300.secondIndex = scarlet300.initIndex - 1;

      g.down(mexRed700);
      await g.up(scarlet700);

      g.right(red300);
      await g.left(scarlet300);

      g.right(red700);
      await g.left(red);

      g.down(red700);
      g.down(red);
      await g.down(scarlet700);

      g.down(red300);
      await g.down(scarlet300);

      g.up(mexRed700);
      g.left(mexRed);
      await g.right(mexRed300);

      g.down(mexRed700);
      g.down(mexRed);
      await g.down(mexRed300);

      await g.toGivenPath(red300, [red300.index], lastMove: true);

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
              canChange: false,
              position: CustomIcons.circle_2,
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
