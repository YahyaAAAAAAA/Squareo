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

class Level_28 extends StatefulWidget {
  const Level_28({super.key});

  @override
  State<Level_28> createState() => _Level_28State();
}

class _Level_28State extends State<Level_28> {
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
  late Target como;
  late Target brown700;
  late Target como100;
  late Target brown;
  late Target brown400;
  late Target brown100;
  late Target como700;
  late Target como400;
  late Target brown200;
  late Target como200;

  @override
  void initState() {
    square.hiveDataCheck();

    brown100 = Target(index: 0, color: "0xFFE3D3D3".obs);
    brown200 = Target(index: 1, color: "0xFFE3D3D3".obs);
    brown = Target(index: 35, color: "0xFFE3D3D3".obs);
    brown400 = Target(index: 18, color: "0xFFE3D3D3".obs);
    brown700 = Target(index: 5, color: "0xFFE3D3D3".obs);
    como100 = Target(index: 4, color: "0xFFE3D3D3".obs);
    como200 = Target(index: 19, color: "0xFFE3D3D3".obs);
    como = Target(index: 25, color: "0xFFE3D3D3".obs);
    como400 = Target(index: 22, color: "0xFFE3D3D3".obs);
    como700 = Target(index: 23, color: "0xFFE3D3D3".obs);

    //steps starts in 0
    g.steps.value = 0;

    //set up level number
    g.level.value = 28;

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
        como100,
        como,
        brown700,
        brown,
        brown400,
        brown100,
        como700,
        como400,
        brown200,
        como200
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

      como100.secondIndex = 12;
      como200.secondIndex = 13;
      como400.secondIndex = 16;
      como700.secondIndex = 17;

      brown100.secondIndex = 6;
      brown200.secondIndex = 7;
      brown400.secondIndex = 10;
      brown700.secondIndex = 11;

      brown.secondIndex = 27;
      como.secondIndex = 26;

      g.colorChange(c.brown.value, brown);
      await g.delay(duration: 100);
      g.colorChange(c.brown400.value, brown400);
      await g.delay(duration: 100);
      g.colorChange(c.como100.value, como100);
      await g.delay(duration: 400);
      await g.fade(como100, 12);
      await g.delay(duration: 100);
      await g.fade(brown400, 10);

      g.toGivenPath(brown400, [9, 15, 21]);
      await g.toPath(como100, 30, color: c.cannon100.value);

      await g.delay(duration: 300);

      g.colorChange(c.brown100.value, brown100);
      await g.delay(duration: 100);

      g.colorChange(c.brown200.value, brown200);
      g.toGivenPath(brown200, [7, 8, 9, 3], color: c.bay200.value);
      await g.toPath(brown100, 24, color: c.bay100.value);

      await g.delay(duration: 300);

      g.colorChange(c.como200.value, como200);
      await g.delay(duration: 100);

      g.colorChange(c.como.value, como);
      await g.delay(duration: 100);
      g.colorChange(c.como400.value, como400);
      await g.delay(duration: 100);
      g.colorChange(c.cannon200.value, como200);
      await g.delay(duration: 100);
      g.colorChange(c.brown700.value, brown700);

      g.toPath(como200, 1);
      g.right(como);
      g.colorChange(c.cannon400.value, como400);
      await g.toGivenPath(brown700, [11, 10, 9, 8], color: c.bay.value);

      g.colorChange(c.como700.value, como700);
      await g.up(como700);
      await g.fade(brown, 27);

      g.up(brown100);
      await g.up(como700);

      g.toPath(brown400, 23, color: c.bay400.value);
      g.colorChange(c.cannon.value, como700);
      await g.toGivenPath(brown, [33, 34, 35], lastMove: true);

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
