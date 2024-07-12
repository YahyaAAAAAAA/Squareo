import 'package:Squareo/compnents/custom_icons.dart';
import 'package:Squareo/pages/levels/levels_11_20/level_11.dart';
import 'package:Squareo/pages/levels/levels_11_20/level_12.dart';
import 'package:Squareo/pages/levels/levels_11_20/level_13.dart';
import 'package:Squareo/pages/levels/levels_11_20/level_14.dart';
import 'package:Squareo/pages/levels/levels_11_20/level_15.dart';
import 'package:Squareo/pages/levels/levels_11_20/level_16.dart';
import 'package:Squareo/pages/levels/levels_11_20/level_17.dart';
import 'package:Squareo/pages/levels/levels_11_20/level_18.dart';
import 'package:Squareo/pages/levels/levels_11_20/level_19.dart';
import 'package:Squareo/pages/levels/levels_11_20/level_20.dart';
import 'package:Squareo/pages/levels/leves_21_30/level_21.dart';
import 'package:Squareo/pages/levels/leves_21_30/level_22.dart';
import 'package:Squareo/pages/levels/leves_21_30/level_23.dart';
import 'package:Squareo/pages/levels/leves_21_30/level_24.dart';
import 'package:Squareo/pages/levels/leves_21_30/level_25.dart';
import 'package:Squareo/pages/levels/leves_21_30/level_26.dart';
import 'package:Squareo/pages/levels/leves_21_30/level_27.dart';
import 'package:Squareo/pages/levels/leves_21_30/level_28.dart';
import 'package:Squareo/pages/scores_page.dart';
import 'package:Squareo/utils/square.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:get/get.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:numeral/numeral.dart';
import 'package:Squareo/utils/colors.dart';
import 'package:Squareo/pages/home_page.dart';
import 'package:Squareo/pages/levels/levels_1_10/level_1.dart';
import 'package:Squareo/pages/levels/levels_1_10/level_10.dart';
import 'package:Squareo/pages/levels/levels_1_10/level_2.dart';
import 'package:Squareo/pages/levels/levels_1_10/level_3.dart';
import 'package:Squareo/pages/levels/levels_1_10/level_4.dart';
import 'package:Squareo/pages/levels/levels_1_10/level_5.dart';
import 'package:Squareo/pages/levels/levels_1_10/level_6.dart';
import 'package:Squareo/pages/levels/levels_1_10/level_7.dart';
import 'package:Squareo/pages/levels/levels_1_10/level_8.dart';
import 'package:Squareo/pages/levels/levels_1_10/level_9.dart';

class LevelsPage extends StatefulWidget {
  const LevelsPage({super.key});

  @override
  State<LevelsPage> createState() => _LevelsPageState();
}

class _LevelsPageState extends State<LevelsPage> {
  //colors
  CustomColors c = CustomColors();

