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

class Level_22 extends StatefulWidget {
  const Level_22({super.key});

  @override
  State<Level_22> createState() => _Level_22State();
}

class _Level_22State extends State<Level_22> {
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
  late Target yellowAccent400;
  late Target black700;
  late Target black300;
  late Target black;
  late Target yellowAccent;
  late Target purple700;
  late Target purple;

  @override
  void initState() {
    square.hiveDataCheck();

    black700 = Target(index: 2, color: "0xFFE3D3D3".obs);
    purple700 = Target(index: 6, color: "0xFFE3D3D3".obs);
    black300 = Target(index: 8, color: "0xFFE3D3D3".obs);
    yellowAccent400 = Target(index: 10, color: "0xFFE3D3D3".obs);
    purple = Target(index: 14, color: "0xFFE3D3D3".obs);
    black = Target(index: 16, color: "0xFFE3D3D3".obs);
    yellowAccent = Target(index: 18, color: "0xFFE3D3D3".obs);

    //steps starts in 0
    g.steps.value = 0;

    //set up level number
    g.level.value = 22;

    //activate second index position
    g.secondIndex = false;

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
        black300,
        yellowAccent400,
        black700,
        black,
        yellowAccent,
        purple700,
        purple
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
      g.colorChange(c.black.value, black);
      square.playSound('water');
      await g.delay(duration: 500);

      g.colorChange(c.black300.value, black300);
      g.toGivenPath(black300, [9, 4, 3, 8, 7, 12]);
      square.playSound('water');
      await g.toGivenPath(black, [11, 12, 17, 22, 21, 20]);

      g.colorChange(c.yellowAccent.value, yellowAccent);
      square.playSound('water');
      await g.delay(duration: 500);

      g.colorChange(c.yellowAccent400.value, yellowAccent400);
      g.toGivenPath(yellowAccent400, [11, 16, 15]);
      square.playSound('water');
      await g.toGivenPath(yellowAccent, [19, 24, 23]);

      g.colorChange(c.purple700.value, purple700);
      square.playSound('water');
      await g.delay(duration: 500);

      g.colorChange(c.purple.value, purple);
      g.toGivenPath(purple, [13, 8, 9, 4, 3]);
      square.playSound('water');
      await g.toGivenPath(purple700, [5, 0, 1, 6, 7]);

      g.colorChange(c.black700.value, black700);
      g.right(black);
      g.right(black300);
      square.playSound('water');
      await g.toGivenPath(black700, [1, 0, 5, 10, 11, 16, 17]);

      g.right(yellowAccent);
      g.right(purple);
      g.left(purple700);
      g.up(black);
      g.up(black300);
      g.up(black700);
      await g.down(yellowAccent400, lastMove: true);

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
              position: CustomIcons.circle_1,
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
