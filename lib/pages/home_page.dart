import 'package:Squareo/compnents/custom_icons.dart';
import 'package:Squareo/compnents/custom_radio_drawer.dart';
import 'package:Squareo/utils/square.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:contactus/contactus.dart';
import 'package:Squareo/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Squareo/compnents/main_menu_item.dart';
import 'package:Squareo/utils/colors.dart';
import 'package:Squareo/pages/about_page.dart';
import 'package:Squareo/pages/levels_page.dart';
import 'package:simple_animations/animation_builder/mirror_animation_builder.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //colors
  CustomColors c = CustomColors();

  Square square = Square();

  late int _selectedTheme;

  @override
  void initState() {
    square.hiveDataCheck();

    // square.db.createInitialDataList();
    // square.db.createInitialDataBorderOpacity();
    // square.db.createInitialDataBorderRadius();
    // square.db.createInitialDataBought();
    // square.db.createInitialDataCoins();
    // square.db.createInitialDataIcon();
    // square.db.createInitialDataInner();
    // square.db.createInitialDataScores();
    // square.db.createInitialDataTheme();
    // square.db.updateDataBase();
    // square.db.levelsUnlock[10] = true;

    _selectedTheme = square.db.themeSwitch;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MeshGradient(
      points: c.points,
      options: MeshGradientOptions(blend: 3.5),
      child: Scaffold(
        backgroundColor: c.transparent,
        appBar: appBarBuild(context),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              squareoCard(context),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  homeCard(context),
                  settingsCard(),
                  howToPlayCard(),
                ],
              ),
            ],
          ),
        ),
        bottomSheet: footCard(),
        drawer: mainDrawer(context),
      ),
    );
  }

  //open drawer for now (only for themes)
  SafeArea mainDrawer(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: c.bgSheetColor,
        width: MediaQuery.of(context).size.width / 2,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Mode',
                style: TextStyle(
                  fontSize: 20,
                  color: c.textColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Abel',
                ),
              ),
              lineThrow(context, 'Mode'.length.toDouble() * 12),
              SizedBox(height: 10),
              CustomRadioDrawer(
                selectedValue: _selectedTheme,
                icon: CustomIcons.brightness,
                text: "Light",
                value: 0,
                onChanged: (value) {
                  setState(() {
                    _selectedTheme = 0;
                    square.db.themeSwitch = 0;
                    square.db.updateDataBase();
                    c.colorSwitch();
                    Navigator.pop(context);
                  });
                },
              ),
              SizedBox(height: 20),
              CustomRadioDrawer(
                selectedValue: _selectedTheme,
                icon: CustomIcons.moon_stars,
                text: "Dark",
                value: 1,
                onChanged: (value) {
                  setState(() {
                    _selectedTheme = 1;
                    square.db.themeSwitch = 1;
                    square.db.updateDataBase();
                    c.colorSwitch();
                    Navigator.pop(context);
                  });
                },
              ),
              SizedBox(height: 20),
              Text(
                'Levels Background',
                style: TextStyle(
                  fontSize: 20,
                  color: c.textColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Abel',
                ),
              ),
              lineThrow(context, 'Levels Background'.length.toDouble() * 9),
              SizedBox(height: 20),
              AnimatedToggleSwitch.dual(
                current: square.db.levelsBg,
                onChanged: (i) {
                  setState(() {
                    square.db.levelsBg = i;
                    square.db.updateDataBase();
                  });
                },
                style: ToggleStyle(
                  backgroundColor: c.mainColor1.withOpacity(0.6),
                  indicatorColor: c.bgSheetColor,
                  borderColor: c.transparent,
                ),
                iconBuilder: (value) => value == 0
                    ? Icon(
                        CustomIcons.brightness,
                        color: c.textColor,
                      )
                    : Icon(
                        CustomIcons.moon_stars,
                        color: c.textColor,
                      ),
                textBuilder: (value) => value == 0
                    ? Text(
                        'Light',
                        style: TextStyle(
                          color: c.textColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Abel',
                        ),
                      )
                    : Text(
                        'Dark',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: c.textColor,
                          fontFamily: 'Abel',
                        ),
                      ),
                first: 0,
                second: 1,
              ),
              SizedBox(height: 20),
              Text(
                'Contact Me',
                style: TextStyle(
                  fontSize: 20,
                  color: c.textColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Abel',
                ),
              ),
              lineThrow(context, 'Contact Me'.length.toDouble() * 10),
              SizedBox(height: 20),
              IconButton(
                color: Colors.red,
                style: ButtonStyle(
                  overlayColor:
                      WidgetStatePropertyAll(c.textColor.withOpacity(0.2)),
                  backgroundColor: WidgetStatePropertyAll(
                    c.mainColor1.withOpacity(0.6),
                  ),
                ),
                onPressed: showConatctDialog,
                icon: Icon(
                  Icons.person,
                  color: c.textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //simple line serves as a divider
  Container lineThrow(BuildContext context, double width) {
    return Container(
      width: width, //!
      height: 0.3,
      decoration: BoxDecoration(
        color: c.textColor,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  //appbar just ui
  AppBar appBarBuild(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: c.transparent,

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
      title: Text(
        'Main Menu',
        style: TextStyle(
          fontSize: 41,
          color: c.textColor,
          fontWeight: FontWeight.bold,
          fontFamily: 'Abel',
        ),
      ),
      //opens drawer
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: Icon(
              CustomIcons.bars_sort,
              color: c.textColor,
              size: 25,
            ),
            style: ButtonStyle(
                overlayColor:
                    WidgetStatePropertyAll(c.textColor.withOpacity(0.2))),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
    );
  }

  //method to show Contact Me dialog
  void showConatctDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: c.mainColor1.withOpacity(1),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ContactUs(
                logo: const AssetImage('assets/images/pfp12313.PNG'),
                email: 'yahya.amarneh73@gmail.com',
                companyName: 'Yahya',
                phoneNumber: '+962797863063',
                dividerThickness: 2,
                githubUserName: 'YahyaAmarneh', //'YahyaAmarneh',
                linkedinURL:
                    'https://www.linkedin.com/in/yahya-amarneh-315528229/', //'https://www.linkedin.com/in/yahya-amarneh-315528229/'
                tagLine: 'Software Engineer',
                twitterHandle: null, //AHHHHHHHHHHH29
                textColor: c.mainColor1,
                cardColor: c.textColor,
                companyColor: c.textColor,
                taglineColor: c.textColor,
                dividerColor: c.textColor,
              ),
            ),
          ],
        );
      },
    );
  }

  //scaffold footer to 👉 ui to contact me dialog 👆
  Padding footCard() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomPopup(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Yahya Amarneh , a Sofware Engineer',
                  style: TextStyle(
                    color: c.mainColor1,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Abel',
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: c.mainColor1,
                      borderRadius: BorderRadius.circular(12)),
                  child: TextButton(
                    onPressed: showConatctDialog,
                    child: Text(
                      'Contact Me',
                      style: TextStyle(
                        color: c.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Abel',
                      ),
                    ),
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      overlayColor:
                          WidgetStatePropertyAll(c.textColor.withOpacity(0.2)),
                    ),
                  ),
                ),
              ],
            ),
            contentDecoration: BoxDecoration(
              border: Border.all(
                width: 3,
                color: c.textColor,
              ),
              color: c.textColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                  text: "made by : ",
                  style: TextStyle(
                    color: c.textColor,
                    fontSize: 16,
                    fontFamily: 'Abel',
                  ),
                  children: [
                    TextSpan(
                      text: "Yahya",
                      style: TextStyle(
                        color: c.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Abel',
                      ),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  ///Button for [customizingPage], just ui
  MainMenuItem settingsCard() {
    return MainMenuItem(
      onPressed: () {
        Get.offAll(() => SettingsPage(), transition: Transition.rightToLeft);
      },
      text: "Customize",
      bgColor: c.mainColor1.withOpacity(0.6),
      borderColor: c.textColor,
      textColor: c.textColor,
      icon: CustomIcons.square_dashed__1_,
    );
  }

  ///Button for [howToPlayPage], just ui
  MainMenuItem howToPlayCard() {
    return MainMenuItem(
      onPressed: () {
        Get.offAll(() => AboutPage(), transition: Transition.rightToLeft);
      },
      text: "How To Play",
      bgColor: c.mainColor1.withOpacity(0.6),
      borderColor: c.textColor,
      textColor: c.textColor,
      icon: CustomIcons.rules_alt,
    );
  }

  ///Button for [levelsPage], just ui
  MainMenuItem homeCard(BuildContext context) {
    return MainMenuItem(
      onPressed: () {
        Get.offAll(() => LevelsPage(), transition: Transition.rightToLeft);
      },
      text: "Play",
      bgColor: c.textColor,
      borderColor: c.textColor,
      textColor: c.mainColor1,
      icon: CustomIcons.play,
      boxShadow: shadow,
    );
  }

  /// [Squareo] animated card , just ui
  Column squareoCard(BuildContext context) {
    //long press display a ◼ , just ui
    return Column(
      children: [
        CustomPopup(
          backgroundColor: c.textColor,
          arrowColor: c.textColor,
          content: Icon(
            CustomIcons.cube,
            color: c.mainColor1,
          ),
          isLongPress: true,
          child: MirrorAnimationBuilder<double>(
            tween: Tween(begin: -0.03, end: 0.03),
            duration: const Duration(milliseconds: 1000),
            builder: (context, value, _) {
              return Transform.rotate(
                angle: value,
                child: Container(
                  padding: EdgeInsets.all(30),
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: c.textColor.withOpacity(0.5),
                    boxShadow: shadow,
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/icon/squareo_icon.png',
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Text(
          'Squareo',
          style: TextStyle(
            fontSize: 40,
            color: c.textColor,
            fontFamily: 'Queensides',
          ),
        ),
      ],
    );
  }

  //Squareo card and home card shadows
  List<BoxShadow> get shadow {
    return [
      BoxShadow(
        color: c.textColor.withOpacity(0.3),
        offset: const Offset(6, 6),
        blurRadius: 15,
        spreadRadius: 1,
      ),
      BoxShadow(
        color: c.textColor.withOpacity(0.3),
        offset: const Offset(-6, -6),
        blurRadius: 15,
        spreadRadius: 1,
      ),
    ];
  }
}
