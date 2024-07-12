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

class Level_27 extends StatefulWidget {
  const Level_27({super.key});

  @override
  State<Level_27> createState() => _Level_27State();
}

class _Level_27State extends State<Level_27> {
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
  late Target yellow300;
  late Target pGreen;
  late Target green300;
  late Target pPink;
  late Target pYellow;
  late Target blue300;
  late Target pPurple;
  late Target pink300;
  late Target pBlue;
  late Target purple300;

  @override
  void initState() {
    square.hiveDataCheck();

    pPink = Target(index: 4, color: "0xFFE3D3D3".obs);
    pGreen = Target(index: 0, color: "0xFFE3D3D3".obs);
    pPurple = Target(index: 14, color: "0xFFE3D3D3".obs);
    pYellow = Target(index: 28, color: "0xFFE3D3D3".obs);
    pBlue = Target(index: 12, color: "0xFFE3D3D3".obs);
    pink300 = Target(index: 10, color: "0xFFE3D3D3".obs);
    blue300 = Target(index: 18, color: "0xFFE3D3D3".obs);
    yellow300 = Target(index: 29, color: "0xFFE3D3D3".obs);
    green300 = Target(index: 1, color: "0xFFE3D3D3".obs);
    purple300 = Target(index: 15, color: "0xFFE3D3D3".obs);

    //steps starts in 0
    g.steps.value = 0;

    //set up level number
    g.level.value = 27;

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
        green300,
        yellow300,
        pGreen,
        pPink,
        pYellow,
        blue300,
        pPurple,
        pink300,
        pBlue,
        purple300
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

      g.colorChange(c.pastelGreen.value, pGreen);
      await g.delay(duration: 100);

      g.colorChange(c.green300.value, green300);
      await g.delay(duration: 300);

      g.fade(pGreen, 20);
      await g.delay(duration: 100);

      await g.fade(green300, 21);

      g.colorChange(c.pastelPink.value, pPink);
      await g.delay(duration: 100);

      g.colorChange(c.pink300.value, pink300);
      await g.delay(duration: 300);

      g.fade(pPink, 26);
      await g.delay(duration: 100);

      await g.fade(pink300, 25);

      g.toGivenPath(green300, [22, 16, 10, 11]);
      await g.toGivenPath(pink300, [19, 13, 7, 8]);

      await g.delay(duration: 500);

      g.colorChange(c.pastelPurple.value, pPurple);
      await g.delay(duration: 100);

      g.colorChange(c.purple300.value, purple300);
      g.toGivenPath(purple300, [21, 27]);
      await g.toGivenPath(pPurple, [13, 7, 1]);

      await g.delay(duration: 500);

      g.colorChange(c.pastelBlue.value, pBlue);
      await g.delay(duration: 100);

      g.colorChange(c.blue300.value, blue300);
      g.toGivenPath(blue300, [19, 25, 24]);
      await g.toPath(pBlue, 17);

      await g.delay(duration: 400);

      g.colorChange(c.pastelYellow.value, pYellow);
      await g.delay(duration: 100);

      g.colorChange(c.yellow200.value, yellow300);
      await g.fade(pYellow, 6);

      await g.toGivenPath(yellow300, [23, 22, 16, 10, 4]);

      await g.fade(blue300, 3);
      g.toPath(pYellow, 24);
      await g.toGivenPath(blue300, [9, 15, 21, 22, 28]);

      g.fade(pPink, 6);
      g.fade(pPurple, 13);
      await g.fade(pGreen, 29);

      g.toGivenPath(pPink, [12, 18, 19]);
      g.left(purple300);
      g.toGivenPath(yellow300, [3, 9, 15, 21, 27]);
      await g.toGivenPath(pGreen, [23, 22, 16, 10, 9]);

      g.fade(green300, 22);
      await g.delay(duration: 300);

      g.right(blue300);
      await g.left(pBlue, lastMove: true);

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
