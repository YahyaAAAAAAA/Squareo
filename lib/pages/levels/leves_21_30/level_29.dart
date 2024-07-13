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

class Level_29 extends StatefulWidget {
  const Level_29({super.key});

  @override
  State<Level_29> createState() => _Level_29State();
}

class _Level_29State extends State<Level_29> {
  final _scrollController = ScrollController();
  final _gridViewKey = GlobalKey();

  CustomColors c = CustomColors();

  //this specifiy the number of columns , it must be provived and cannot be changed throw the same leve .
  final int columnSize = 6;

  //this specifiy the number of rows , it must be provived and cannot be changed throw the same leve .
  final int rowsSize = 6;

  final int _start = 3;

  Square square = Square();

  //getx controller instance
  final TargetsController g = Get.put(TargetsController());

  //individual targets put in targets list
  late Target white;
  late Target sugar;
  late Target lightGray;
  late Target gray;
  late Target black;
  late Target black400;
  late Target black700;
  late Target black800;

  @override
  void initState() {
    square.hiveDataCheck();

    gray = Target(index: 13, color: "0xFFE3D3D3".obs);
    black = Target(index: 8, color: "0xFFE3D3D3".obs);
    black400 = Target(index: 9, color: "0xFFE3D3D3".obs);
    black700 = Target(index: 20, color: "0xFFE3D3D3".obs);
    sugar = Target(index: 14, color: "0xFFE3D3D3".obs);
    black800 = Target(index: 21, color: "0xFFE3D3D3".obs);
    white = Target(index: 15, color: "0xFFE3D3D3".obs);
    lightGray = Target(index: 16, color: "0xFFE3D3D3".obs);

    //steps starts in 0
    g.steps.value = 0;

    //set up level number
    g.level.value = 29;

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
        sugar,
        white,
        black700,
        black,
        black400,
        gray,
        lightGray,
        black800
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

      black.secondIndex = 2;
      black400.secondIndex = 3;
      gray.secondIndex = 8;
      lightGray.secondIndex = 9;
      sugar.secondIndex = 23;
      white.secondIndex = 30;
      black700.secondIndex = 18;
      black800.secondIndex = 35;

      g.colorChange(c.black.value, black);
      await g.delay(duration: 200);

      g.colorChange(c.black800.value, black800);
      await g.delay(duration: 200);

      g.colorChange(c.black400.value, black400);
      await g.delay(duration: 200);

      g.colorChange(c.black700.value, black700);
      await g.delay(duration: 200);

      g.colorChange(c.sugar.value, sugar);
      await g.delay(duration: 200);

      g.colorChange(c.gray.value, gray);
      await g.delay(duration: 200);
      g.colorChange(c.white.value, white);

      await g.delay(duration: 200);
      g.colorChange(c.lightGray.value, lightGray);

      g.left(gray);
      await g.right(lightGray);

      g.down(black700);
      await g.down(black800);

      g.up(black);
      await g.up(black400);

      g.left(black);
      await g.right(black400);

      g.fade(gray, 8);
      await g.fade(lightGray, 9);

      await g.delay(duration: 200);

      g.fade(white, 24);
      await g.fade(sugar, 29);

      g.up(sugar);
      await g.down(white);

      await g.fade(black700, 18);

      await g.toGivenPath(black800, [33, 34, 35]);

      g.toGivenPath(white, [31, 32, 26]);
      await g.toGivenPath(black, [0, 6, 12]);

      g.toGivenPath(black400, [5, 11, 17]);
      await g.toGivenPath(sugar, [22, 21]);

      g.toGivenPath(black700, [19, 20]);
      await g.toGivenPath(black, [13, 14, 15]);

      g.toGivenPath(black800, [34, 33, 32]);
      await g.toGivenPath(black400, [23, 29, 28, 27]);

      g.fade(lightGray, 22);
      await g.fade(gray, 25);

      await g.to(black, black.index, lastMove: true);

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
              position: CustomIcons.circle_3,
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
