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

class Level_8 extends StatefulWidget {
  const Level_8({super.key});

  @override
  State<Level_8> createState() => _Level_8State();
}

class _Level_8State extends State<Level_8> {
  final _scrollController = ScrollController();
  final _gridViewKey = GlobalKey();

  CustomColors c = CustomColors();

  //this specifiy the number of columns , it must be provived and cannot be changed throw the same leve .
  final int columnSize = 5;

  //this specifiy the number of rows , it must be provived and cannot be changed throw the same leve .
  final int rowsSize = 5;

  //this is the currnet level , it mus be provided and cannot be changed throw the same leve .
  final int level = 8;

  //getx controller instance
  final TargetsController g = Get.put(TargetsController());

  //individual targets put in targets list ^
  late Target purple;
  late Target green;
  late Target green2;
  late Target blue;
  late Target yellow;
  late Target purple2;

  final int _start = 3;

  Square square = Square();

  @override
  void initState() {
    square.hiveDataCheck();
    super.initState();

    //   int target2 = 2;
    // int target7 = 7;
    // int target9 = 9;
    // int target11 = 11;
    // int target18 = 18;
    // int target22 = 22;

    purple = Target(index: 2, color: c.purple);
    green = Target(index: 7, color: c.green);
    green2 = Target(index: 9, color: c.green);
    blue = Target(index: 11, color: c.blue);
    yellow = Target(index: 18, color: c.yellow);
    purple2 = Target(index: 22, color: c.purple);

    //steps starts in 0
    g.steps.value = 0;

    //set up level number
    g.level.value = 8;

    //passing context
    g.context = context;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //make sure startTime only called once , same with showAlert
      square.startTimer(context, _start);
      square.showAlert(context, _start);

      //initlize the grid size [rows,columns] (must be called)
      g.gridSize = [rowsSize, columnSize];
      //initlize the targets (must be called to reset the values on restart)
      g.targets = [purple, green, green2, blue, yellow, purple2];
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

      g.up(purple);
      g.left(blue);
      g.up(green2);
      await g.left(purple2);

      g.down(green);
      g.left(green2);
      await g.right(blue);

      g.up(yellow);
      g.down(purple);
      g.down(green);
      await g.left(purple2);

      g.down(green2);
      g.right(yellow);
      g.down(blue);
      await g.up(purple2);

      g.left(purple);
      g.left(green2);
      g.up(green);
      await g.up(purple2);

      g.left(yellow);
      g.up(purple);
      await g.up(blue);

      g.down(green);
      g.up(yellow);
      await g.up(green2);

      g.left(purple);
      g.right(green);
      await g.up(blue);

      g.right(green2);
      g.left(blue);
      g.left(yellow);
      await g.up(purple);

      g.down(green);
      await g.right(purple2);

      g.left(green2);
      await g.right(purple);

      g.right(green2);
      g.right(green);
      await g.left(purple);

      g.right(green);
      g.right(blue);
      await g.down(purple2);

      g.left(green);
      g.right(purple2);
      await g.left(purple2, lastMove: true);

      //setState must be called to render the list (FOR SOME REASON !!!!!)
      setState(() {});

      //post frame callback end
    });
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
              coins: square.db.coins,
              title: "Level $level",
              unlockFlag: g.unlockFlag.value,
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
