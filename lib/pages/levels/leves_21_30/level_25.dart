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

class Level_25 extends StatefulWidget {
  const Level_25({super.key});

  @override
  State<Level_25> createState() => _Level_25State();
}

class _Level_25State extends State<Level_25> {
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
  late Target tacao700;
  late Target tacao;
  late Target portage700;
  late Target portage;
  late Target riptide;
  late Target portage300;
  late Target tacao300;
  late Target riptide300;
  late Target riptide700;

  @override
  void initState() {
    square.hiveDataCheck();

    tacao300 = Target(index: 7, color: "0xFFE3D3D3".obs);
    tacao = Target(index: 9, color: "0xFFE3D3D3".obs);
    tacao700 = Target(index: 16, color: "0xFFE3D3D3".obs);
    portage300 = Target(index: 0, color: "0xFFE3D3D3".obs);
    portage = Target(index: 18, color: "0xFFE3D3D3".obs);
    portage700 = Target(index: 11, color: "0xFFE3D3D3".obs);
    riptide300 = Target(index: 25, color: "0xFFE3D3D3".obs);
    riptide = Target(index: 27, color: "0xFFE3D3D3".obs);
    riptide700 = Target(index: 22, color: "0xFFE3D3D3".obs);

    //steps starts in 0
    g.steps.value = 0;

    //set up level number
    g.level.value = 25;

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
        portage700,
        tacao700,
        tacao,
        portage,
        riptide,
        portage300,
        tacao300,
        riptide300,
        riptide700,
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

      g.colorChange(c.riptide700.value, riptide700);
      await g.delay(duration: 100);

      g.colorChange(c.tacao.value, tacao);
      await g.delay(duration: 100);

      g.colorChange(c.portage.value, portage);
      await g.delay(duration: 100);

      g.colorChange(c.portage300.value, portage300);
      g.down(portage300);
      g.right(riptide700);
      g.right(tacao);

      await g.down(portage);

      g.down(portage300);
      g.down(riptide700);

      await g.up(tacao);

      await g.right(tacao);

      await g.delay(duration: 300);

      g.colorChange(c.riptide.value, riptide);
      await g.delay(duration: 100);
      g.colorChange(c.riptide300.value, riptide300);

      g.toPath(riptide, 3);
      await g.toPath(riptide300, 2);

      g.colorChange(c.portage700.value, portage700);
      g.colorChange(c.tacao300.value, tacao300);
      g.colorChange(c.orange.value, riptide);
      await g.toGivenPath(portage700, [10, 9, 15, 14, 20, 26]);

      g.down(riptide300);
      g.up(tacao300);
      g.colorChange(c.yellow700.value, portage700);
      g.colorChange(c.orange300.value, riptide300);
      await g.down(riptide);

      g.down(riptide300);
      g.down(riptide);
      await g.toGivenPath(tacao300, [2, 3, 4]);

      g.colorChange(c.tacao700.value, tacao700);
      g.colorChange(c.yellow.value, portage);
      g.colorChange(c.yellow200.value, portage300);
      g.down(tacao);
      g.right(portage300);
      g.right(portage);
      await g.toGivenPath(tacao700, [22, 23, 17]);

      g.right(tacao300);
      g.up(portage);
      g.colorChange(c.orange700.value, riptide700);
      await g.toGivenPath(riptide700, [28, 22, 16]);

      await g.left(portage700, lastMove: true);

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
