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

class Level_18 extends StatefulWidget {
  const Level_18({super.key});

  @override
  State<Level_18> createState() => _Level_18State();
}

class _Level_18State extends State<Level_18> {
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
  late Target pink1;
  late Target pink2;
  late Target piege1;
  late Target piege2;
  late Target blue1;
  late Target blue2;

  @override
  void initState() {
    square.hiveDataCheck();

    pink1 = Target(index: 14, color: c.prim_1);
    pink2 = Target(index: 23, color: c.prim_1);
    piege1 = Target(index: 1, color: c.prim_2);
    piege2 = Target(index: 3, color: c.prim_2);
    blue1 = Target(index: 10, color: c.prim_3);
    blue2 = Target(index: 21, color: c.prim_3);

    //steps starts in 0
    g.steps.value = 0;

    //set up level number
    g.level.value = 18;

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
        blue1,
        pink2,
        piege2,
        piege1,
        pink1,
        blue2,
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

      pink1.secondIndex = pink1.initIndex - 1;
      blue1.secondIndex = blue1.initIndex + 1;
      piege1.secondIndex = piege1.initIndex - 1;
      piege2.secondIndex = piege2.initIndex + columnSize;
      blue2.secondIndex = blue2.initIndex - columnSize;
      pink2.secondIndex = pink2.initIndex - 1;

      g.left(pink1);
      await g.right(blue1);

      g.left(pink1);
      await g.up(blue1);

      g.left(piege1);
      await g.left(piege2);

      g.down(piege1);
      await g.down(piege2);

      g.left(pink2);
      await g.up(blue2);
      g.toPath(pink2, 10);
      await g.toPath(blue2, 4);

      await g.left(blue2);
      g.right(piege2);
      g.right(blue1);
      g.right(piege1);
      g.right(pink1);
      g.right(pink2);
      await g.left(blue2, lastMove: true);

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
