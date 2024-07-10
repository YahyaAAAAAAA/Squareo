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

class Level_21 extends StatefulWidget {
  const Level_21({super.key});

  @override
  State<Level_21> createState() => _Level_21State();
}

class _Level_21State extends State<Level_21> {
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
  late Target green;
  late Target orange;
  late Target yellow;
  late Target red;
  late Target blue;
  late Target indigo;

  @override
  void initState() {
    square.hiveDataCheck();

    red = Target(index: 8, color: "0xFFE3D3D3".obs);
    orange = Target(index: 13, color: "0xFFE3D3D3".obs);
    yellow = Target(index: 14, color: "0xFFE3D3D3".obs);
    green = Target(index: 16, color: "0xFFE3D3D3".obs);
    blue = Target(index: 23, color: "0xFFE3D3D3".obs);
    indigo = Target(index: 0, color: "0xFFE3D3D3".obs);

    //steps starts in 0
    g.steps.value = 0;

    //set up level number
    g.level.value = 21;

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
      g.targets = [yellow, green, orange, red, blue, indigo];
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

      g.colorChange(c.red.value, red);
      square.playSound('water');
      await g.delay(duration: 700);

      g.colorChange(c.yellow.value, yellow);
      g.toGivenPath(red, [3, 2, 1, 6, 5]);
      square.playSound('water');
      await g.toGivenPath(yellow, [19, 18, 17, 12, 11]);

      g.colorChange(c.blue.value, blue);
      square.playSound('water');
      await g.toGivenPath(blue, [22, 17, 12, 7, 2]);

      g.colorChange(c.green.value, green);
      g.colorChange(c.indigo.value, indigo);
      square.playSound('water');
      await g.toGivenPath(green, [17, 18, 19, 14, 9]);

      await g.toGivenPath(indigo, [1, 6, 7, 12, 17]);

      g.colorChange(c.orange.value, orange);
      square.playSound('water');
      g.down(orange);
      await g.down(yellow);

      g.left(green);
      await g.right(red, lastMove: true);

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
