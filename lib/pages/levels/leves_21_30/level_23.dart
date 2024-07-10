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

class Level_23 extends StatefulWidget {
  const Level_23({super.key});

  @override
  State<Level_23> createState() => _Level_23State();
}

class _Level_23State extends State<Level_23> {
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
  late Target loch700;
  late Target turq700;
  late Target turq;
  late Target turq300;
  late Target loch;
  late Target tealAccent;
  late Target teal;
  late Target tealAccent300;

  @override
  void initState() {
    square.hiveDataCheck();

    turq300 = Target(index: 4, color: "0xFFE3D3D3".obs);
    turq = Target(index: 8, color: "0xFFE3D3D3".obs);
    turq700 = Target(index: 13, color: "0xFFE3D3D3".obs);
    tealAccent300 = Target(index: 6, color: "0xFFE3D3D3".obs);
    tealAccent = Target(index: 12, color: "0xFFE3D3D3".obs);
    teal = Target(index: 17, color: "0xFFE3D3D3".obs);
    loch700 = Target(index: 16, color: "0xFFE3D3D3".obs);
    loch = Target(index: 20, color: "0xFFE3D3D3".obs);

    //steps starts in 0
    g.steps.value = 0;

    //set up level number
    g.level.value = 23;

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
        turq,
        loch700,
        turq700,
        turq300,
        loch,
        tealAccent,
        teal,
        tealAccent300,
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

      g.colorChange(c.tealAccent300.value, tealAccent300);
      await g.delay(duration: 100);
      g.colorChange(c.teal.value, teal);
      await g.delay(duration: 100);
      g.colorChange(c.turquoise700.value, turq700);

      g.down(teal);
      g.colorChange(c.turquoise300.value, turq300);
      g.colorChange(c.lochinvar.value, loch);
      g.toPath(loch, 5);
      g.toPath(turq300, 1);
      await g.right(turq700);

      await g.delay(duration: 1000);

      g.colorChange(c.lochinvar700.value, loch700);
      await g.delay(duration: 100);

      g.colorChange(c.tealAccent.value, tealAccent);
      await g.delay(duration: 100);

      g.colorChange(c.turquoise.value, turq);
      await g.delay(duration: 200);

      g.toGivenPath(loch700, [15, 20]);
      await g.toGivenPath(turq, [3, 4]);

      g.toGivenPath(turq700, [9, 8]);
      g.toGivenPath(teal, [21, 16]);
      await g.toGivenPath(tealAccent, [17, 18, 23, 24]);

      await g.toGivenPath(tealAccent300, [11, 12]);

      g.right(turq300);
      await g.down(loch, lastMove: true);

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
