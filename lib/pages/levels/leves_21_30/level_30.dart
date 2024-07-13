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

class Level_30 extends StatefulWidget {
  const Level_30({super.key});

  @override
  State<Level_30> createState() => _Level_30State();
}

class _Level_30State extends State<Level_30> {
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
  late Target brown300;
  late Target blue;
  late Target brown700;
  late Target pink;
  late Target blue300;
  late Target blue700;
  late Target pink700;
  late Target brown;
  late Target pink300;

  @override
  void initState() {
    square.hiveDataCheck();

    blue300 = Target(index: 12, color: "0xFFE3D3D3".obs);
    blue = Target(index: 26, color: "0xFFE3D3D3".obs);
    blue700 = Target(index: 19, color: "0xFFE3D3D3".obs);

    brown300 = Target(index: 2, color: "0xFFE3D3D3".obs);
    brown = Target(index: 16, color: "0xFFE3D3D3".obs);
    brown700 = Target(index: 9, color: "0xFFE3D3D3".obs);

    pink300 = Target(index: 23, color: "0xFFE3D3D3".obs);
    pink = Target(index: 33, color: "0xFFE3D3D3".obs);
    pink700 = Target(index: 28, color: "0xFFE3D3D3".obs);

    white = Target(index: 7, color: "0xFFE3D3D3".obs);

    //steps starts in 0
    g.steps.value = 0;

    //set up level number
    g.level.value = 30;

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
        brown300,
        white,
        brown,
        pink,
        blue300,
        blue700,
        pink700,
        brown700,
        blue,
        pink300
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

      blue300.secondIndex = 4;
      blue.secondIndex = 11;
      blue700.secondIndex = 15;

      brown300.secondIndex = 24;
      brown.secondIndex = 31;
      brown700.secondIndex = 20;

      white.secondIndex = 7;

      pink700.secondIndex = 14;
      pink.secondIndex = 21;
      pink300.secondIndex = 28;

      g.colorChange(c.prim_blue300.value, blue300);
      g.colorChange(c.prim_brown300.value, brown300);
      await g.delay(duration: 200);

      g.colorChange(c.prim_blue700.value, blue700);
      g.colorChange(c.prim_brown700.value, brown700);
      await g.delay(duration: 200);

      g.colorChange(c.prim_blue.value, blue);
      g.colorChange(c.prim_brown.value, brown);
      await g.delay(duration: 200);

      g.fade(blue300, 3);
      await g.delay(duration: 200);
      g.fade(blue700, 10);
      await g.delay(duration: 200);
      g.fade(blue, 17);

      g.fade(brown300, 18);
      await g.delay(duration: 200);
      g.fade(brown700, 25);
      await g.delay(duration: 200);
      g.fade(brown, 32);

      await g.delay(duration: 600);

      g.right(blue300);
      g.up(blue);
      g.down(brown300);
      await g.left(brown);

      await g.delay(duration: 300);

      g.fade(brown700, 20);
      g.fade(blue700, 15);
      await g.delay(duration: 200);

      g.colorChange(c.white.value, white);
      await g.delay(duration: 200);

      g.colorChange(c.prim_pink.value, pink);
      await g.delay(duration: 200);

      g.colorChange(c.prim_pink300.value, pink300);
      await g.delay(duration: 200);

      g.colorChange(c.prim_pink700.value, pink700);
      await g.delay(duration: 200);

      g.right(pink);
      await g.down(pink300);

      await g.fade(pink700, 21);

      g.colorChange(c.lightGray.value, white);
      g.up(blue700);
      await g.left(brown700);
      await g.fade(white, 14);
      await g.delay(duration: 400);

      g.colorChange(c.gray.value, white);
      g.left(blue700);
      await g.up(brown700);

      await g.fade(white, 7);

      g.toGivenPath(blue300, [10, 16, 15]);
      g.toGivenPath(blue, [17, 23, 22]);
      g.toGivenPath(brown300, [25, 26, 20]);
      await g.toGivenPath(brown, [32, 33, 27]);

      await g.fade(pink700, 14);

      await g.delay(duration: 400);

      g.up(pink300);
      await g.left(pink);

      await g.delay(duration: 400);

      g.fade(pink, 28);
      await g.fade(pink300, 21);

      g.colorChange(c.black.value, white);
      await g.fade(white, 0);

      g.up(blue700);
      await g.left(brown700);

      g.up(blue300);
      await g.left(brown300);

      g.up(blue);
      await g.left(brown);

      g.fade(pink300, 33);
      await g.fade(pink, 23);

      g.colorChange(c.screamingGreen.value, pink700);
      g.toPath(pink300, 30, color: c.screamingGreen700.value);
      await g.toPath(pink, 5, color: c.screamingGreen300.value);

      await g.to(pink, pink.index, lastMove: true);

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
