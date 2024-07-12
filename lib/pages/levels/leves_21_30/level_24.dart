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

class Level_24 extends StatefulWidget {
  const Level_24({super.key});

  @override
  State<Level_24> createState() => _Level_24State();
}

class _Level_24State extends State<Level_24> {
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
  late Target neonOrange;
  late Target neonYellow;
  late Target neonBlue;
  late Target neonLightBlue;
  late Target neonPurple;
  late Target neonGreen;
  late Target neonRed;
  late Target neonPink;

  @override
  void initState() {
    square.hiveDataCheck();

    neonYellow = Target(index: 1, color: "0xFFE3D3D3".obs);
    neonRed = Target(index: 2, color: "0xFFE3D3D3".obs);
    neonOrange = Target(index: 3, color: "0xFFE3D3D3".obs);
    neonGreen = Target(index: 11, color: "0xFFE3D3D3".obs);
    neonLightBlue = Target(index: 12, color: "0xFFE3D3D3".obs);
    neonBlue = Target(index: 13, color: "0xFFE3D3D3".obs);
    neonPink = Target(index: 21, color: "0xFFE3D3D3".obs);
    neonPurple = Target(index: 23, color: "0xFFE3D3D3".obs);

    //steps starts in 0
    g.steps.value = 0;

    //set up level number
    g.level.value = 24;

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
        neonBlue,
        neonOrange,
        neonYellow,
        neonLightBlue,
        neonPurple,
        neonGreen,
        neonRed,
        neonPink,
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

      g.colorChange(c.neonYellow.value, neonYellow);
      await g.delay(duration: 100);
      g.colorChange(c.neonLightBlue.value, neonLightBlue);
      await g.delay(duration: 100);
      g.colorChange(c.neonPurple.value, neonPurple);

      await g.delay(duration: 100);

      g.toGivenPath(neonYellow, [0, 5, 10, 15, 16]);
      await g.toGivenPath(neonPurple, [24, 19, 14, 9, 8]);

      await g.delay(duration: 500);

      g.colorChange(c.neonOrange.value, neonOrange);

      await g.delay(duration: 100);
      g.colorChange(c.neonPink.value, neonPink);

      await g.delay(duration: 100);
      g.toPath(neonPink, 0);
      await g.toPath(neonOrange, 24);

      await g.delay(duration: 500);

      g.colorChange(c.neonBlue.value, neonBlue);
      g.colorChange(c.amber.value, neonOrange);

      await g.toGivenPath(neonBlue, [14, 19, 18, 23]);

      await g.delay(duration: 500);

      g.colorChange(c.neonGreen.value, neonGreen);

      await g.toGivenPath(neonGreen, [10, 15, 20]);

      g.colorChange(c.neonRed.value, neonRed);
      g.colorChange(c.pink300.value, neonPurple);

      g.toGivenPath(neonLightBlue, [11, 10, 5, 6, 1], color: c.pink700.value);
      await g.toGivenPath(neonRed, [3, 4, 9, 14], color: c.pink.value);

      await g.delay(duration: 300);

      await g.right(neonLightBlue);
      g.toGivenPath(neonPink, [5, 6]);
      g.up(neonYellow);
      g.up(neonGreen);
      g.colorChange(c.green300.value, neonYellow);
      g.colorChange(c.green.value, neonPink);

      await g.toGivenPath(neonBlue, [22, 21], color: c.amberAccent.value);
      await g.right(neonPink);

      await g.left(neonOrange);
      g.up(neonBlue);
      g.colorChange(c.green700.value, neonGreen);

      await g.left(neonOrange, lastMove: true);

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
