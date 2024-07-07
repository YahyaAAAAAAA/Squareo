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

class Level_19 extends StatefulWidget {
  const Level_19({super.key});

  @override
  State<Level_19> createState() => _Level_19State();
}

class _Level_19State extends State<Level_19> {
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
  late Target lima;
  late Target lima300;
  late Target lima700;
  late Target jungle;
  late Target jungle300;
  late Target jungle700;
  late Target violet;
  late Target violet300;

  @override
  void initState() {
    square.hiveDataCheck();

    lima = Target(index: 8, color: c.lima);
    lima300 = Target(index: 9, color: c.lima300);
    lima700 = Target(index: 7, color: c.lima700);
    jungle = Target(index: 12, color: c.jungle);
    jungle300 = Target(index: 13, color: c.jungle300);
    jungle700 = Target(index: 11, color: c.jungle700);
    violet = Target(index: 15, color: c.violet);
    violet300 = Target(index: 16, color: c.violet300);

    //steps starts in 0
    g.steps.value = 0;

    //set up level number
    g.level.value = 19;

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
        jungle300,
        lima300,
        jungle,
        lima700,
        lima,
        jungle700,
        violet,
        violet300,
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

      lima700.secondIndex = lima700.initIndex - columnSize;
      lima.secondIndex = lima.initIndex + 1;
      lima300.secondIndex = lima300.initIndex + columnSize;
      jungle700.secondIndex = jungle700.initIndex - columnSize;
      jungle.secondIndex = jungle.initIndex + 1;
      jungle300.secondIndex = jungle300.initIndex + columnSize;
      violet.secondIndex = violet.initIndex - columnSize;
      violet300.secondIndex = violet300.initIndex + columnSize;

      g.up(lima700);
      g.up(jungle700);
      await g.delay(duration: 300);

      g.down(lima300);
      await g.down(jungle300);

      await g.delay(duration: 300);

      g.right(lima);
      await g.right(jungle);

      g.up(violet);
      await g.down(violet300);

      await g.up(lima);

      g.toPath(lima700, 22);
      await g.down(lima300);

      await g.down(lima300);

      g.toPath(lima, 0);
      await g.toPath(lima300, 23);

      g.toGivenPath(jungle, [8, 9, 4, 3, 2]);
      await g.toGivenPath(jungle700, [11, 12]);

      g.toGivenPath(violet, [5, 6, 7]);
      await g.toGivenPath(violet300, [16, 17]);

      g.right(lima);
      await g.toGivenPath(lima300, [18, 13], lastMove: true);

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
