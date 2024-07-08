import 'package:Squareo/compnents/custom_icons.dart';
import 'package:Squareo/compnents/custom_radio_tile.dart';
import 'package:Squareo/compnents/payment_dialog.dart';
import 'package:Squareo/models/item_shop.dart';
import 'package:Squareo/pages/home_page.dart';
import 'package:Squareo/utils/colors.dart';
import 'package:Squareo/utils/square.dart';
import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:get/get.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:numeral/numeral.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'dart:math';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  //custom colors
  CustomColors c = CustomColors();

  // Create a variable to store the selected value
  int _selectedRadius = 0;

  // Create a variable to store the selected value
  int _selectedOpacity = 0;

  // Create a variable to store the selected value
  int _selectedIcon = 0;

  // Create a variable to store the selected value
  int _selectedTheme = 0;

  //used to calculate the progress of the player in %
  double percenatgeCounter = 0;

  //fixed min width
  double rowWidth = 448;

  //see initState
  late Color previewContainerColor;

  //see initState
  late List randomColors;

  Square square = Square();

  late List<Item> items;

  //payment dialog
  Color bg = const Color(0xFFFFD700);

  @override
  void initState() {
    //checks the data
    square.hiveDataCheck();

    //calculate the player progression
    calculateProgression();

    //main container color
    previewContainerColor = Color(int.parse(c.wrongColor.toString()));

    //random color (the current color used in the first 10 levels)
    randomColors = [
      Color(int.parse(c.amber.toString())),
      Color(int.parse(c.black.toString())),
      Color(int.parse(c.blue.toString())),
      Color(int.parse(c.yellow.toString())),
      Color(int.parse(c.green.toString())),
      Color(int.parse(c.purple.toString())),
      Color(int.parse(c.wrongColor.toString())),
    ];

    items = [
      Item(name: 'square', price: 0, rank: '', color: c.textColor),
      Item(
          name: 'rounded square',
          price: 500,
          rank: 'Uncommon',
          color: c.uncommon),
      Item(name: 'circle', price: 2000, rank: 'Rare', color: c.rare),
      Item(name: 'border', price: 0, rank: '', color: c.textColor),
      Item(name: 'no border', price: 0, rank: '', color: c.textColor),
      Item(name: 'none_icon', price: 0, rank: '', color: c.textColor),
      Item(name: 'favorite', price: 3000, rank: 'Uncommon', color: c.uncommon),
      Item(name: 'eye mask', price: 3500, rank: 'Uncommon', color: c.uncommon),
      Item(name: 'eye mask 2', price: 5000, rank: 'Rare', color: c.rare),
      Item(name: 'spider', price: 4500, rank: 'Uncommon', color: c.uncommon),
      Item(name: 'devil', price: 5000, rank: 'Rare', color: c.rare),
      Item(name: 'saint', price: 5000, rank: 'Rare', color: c.rare),
      Item(name: 'none_shape', price: 0, rank: '', color: c.textColor),
      Item(name: 'android', price: 10000, rank: 'Epic', color: c.epic),
      Item(name: 'heart', price: 4000, rank: 'Uncommon', color: c.uncommon),
      Item(name: 'star', price: 2500, rank: 'Uncommon', color: c.uncommon),
      Item(name: 'diamond', price: 6500, rank: 'Rare', color: c.rare),
      Item(name: 'hockey', price: 12000, rank: 'Epic', color: c.epic),
      Item(name: 'poo', price: 3000, rank: 'Uncommon', color: c.uncommon),
      Item(name: 'carnival', price: 12000, rank: 'Epic', color: c.epic),
      Item(name: 'bat', price: 7000, rank: 'Rare', color: c.rare),
      Item(name: 'face', price: 8000, rank: 'Rare', color: c.rare),
      Item(name: 'alien', price: 13500, rank: 'Epic', color: c.epic),
      Item(name: 'eye', price: 20000, rank: 'Legendary', color: c.legendary),
      Item(name: 'cube', price: 50000, rank: 'Legendary', color: c.legendary),
      Item(name: 'sun', price: 15000, rank: 'Epic', color: c.epic),
      Item(
          name: 'sparkle', price: 25000, rank: 'Legendary', color: c.legendary),
      Item(
          name: 'triangle',
          price: 30000,
          rank: 'Legendary',
          color: c.legendary),
    ];

    //saves the radio buttons state based on the value from the database
    _selectedRadius = square.db.squaresBorderRadius.toInt();

    _selectedIcon = square.db.squaresIcon;

    _selectedTheme = square.db.squaresInnerSquare;

    if (square.db.squaresBorderOpacity == 1) {
      _selectedOpacity = 1;
    } else {
      _selectedOpacity = 0;
    }

    super.initState();
  }

  @override
  void dispose() {
    square.player.dispose();
    super.dispose();
  }

  //see initState
  void calculateProgression() {
    for (int i = 0; i < square.db.levelsUnlock.length; i++) {
      if (square.db.levelsUnlock[i] == true) {
        percenatgeCounter++;
      }
    }

    percenatgeCounter = percenatgeCounter / square.db.levelsUnlock.length;

    percenatgeCounter = percenatgeCounter * 100;
  }

  @override
  Widget build(BuildContext context) {
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
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  customizeText('Squareo Completion'),
                  lineThrow(
                      context, 'Squareo Completion'.length.toDouble() * 10),
                  SizedBox(height: 20),
                  percentIndicator(),
                  SizedBox(height: 20),
                  customizeText('Customize your square'),
                  lineThrow(
                      context, 'Customize your square'.length.toDouble() * 10),
                  SizedBox(height: 20),
                  previewContainer(),
                  SizedBox(height: 20),
                  borderSelectRow(),
                  SizedBox(height: 20),
                  opacitySelectRow(),
                  SizedBox(height: 20),
                  iconSelectRow(),
                  SizedBox(height: 20),
                  innerSelectRow(),
                  SizedBox(height: 20),
                ],
              ),
            ),
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

  //local customizied text
  FittedBox customizeText(String text) {
    return FittedBox(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 22,
          color: c.textColor,
          fontWeight: FontWeight.bold,
          fontFamily: 'Abel',
        ),
      ),
    );
  }

  //forth row (inner shape) (customizition)
  Column innerSelectRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customizeText('Choose the square shape'),
        lineThrow(context, 'Choose the square shape'.length.toDouble() * 10),
        SizedBox(height: 10),
        Container(
          width: rowWidth,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: c.mainColor1.withOpacity(0.6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Wrap(
            spacing: 32,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [
              CustomRadioTile(
                selectedValue: _selectedTheme,
                text: "None",
                value: 0,
                textOrIcon: true,
                onChanged: (value) {
                  setState(() {
                    _selectedTheme = value!;
                    square.db.squaresInnerSquare = 0;
                    square.db.updateDataBase();
                  });
                },
              ),
              CustomRadioTile(
                selectedValue: _selectedTheme,
                text: "Android",
                textOrIcon: true,
                value: 1,
                isBought: square.db.bought.contains('android'),
                onChanged: (value) async {
                  _selectedTheme = await buy(1, _selectedTheme, items[13].price,
                      items[13].name, items[13].rank, items[13].color);
                  square.db.squaresInnerSquare = _selectedTheme;
                  square.db.updateDataBase();
                },
              ),
              CustomRadioTile(
                selectedValue: _selectedTheme,
                text: "Heart",
                textOrIcon: true,
                isBought: square.db.bought.contains('heart'),
                value: 2,
                onChanged: (value) async {
                  _selectedTheme = await buy(2, _selectedTheme, items[14].price,
                      items[14].name, items[14].rank, items[14].color);
                  square.db.squaresInnerSquare = _selectedTheme;
                  square.db.updateDataBase();
                },
              ),
              CustomRadioTile(
                selectedValue: _selectedTheme,
                text: "Star",
                textOrIcon: true,
                isBought: square.db.bought.contains('star'),
                value: 3,
                onChanged: (value) async {
                  _selectedTheme = await buy(3, _selectedTheme, items[15].price,
                      items[15].name, items[15].rank, items[15].color);
                  square.db.squaresInnerSquare = _selectedTheme;
                  square.db.updateDataBase();
                },
              ),
              CustomRadioTile(
                selectedValue: _selectedTheme,
                text: "Diamond",
                textOrIcon: true,
                isBought: square.db.bought.contains('diamond'),
                value: 4,
                onChanged: (value) async {
                  _selectedTheme = await buy(4, _selectedTheme, items[16].price,
                      items[16].name, items[16].rank, items[16].color);
                  square.db.squaresInnerSquare = _selectedTheme;
                  square.db.updateDataBase();
                },
              ),
              CustomRadioTile(
                selectedValue: _selectedTheme,
                text: "Sun",
                textOrIcon: true,
                isBought: square.db.bought.contains('sun'),
                value: 5,
                onChanged: (value) async {
                  _selectedTheme = await buy(5, _selectedTheme, items[25].price,
                      items[25].name, items[25].rank, items[25].color);
                  square.db.squaresInnerSquare = _selectedTheme;
                  square.db.updateDataBase();
                },
              ),
              CustomRadioTile(
                selectedValue: _selectedTheme,
                text: "Sparkle",
                textOrIcon: true,
                isBought: square.db.bought.contains('sparkle'),
                value: 6,
                onChanged: (value) async {
                  _selectedTheme = await buy(6, _selectedTheme, items[26].price,
                      items[26].name, items[26].rank, items[26].color);
                  square.db.squaresInnerSquare = _selectedTheme;
                  square.db.updateDataBase();
                },
              ),
              CustomRadioTile(
                selectedValue: _selectedTheme,
                text: "Triangle",
                textOrIcon: true,
                isBought: square.db.bought.contains('triangle'),
                value: 7,
                onChanged: (value) async {
                  _selectedTheme = await buy(7, _selectedTheme, items[27].price,
                      items[27].name, items[27].rank, items[27].color);
                  square.db.squaresInnerSquare = _selectedTheme;
                  square.db.updateDataBase();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  //third row (icons) (customizition)
  Column iconSelectRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customizeText('Choose the square face'),
        lineThrow(context, 'Choose the square face'.length.toDouble() * 10),
        SizedBox(height: 10),
        Container(
          width: rowWidth,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: c.mainColor1.withOpacity(0.6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Wrap(
            spacing: 25,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [
              CustomRadioTile(
                selectedValue: _selectedIcon,
                text: "None",
                textOrIcon: true,
                squaresIcon: Icons.close,
                value: 0,
                onChanged: (value) {
                  setState(() {
                    _selectedIcon = value!;
                    square.db.squaresIcon = 0;
                    square.db.updateDataBase();
                  });
                },
              ),
              CustomRadioTile(
                selectedValue: _selectedIcon,
                text: "Heart",
                squaresIcon: CustomIcons.speech_bubble,
                textOrIcon: false,
                value: 1,
                isBought: square.db.bought.contains('favorite'),
                onChanged: (value) async {
                  _selectedIcon = await buy(1, _selectedIcon, items[6].price,
                      items[6].name, items[6].rank, items[6].color);
                  square.db.squaresIcon = _selectedIcon;
                  square.db.updateDataBase();
                },
              ),
              CustomRadioTile(
                selectedValue: _selectedIcon,
                textOrIcon: false,
                squaresIcon: CustomIcons.mask,
                text: "Eye mask",
                value: 3,
                size: 30,
                isBought: square.db.bought.contains('eye mask'),
                onChanged: (value) async {
                  _selectedIcon = await buy(3, _selectedIcon, items[7].price,
                      items[7].name, items[7].rank, items[7].color);
                  square.db.squaresIcon = _selectedIcon;
                  square.db.updateDataBase();
                },
              ),
              CustomRadioTile(
                selectedValue: _selectedIcon,
                textOrIcon: false,
                squaresIcon: CustomIcons.eye_mask__2_,
                text: "Eye mask 2",
                value: 2,
                size: 30,
                isBought: square.db.bought.contains('eye mask 2'),
                onChanged: (value) async {
                  _selectedIcon = await buy(2, _selectedIcon, items[8].price,
                      items[8].name, items[8].rank, items[8].color);
                  square.db.squaresIcon = _selectedIcon;
                  square.db.updateDataBase();
                },
              ),
              CustomRadioTile(
                selectedValue: _selectedIcon,
                text: "Spider",
                value: 4,
                squaresIcon: CustomIcons.spider,
                textOrIcon: false,
                isBought: square.db.bought.contains('spider'),
                onChanged: (value) async {
                  _selectedIcon = await buy(4, _selectedIcon, items[9].price,
                      items[9].name, items[9].rank, items[9].color);
                  square.db.squaresIcon = _selectedIcon;
                  square.db.updateDataBase();
                },
              ),
              CustomRadioTile(
                selectedValue: _selectedIcon,
                text: "Devil",
                textOrIcon: false,
                value: 5,
                isBought: square.db.bought.contains('devil'),
                squaresIcon: CustomIcons.spooky,
                onChanged: (value) async {
                  _selectedIcon = await buy(5, _selectedIcon, items[10].price,
                      items[10].name, items[10].rank, items[10].color);
                  square.db.squaresIcon = _selectedIcon;
                  square.db.updateDataBase();
                },
              ),
              CustomRadioTile(
                selectedValue: _selectedIcon,
                text: "Saint",
                squaresIcon: CustomIcons.happy_face,
                textOrIcon: false,
                isBought: square.db.bought.contains('saint'),
                value: 6,
                onChanged: (value) async {
                  _selectedIcon = await buy(6, _selectedIcon, items[11].price,
                      items[11].name, items[11].rank, items[11].color);
                  square.db.squaresIcon = _selectedIcon;
                  square.db.updateDataBase();
                },
              ),
              CustomRadioTile(
                selectedValue: _selectedIcon,
                text: "Hockey Mask",
                squaresIcon: CustomIcons.hockey_mask,
                textOrIcon: false,
                isBought: square.db.bought.contains('hockey'),
                value: 7,
                onChanged: (value) async {
                  _selectedIcon = await buy(7, _selectedIcon, items[17].price,
                      items[17].name, items[17].rank, items[17].color);
                  square.db.squaresIcon = _selectedIcon;
                  square.db.updateDataBase();
                },
              ),
              CustomRadioTile(
                selectedValue: _selectedIcon,
                text: "Poo",
                squaresIcon: CustomIcons.poo,
                textOrIcon: false,
                isBought: square.db.bought.contains('poo'),
                value: 8,
                onChanged: (value) async {
                  _selectedIcon = await buy(8, _selectedIcon, items[18].price,
                      items[18].name, items[18].rank, items[18].color);
                  square.db.squaresIcon = _selectedIcon;
                  square.db.updateDataBase();
                },
              ),
              CustomRadioTile(
                selectedValue: _selectedIcon,
                text: "Carnival Mask",
                squaresIcon: CustomIcons.mask_carnival,
                textOrIcon: false,
                isBought: square.db.bought.contains('carnival'),
                value: 9,
                onChanged: (value) async {
                  _selectedIcon = await buy(9, _selectedIcon, items[19].price,
                      items[19].name, items[19].rank, items[19].color);
                  square.db.squaresIcon = _selectedIcon;
                  square.db.updateDataBase();
                },
              ),
              CustomRadioTile(
                selectedValue: _selectedIcon,
                text: "Bat",
                squaresIcon: CustomIcons.bat,
                textOrIcon: false,
                isBought: square.db.bought.contains('bat'),
                value: 10,
                onChanged: (value) async {
                  _selectedIcon = await buy(10, _selectedIcon, items[20].price,
                      items[20].name, items[20].rank, items[20].color);
                  square.db.squaresIcon = _selectedIcon;
                  square.db.updateDataBase();
                },
              ),
              CustomRadioTile(
                selectedValue: _selectedIcon,
                text: "Iron Mask",
                squaresIcon: CustomIcons.beauty_mask,
                textOrIcon: false,
                isBought: square.db.bought.contains('face'),
                value: 11,
                onChanged: (value) async {
                  _selectedIcon = await buy(11, _selectedIcon, items[21].price,
                      items[21].name, items[21].rank, items[21].color);
                  square.db.squaresIcon = _selectedIcon;
                  square.db.updateDataBase();
                },
              ),
              CustomRadioTile(
                selectedValue: _selectedIcon,
                text: "Alien",
                squaresIcon: CustomIcons.alien,
                textOrIcon: false,
                isBought: square.db.bought.contains('alien'),
                value: 12,
                onChanged: (value) async {
                  _selectedIcon = await buy(12, _selectedIcon, items[22].price,
                      items[22].name, items[22].rank, items[22].color);
                  square.db.squaresIcon = _selectedIcon;
                  square.db.updateDataBase();
                },
              ),
              CustomRadioTile(
                selectedValue: _selectedIcon,
                text: "Eye",
                squaresIcon: CustomIcons.eye,
                textOrIcon: false,
                isBought: square.db.bought.contains('eye'),
                value: 13,
                onChanged: (value) async {
                  _selectedIcon = await buy(13, _selectedIcon, items[23].price,
                      items[23].name, items[23].rank, items[23].color);
                  square.db.squaresIcon = _selectedIcon;
                  square.db.updateDataBase();
                },
              ),
              CustomRadioTile(
                selectedValue: _selectedIcon,
                text: "Cube",
                squaresIcon: CustomIcons.cube,
                textOrIcon: false,
                isBought: square.db.bought.contains('cube'),
                value: 14,
                onChanged: (value) async {
                  _selectedIcon = await buy(14, _selectedIcon, items[24].price,
                      items[24].name, items[24].rank, items[24].color);
                  square.db.squaresIcon = _selectedIcon;
                  square.db.updateDataBase();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  //second row (border opacity) (customizition)
  Column opacitySelectRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customizeText('Choose the square border'),
        lineThrow(context, 'Choose the square border'.length.toDouble() * 10),
        SizedBox(height: 10),
        Container(
          width: rowWidth,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: c.mainColor1.withOpacity(0.6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomRadioTile(
                selectedValue: _selectedOpacity,
                text: "Shadow",
                textOrIcon: true,
                value: 0,
                onChanged: (value) {
                  setState(() {
                    _selectedOpacity = value!;
                    square.db.squaresBorderOpacity = 0.5;
                    square.db.updateDataBase();
                  });
                },
              ),
              CustomRadioTile(
                selectedValue: _selectedOpacity,
                text: "Solid",
                textOrIcon: true,
                value: 1,
                isBought: true,
                onChanged: (value) async {
                  setState(() {
                    _selectedOpacity = value!;
                    square.db.squaresBorderOpacity = 1;
                    square.db.updateDataBase();
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  //first row (border shape) (customizition)
  Column borderSelectRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customizeText('Choose the square border radius'),
        lineThrow(
            context, 'Choose the square border radius'.length.toDouble() * 10),
        SizedBox(height: 10),
        Container(
          width: rowWidth,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: c.mainColor1.withOpacity(0.6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Wrap(
            alignment: WrapAlignment.start,
            children: [
              CustomRadioTile(
                selectedValue: _selectedRadius,
                text: "Sharp",
                textOrIcon: true,
                value: 5,
                onChanged: (value) {
                  setState(() {
                    _selectedRadius = value!;
                    square.db.squaresBorderRadius = 5;
                    square.db.updateDataBase();
                  });
                },
              ),
              CustomRadioTile(
                selectedValue: _selectedRadius,
                text: "Rounded",
                textOrIcon: true,
                isBought: square.db.bought.contains('rounded square'),
                value: 20,
                onChanged: (value) async {
                  _selectedRadius = await buy(
                      20,
                      _selectedRadius,
                      items[1].price,
                      items[1].name,
                      items[1].rank,
                      items[1].color);
                  square.db.squaresBorderRadius = _selectedRadius.toDouble();
                  square.db.updateDataBase();
                },
              ),
              CustomRadioTile(
                selectedValue: _selectedRadius,
                textOrIcon: true,
                text: "Circle",
                value: 60,
                isBought: square.db.bought.contains('circle'),
                onChanged: (value) async {
                  _selectedRadius = await buy(
                      60,
                      _selectedRadius,
                      items[2].price,
                      items[2].name,
                      items[2].rank,
                      items[2].color);
                  square.db.squaresBorderRadius = _selectedRadius.toDouble();
                  square.db.updateDataBase();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  //checks, accepts, rejects,withdraw
  int buy(int value, int selected, int price, String name, String rankText,
      Color rankColor) {
    //checks if the item IS bought , if true then enter
    if (square.db.bought.contains(name)) {
      setState(() {
        selected = value;
      });
    } else {
      //make the transaction (widthraw from the total db.coins) & (add item to bought items list) & (update database)
      showDialog(
        context: context,
        builder: (context) {
          return PaymentDialog(
            c: c,
            name: name,
            price: price,
            rankText: rankText,
            rankColor: rankColor,
            coins: square.db.coins,
            paymentCheck: () =>
                paymentCheck(value, selected, price, name, context),
          );
        },
      );
    }

    return selected;
  }

  //checks if enough coins
  void paymentCheck(int value, int selected, int price, String name,
      BuildContext buildContext) {
    if (price > square.db.coins) {
      return;
    } else {
      setState(() {
        //if item is legendary
        if (name == 'cube' ||
            name == 'eye' ||
            name == 'sparkle' ||
            name == 'triangle') {
          square.playSound('legendary');
        } else {
          square.playSound('buy');
        }
        //withdraw coins
        square.db.coins = square.db.coins - price;
        //add item to list
        square.db.bought.add(name);
        //save value
        selected = value;
      });
      Navigator.of(context).pop();
    }
  }

  //main container for preview
  GestureDetector previewContainer() {
    return GestureDetector(
      onTap: () {
        setState(() {
          //decides a random color for preview
          var rand = Random();
          previewContainerColor =
              randomColors[rand.nextInt(randomColors.length)];
        });
      },
      child: AnimatedContainer(
        width: 70,
        height: 70,
        duration: const Duration(milliseconds: 700),
        decoration: BoxDecoration(
          color:
              previewContainerColor.withOpacity(square.db.squaresBorderOpacity),
          borderRadius: BorderRadius.circular(square.db.squaresBorderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipPath(
            clipper: square.innerDecider(),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 700),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(square.db.squaresBorderRadius),
                color: previewContainerColor,
                gradient: RadialGradient(
                  radius: 2,
                  colors: [
                    previewContainerColor,
                    Colors.white,
                    //0xFF89CFF0 <-baby blue and the normal
                  ],
                ),
              ),
              child: Icon(
                square.iconDecider(),
                color: c.transparent.withOpacity(0.2),
                size: square.db.squaresIcon == 3
                    ? 30
                    : square.db.squaresIcon == 2
                        ? 30
                        : 24,
              ),
            ),
          ),
        ),
      ),
    );
  }

  //circual indicator of the percentage of the levels completed
  Center percentIndicator() {
    return Center(
      child: CircularPercentIndicator(
        radius: 60.0,
        lineWidth: 9,
        percent: percenatgeCounter / 100,
        center: FittedBox(
          child: Text(
            "${percenatgeCounter.toInt().toString()}%",
            style: TextStyle(
              color: c.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 25,
              fontFamily: 'Abel',
            ),
          ),
        ),
        progressColor: c.bgSheetColor,
        backgroundColor: c.textColor.withOpacity(0.7),
        animation: true,
        animationDuration: 1000,
        animateFromLastPercent: true,
        backgroundWidth: 10,
        circularStrokeCap: CircularStrokeCap.round,
      ),
    );
  }

  //appbar
  AppBar appBarBuild(BuildContext context) {
    return AppBar(
      leading: TextButton(
        onPressed: () {
          ///method to go back to [HomePage]
          Get.offAll(() => HomePage(), transition: Transition.leftToRight);
        },
        style: ButtonStyle(
          overlayColor: WidgetStatePropertyAll(c.textColor.withOpacity(0.2)),
        ),
        child: Icon(
          CustomIcons.left,
          color: c.textColor,
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
                      square.db.coins.numeral().toString(),
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
        'Customize',
        style: TextStyle(
          color: c.textColor,
          fontFamily: 'Abel',
          fontSize: 41,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