  //number of total levels
  List levels = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30
  ];

  //controller for moving through pages using left and right arrow icons
  CarouselController? carouselController;

  Square square = Square();

  @override
  void initState() {
    square.hiveDataCheck();

    carouselController = CarouselController();

    super.initState();
  }

  //method to show a message when player click on a locked level
  void showScaffoldMessenger(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: c.textColor,
        duration: Duration(milliseconds: 700),
        content: Text(
          'Level ${index + 1} is locked, beat level ${index} to unlock it',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: c.mainColor1,
            fontSize: 16,
            fontFamily: 'Abel',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //* Levels page , used to access the levels and show which is locked and unlocked .

    ///the lists are seperated with thier ui and [onTap] on methods , cuz of limitation on the [CarouselSlider] end
    ///each list is updated with every level added by thier on [onTap] , if(index == 1) takes you to [Level_2] the check if a level is unlocked with the same indexing as the routing
    //* a display of levels from 1 to 10
    final generatedChildren_1 = List.generate(
      10,
      (index) => TextButton(
        onPressed: () => levels_1_10(index),
        style: buttonStyle(),
        child: numbers_1_10(index),
      ),
    );

    //* a dis play of levels from 11 to 20
    final generatedChildren_2 = List.generate(
      10,
      (index) => TextButton(
        onPressed: () => levels_11_20(index),
        style: buttonStyle(),
        child: numbers_11_20(index),
      ),
    );

    //*  a dis play of levels from 21 to 30
    final generatedChildren_3 = List.generate(
      10,
      (index) => TextButton(
        onPressed: () => levels_21_30(index),
        style: buttonStyle(),
        child: numbers_21_30(index),
      ),
    );

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) =>
          Get.offAll(() => HomePage(), transition: Transition.leftToRight),
      child: MeshGradient(
        points: c.points,
        options: MeshGradientOptions(blend: 3.5),
        child: Scaffold(
          backgroundColor: c.transparent,
          appBar: appBarBuild(context),
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              leftIcon(),
              carouselLevels(generatedChildren_1, generatedChildren_2,
                  generatedChildren_3),
              rightIcon()
            ],
          ),
          bottomSheet: scoresButton(),
        ),
      ),
    );
  }

  Padding scoresButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: c.mainColor1.withOpacity(0.7),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextButton.icon(
          onPressed: () {
            Get.offAll(() => ScoresPage(), transition: Transition.downToUp);
          },
          style: ButtonStyle(
            shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            overlayColor: WidgetStatePropertyAll(c.textColor.withOpacity(0.2)),
          ),
          label: Text(
            'Scores',
            style: TextStyle(
              color: c.textColor,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: 'Abel',
            ),
          ),
          iconAlignment: IconAlignment.end,
          icon: Icon(
            CustomIcons.time_fast,
            color: c.textColor,
          ),
        ),
      ),
    );
  }

  ButtonStyle buttonStyle() {
    return ButtonStyle(
      shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          // side: BorderSide(color: c.bgColor1, width: 1.5),
        ),
      ),
      backgroundColor: WidgetStatePropertyAll(c.mainColor1.withOpacity(0.5)),
      overlayColor: WidgetStatePropertyAll(
        c.textColor.withOpacity(0.2),
      ),
    );
  }

  //method for entering levels from 1 to 10 , shouldn't be changed
  void levels_1_10(int index) {
    if (index == 0) {
      //Navigator.of(context).pop();
      Get.offAll(() => Level_1(), transition: Transition.size);
    }
    if (index == 1) {
      if (square.db.levelsUnlock[1]) {
        //Navigator.of(context).pop();
        Get.offAll(() => Level_2(), transition: Transition.size);
      } else {
        showScaffoldMessenger(index);
      }
    }
    if (index == 2) {
      if (square.db.levelsUnlock[2]) {
        //Navigator.of(context).pop();
        Get.offAll(() => Level_3(), transition: Transition.size);
      } else {
        showScaffoldMessenger(index);
      }
    }
    if (index == 3) {
      if (square.db.levelsUnlock[3]) {
        // Navigator.of(context).pop();
        Get.offAll(() => Level_4(), transition: Transition.size);
      } else {
        showScaffoldMessenger(index);
      }
    }
    if (index == 4) {
      if (square.db.levelsUnlock[4]) {
        // Navigator.of(context).pop();
        Get.offAll(() => Level_5(), transition: Transition.size);
      } else {
        showScaffoldMessenger(index);
      }
    }
    if (index == 5) {
      if (square.db.levelsUnlock[5]) {
        // Navigator.of(context).pop();
        Get.offAll(() => Level_6(), transition: Transition.size);
      } else {
        showScaffoldMessenger(index);
      }
    }
    if (index == 6) {
      if (square.db.levelsUnlock[6]) {
        //  Navigator.of(context).pop();
        Get.offAll(() => Level_7(), transition: Transition.size);
      } else {
        showScaffoldMessenger(index);
      }
    }
    if (index == 7) {
      if (square.db.levelsUnlock[7]) {
        //  Navigator.of(context).pop();
        Get.offAll(() => Level_8(), transition: Transition.size);
      } else {
        showScaffoldMessenger(index);
      }
    }
    if (index == 8) {
      if (square.db.levelsUnlock[8]) {
        // Navigator.of(context).pop();
        Get.offAll(() => Level_9(), transition: Transition.size);
      } else {
        showScaffoldMessenger(index);
      }
    }
    if (index == 9) {
      if (square.db.levelsUnlock[9]) {
        // Navigator.of(context).pop();
        Get.offAll(() => Level_10(), transition: Transition.size);
      } else {
        showScaffoldMessenger(index);
      }
    }
  }

  //method for entering levels from 11 to 20 , shouldn't be changed
  void levels_11_20(int index) {
    if (index == 0) {
      if (square.db.levelsUnlock[10]) {
        Get.offAll(() => Level_11(), transition: Transition.size);
      } else {
        showScaffoldMessenger(index + 10);
      }
    }
    if (index == 1) {
      if (square.db.levelsUnlock[11]) {
        Get.offAll(() => Level_12(), transition: Transition.size);
      } else {
        showScaffoldMessenger(index + 10);
      }
    }
    if (index == 2) {
      if (square.db.levelsUnlock[12]) {
        Get.offAll(() => Level_13(), transition: Transition.size);
      } else {
        showScaffoldMessenger(index + 10);
      }
    }
    if (index == 3) {
      if (square.db.levelsUnlock[13]) {
        Get.offAll(() => Level_14(), transition: Transition.size);
      } else {
        showScaffoldMessenger(index + 10);
      }
    }
    if (index == 4) {
      if (square.db.levelsUnlock[14]) {
        Get.offAll(() => Level_15(), transition: Transition.size);
      } else {
        showScaffoldMessenger(index + 10);
      }
    }
    if (index == 5) {
      if (square.db.levelsUnlock[15]) {
        Get.offAll(() => Level_16(), transition: Transition.size);
      } else {
        showScaffoldMessenger(index + 10);
      }
    }
    if (index == 6) {
      if (square.db.levelsUnlock[16]) {
        Get.offAll(() => Level_17(), transition: Transition.size);
      } else {
        showScaffoldMessenger(index + 10);
      }
    }
    if (index == 7) {
      if (square.db.levelsUnlock[17]) {
        Get.offAll(() => Level_18(), transition: Transition.size);
      } else {
        showScaffoldMessenger(index + 10);
      }
    }
    if (index == 8) {
      if (square.db.levelsUnlock[18]) {
        Get.offAll(() => Level_19(), transition: Transition.size);
      } else {
        showScaffoldMessenger(index + 10);
      }
    }
    if (index == 9) {
      if (square.db.levelsUnlock[19]) {
        Get.offAll(() => Level_20(), transition: Transition.size);
      } else {
        showScaffoldMessenger(index + 10);
      }
    }
  }

  //method for entering levels from 21 to 30 , shouldn't be changed
  void levels_21_30(int index) {
    if (index == 0) {
      if (square.db.levelsUnlock[20]) {
        Get.offAll(() => Level_21(), transition: Transition.size);
      } else {
        showScaffoldMessenger(index + 20);
      }
    }
    if (index == 1) {
      if (square.db.levelsUnlock[21]) {
        Get.offAll(() => Level_22(), transition: Transition.size);
      } else {
        showScaffoldMessenger(index + 20);
      }
    }
    if (index == 2) {
      if (square.db.levelsUnlock[22]) {
        Get.offAll(() => Level_23(), transition: Transition.size);
      } else {
        showScaffoldMessenger(index + 20);
      }
    }
    if (index == 3) {
      if (square.db.levelsUnlock[23]) {
        Get.offAll(() => Level_24(), transition: Transition.size);
      } else {
        showScaffoldMessenger(index + 20);
      }
    }
    if (index == 4) {
      if (square.db.levelsUnlock[24]) {
        Get.offAll(() => Level_25(), transition: Transition.size);
      } else {
        showScaffoldMessenger(index + 20);
      }
    }
    if (index == 5) {
      if (square.db.levelsUnlock[25]) {
        Get.offAll(() => Level_26(), transition: Transition.size);
      } else {
        showScaffoldMessenger(index + 20);
      }
    }
    if (index == 6) {
      if (square.db.levelsUnlock[26]) {
        Get.offAll(() => Level_27(), transition: Transition.size);
      } else {
        showScaffoldMessenger(index + 20);
      }
    }
    if (index == 7) {
      if (square.db.levelsUnlock[27]) {
        Get.offAll(() => Level_28(), transition: Transition.size);
      } else {
        showScaffoldMessenger(index + 20);
      }
    }
  }

  /// the [containers n_m] method should be copied with [numbers_n_m] when new set of levels are added and changed accordingly
  /// both methods are part of the ui (prolly there's a better way to do this 💀) and shouldn't be changed.

  //the individual level's container 21_30
  Container containers_21_30(int index) {
    return Container(
        key: Key(levels[index + 20].toString()),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 2.5,
            color: c.textColor,
          ),
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.8,
            colors: [
              c.transparent,
              c.transparent,
            ],
          ),
        ),
        child: numbers_21_30(index));
  }

  //the texts for the levels 21_30 (locked and unlocked)
  FittedBox numbers_21_30(int index) {
    return FittedBox(
      child: square.db.levelsUnlock[index + 20]
          ? Text(
              (index + 21).toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: c.textColor,
                fontFamily: 'Abel',
                fontSize: 20,
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    levels[index + 20].toString(),
                    style: TextStyle(
                      color: c.textColor,
                      fontFamily: 'Abel',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(
                    CustomIcons.lock,
                    color: Colors.white,
                    size: 13,
                  )
                ],
              ),
            ),
    );
  }

  //the individual level's container 11_20
  Container containers_11_20(int index) {
    return Container(
      key: Key(levels[index + 10].toString()),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 3,
          color: c.textColor,
        ),
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 0.8,
          colors: [
            c.transparent,
            c.transparent,
          ],
        ),
      ),
      child: numbers_11_20(index),
    );
  }

  //the texts for the levels 11_20 (locked and unlocked)
  FittedBox numbers_11_20(int index) {
    return FittedBox(
      child: square.db.levelsUnlock[index + 10]
          ? Text(
              (index + 11).toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Abel',
                color: c.textColor,
                fontSize: 20,
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    levels[index + 10].toString(),
                    style: TextStyle(
                      color: c.textColor,
                      fontFamily: 'Abel',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(
                    CustomIcons.lock,
                    color: Colors.white,
                    size: 13,
                  )
                ],
              ),
            ),
    );
  }

  //the individual level's container 1_10
  Container containers_1_10(int index) {
    return Container(
      key: Key(levels[index].toString()),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 1.5,
          color: c.textColor,
        ),
        color: c.transparent,
      ),
      child: numbers_1_10(index),
    );
  }

  //the texts for the levels 1_10 (locked and unlocked)
  FittedBox numbers_1_10(int index) {
    return FittedBox(
      child: square.db.levelsUnlock[index]
          ? Text(
              (index + 1).toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: c.textColor,
                fontFamily: 'Abel',
                fontSize: 20,
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    levels[index].toString(),
                    style: TextStyle(
                      color: c.textColor,
                      fontFamily: 'Abel',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(
                    CustomIcons.lock,
                    color: Colors.white,
                    size: 13,
                  )
                ],
              ),
            ),
    );
  }

  //sliders for levels from 1 - 30 (should be change when add new levels)
  //the main ui in this page ❗
  Widget carouselLevels(List<Widget> generatedChildren_1,
      List<Widget> generatedChildren_2, List<Widget> generatedChildren_3) {
    return Container(
      //levels column width change with different phones/platforms
      width: MediaQuery.of(context).size.width >= 930
          ? MediaQuery.of(context).size.width / 3.5
          : MediaQuery.of(context).size.width >= 600
              ? MediaQuery.of(context).size.width / 2
              : MediaQuery.of(context).size.width / 1.3,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CarouselSlider.builder(
            carouselController: carouselController,
            itemCount: 3,
            itemBuilder: (context, index, realIndex) {
              return GridView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 20, bottom: 30),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                children: index == 0
                    ? generatedChildren_1
                    : index == 1
                        ? generatedChildren_2
                        : generatedChildren_3,
              );
            },
            options: CarouselOptions(
              enableInfiniteScroll: true,
              height: 600,
              initialPage: square.db.levelsUnlock[20]
                  ? 2
                  : square.db.levelsUnlock[10]
                      ? 1
                      : 0,
              viewportFraction: 0.5,
              enlargeFactor: 1,
              enlargeCenterPage: true,
            ),
          ),
        ],
      ),
    );
  }

  //left and right icons ,just ui (don't change) ✔
  GestureDetector leftIcon() {
    return GestureDetector(
      onTap: () {
        carouselController?.previousPage(
            duration: Duration(milliseconds: 300), curve: Curves.linear);
      },
      child: Container(
        padding: const EdgeInsets.only(left: 8),
        child: Icon(
          Icons.arrow_back_ios,
          color: c.textColor,
        ),
      ),
    );
  }

  GestureDetector rightIcon() {
    return GestureDetector(
      onTap: () {
        carouselController?.nextPage(
            duration: Duration(milliseconds: 300), curve: Curves.linear);
      },
      child: Container(
        padding: const EdgeInsets.only(right: 8),
        child: Icon(
          Icons.arrow_forward_ios,
          color: c.textColor,
        ),
      ),
    );
  }

  //appbar ,shouldn't be changed as far as I know 🤷‍♂️
  AppBar appBarBuild(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: c.transparent,
      leading: TextButton(
        onPressed: () {
          ///method to go back to [HomePage]
          Get.offAll(() => HomePage(), transition: Transition.leftToRight);
        },
        style: ButtonStyle(
          overlayColor: WidgetStatePropertyAll(c.textColor.withOpacity(0.2)),
        ),
        child: const Icon(
          CustomIcons.left,
          color: Colors.white,
          size: 25,
        ),
      ),
      actions: [
        CustomPopup(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Number of your Squares ',
                    style: TextStyle(
                      color: c.mainColor1,
                      fontFamily: 'Abel',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    CustomIcons.usd_square,
                    color: c.mainColor1,
                  )
                ],
              ),
              Text(
                'Check the customize page',
                style: TextStyle(
                  color: c.mainColor1,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Abel',
                ),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                color: c.bgSheetColor.withOpacity(0.6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  FittedBox(
                    child: Text(
                      square.db.coins.numeral(digits: 1).toString(),
                      style: TextStyle(
                        fontSize: 20,
                        color: c.textColor,
                        fontFamily: 'Abel',
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    CustomIcons.usd_square,
                    color: c.textColor,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: Container(
          height: 1.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: c.textColor,
          ),
        ),
      ),
      title: FittedBox(
        child: Text(
          'Select A Level',
          style: TextStyle(
            fontFamily: 'Abel',
            color: c.textColor,
            fontSize: 41,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
