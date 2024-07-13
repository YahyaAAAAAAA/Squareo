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

class Level_26 extends StatefulWidget {
  const Level_26({super.key});

  @override
  State<Level_26> createState() => _Level_26State();
}

class _Level_26State extends State<Level_26> {
  final _scrollController = ScrollController();
  final _gridViewKey = GlobalKey();

  CustomColors c = CustomColors();

  //this specifiy the number of columns , it must be provived and cannot be changed throw the same leve .
  final int columnSize = 6;

  //this specifiy the number of rows , it must be provived and cannot be changed throw the same leve .
  final int rowsSize = 5;

  final int _start = 3;

  Square square = Square();

  //getx controller instance
  final TargetsController g = Get.put(TargetsController());

  //individual targets put in targets list
  late Target sun700;
  late Target gold400;
  late Target sun800;
  late Target gold300;
  late Target gold700;
  late Target sun;
  late Target gold;
  late Target sun300;
  late Target gold800;

  @override
  void initState() {
    square.hiveDataCheck();

    gold300 = Target(index: 1, color: "0xFFE3D3D3".obs);
    gold400 = Target(index: 2, color: "0xFFE3D3D3".obs);
    gold = Target(index: 7, color: "0xFFE3D3D3".obs);
    gold700 = Target(index: 8, color: "0xFFE3D3D3".obs);
    gold800 = Target(index: 9, color: "0xFFE3D3D3".obs);
    sun300 = Target(index: 15, color: "0xFFE3D3D3".obs);
    sun = Target(index: 16, color: "0xFFE3D3D3".obs);
    sun700 = Target(index: 21, color: "0xFFE3D3D3".obs);
    sun800 = Target(index: 22, color: "0xFFE3D3D3".obs);

    //steps starts in 0
    g.steps.value = 0;

    //set up level number
    g.level.value = 26;

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
        sun800,
        sun700,
        gold400,
        gold300,
        gold700,
        sun,
        gold,
        sun300,
        gold800,
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

      g.colorChange(c.gold300.value, gold300);
      await g.delay(duration: 200);

      g.colorChange(c.gold400.value, gold400);
      await g.delay(duration: 200);

      g.colorChange(c.sunflower700.value, sun700);
      await g.delay(duration: 200);

      g.colorChange(c.sunflower800.value, sun800);

      g.toGivenPath(gold400, [3, 4]);
      g.toGivenPath(sun700, [20, 19]);
      g.toGivenPath(gold300, [0, 6, 12, 18]);
      await g.toGivenPath(sun800, [23, 17, 11, 5]);

      await g.delay(duration: 300);

      g.colorChange(c.sunflower300.value, sun300);
      await g.delay(duration: 100);

      g.colorChange(c.sunflower.value, sun);
      g.down(sun300);
      await g.down(sun);

      await g.delay(duration: 300);

      g.colorChange(c.gold.value, gold);
      await g.delay(duration: 100);

      g.colorChange(c.gold700.value, gold700);
      await g.delay(duration: 100);

      g.colorChange(c.gold800.value, gold800);

      g.toGivenPath(gold700, [2, 1, 0], color: c.red700.value);
      await g.toGivenPath(gold800, [15, 16, 17, 23, 29],
          color: c.mexRed700.value);

      g.toGivenPath(sun300, [27, 26, 25, 24]);
      await g.toGivenPath(gold, [8, 9, 10, 11], color: c.red.value);

      g.toGivenPath(sun, [21, 15, 9, 10]);
      await g.toGivenPath(sun700, [20, 14, 8, 7]);

      g.toGivenPath(sun300, [25, 26, 27, 27, 21]);
      await g.toGivenPath(gold300, [19, 20, 21, 15], color: c.red300.value);

      g.toGivenPath(gold800, [28, 27, 26, 20]);
      g.colorChange(c.mexRed300.value, gold400);
      await g.toGivenPath(gold700, [1, 2, 8, 14]);

      await g.toGivenPath(sun700, [8, 9], lastMove: true);

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
