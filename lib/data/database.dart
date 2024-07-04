import 'package:hive_flutter/hive_flutter.dart';

class Database {
  final _myBox = Hive.box('myBox');

  //main list of levels
  List levelsUnlock = [
    true, // 1
    false, // 2
    false, // 3
    false, // 4
    false, // 5
    false, //6
    false, //7
    false, // 8
    false, // 9
    false, // 10
    false, // 11
    false, // 12
    false, // 13
    false, // 14
    false, // 15
    false, // 16
    false, // 17
    false, // 18
    false, // 19
    false, // 20
    false, // 21
    false, // 22
    false, // 23
    false, // 24
    false, // 25
    false, // 26
    false, // 27
    false, // 28
    false, // 29
    false //30
  ];

  //determain the grid's indiviual squares border radius
  double squaresBorderRadius = 5;

  //determain the grid's indiviual squares border opacity
  double squaresBorderOpacity = 0.5;

  //determain the grid's indiviual squares icon
  int squaresIcon = 0;

  //determain the grid's indiviual squares inner shape
  int squaresInnerSquare = 0;

  int themeSwitch = 0;

  //coins (Squares) the game currency
  int coins = 0;

  //bought items
  List<String> bought = [];

  List scores = [
    [0, 0, '', 0],
    [0, 0, '', 0],
    [0, 0, '', 0],
    [0, 0, '', 0],
    [0, 0, '', 0],
    [0, 0, '', 0],
    [0, 0, '', 0],
    [0, 0, '', 0],
    [0, 0, '', 0],
    [0, 0, '', 0],
    [0, 0, '', 0],
    [0, 0, '', 0],
    [0, 0, '', 0],
    [0, 0, '', 0],
    [0, 0, '', 0],
    [0, 0, '', 0],
    [0, 0, '', 0],
    [0, 0, '', 0],
    [0, 0, '', 0],
    [0, 0, '', 0],
    [0, 0, '', 0],
    [0, 0, '', 0],
    [0, 0, '', 0],
    [0, 0, '', 0],
    [0, 0, '', 0],
    [0, 0, '', 0],
    [0, 0, '', 0],
    [0, 0, '', 0],
    [0, 0, '', 0],
    [0, 0, '', 0],
  ];

  int levelsBg = 0;

  void createInitialDataList() {
    levelsUnlock = [
      true, // 1
      false, // 2
      false, // 3
      false, // 4
      false, // 5
      false, //6
      false, //7
      false, // 8
      false, // 9
      false, // 10
      false, // 11
      false, // 12
      false, // 13
      false, // 14
      false, // 15
      false, // 16
      false, // 17
      false, // 18
      false, // 19
      false, // 20
      false, // 21
      false, // 22
      false, // 23
      false, // 24
      false, // 25
      false, // 26
      false, // 27
      false, // 28
      false, // 29
      false //30
    ];
  }

  void createInitialDataBorderRadius() {
    squaresBorderRadius = 5;
  }

  void createInitialDataBorderOpacity() {
    squaresBorderOpacity = 0.5;
  }

  void createInitialDataIcon() {
    squaresIcon = 0;
  }

  void createInitialDataInner() {
    squaresInnerSquare = 0;
  }

  void createInitialDataScores() {
    scores = [
      [0, 0, '', 0],
      [0, 0, '', 0],
      [0, 0, '', 0],
      [0, 0, '', 0],
      [0, 0, '', 0],
      [0, 0, '', 0],
      [0, 0, '', 0],
      [0, 0, '', 0],
      [0, 0, '', 0],
      [0, 0, '', 0],
      [0, 0, '', 0],
      [0, 0, '', 0],
      [0, 0, '', 0],
      [0, 0, '', 0],
      [0, 0, '', 0],
      [0, 0, '', 0],
      [0, 0, '', 0],
      [0, 0, '', 0],
      [0, 0, '', 0],
      [0, 0, '', 0],
      [0, 0, '', 0],
      [0, 0, '', 0],
      [0, 0, '', 0],
      [0, 0, '', 0],
      [0, 0, '', 0],
      [0, 0, '', 0],
      [0, 0, '', 0],
      [0, 0, '', 0],
      [0, 0, '', 0],
      [0, 0, '', 0],
    ];
  }

  void createInitialDataCoins() {
    coins = 0;
  }

  void createInitialDataBought() {
    bought = [];
  }

  void createInitialDataTheme() {
    themeSwitch = 0;
  }

  void createInitialDataLevelBg() {
    levelsBg = 0;
  }

  //load the data from the database
  void loadDataList() {
    levelsUnlock = _myBox.get("LIST");
  }

  //load the data from the database
  void loadDataBorderRadius() {
    squaresBorderRadius = _myBox.get("RADIUS");
  }

  //load the data from the database
  void loadDataBorderOpacity() {
    squaresBorderOpacity = _myBox.get("OPA");
  }

  //load the data from the database
  void loadDataIcon() {
    squaresIcon = _myBox.get("ICON");
  }

  //load the data from the database
  void loadDataInner() {
    squaresInnerSquare = _myBox.get("INNER");
  }

  //load the data from the database
  void loadDataScores() {
    scores = _myBox.get("SCORES");
  }

  //load the data from the database
  void loadDataCoins() {
    coins = _myBox.get("COINS");
  }

  //load the data from the database
  void loadDataBought() {
    bought = _myBox.get("BUY");
  }

  void loadDataTheme() {
    themeSwitch = _myBox.get("THEME");
  }

  void loadDataLevelsBg() {
    levelsBg = _myBox.get("BG");
  }

  //update the database
  void updateDataBase() {
    _myBox.put("LIST", levelsUnlock);
    _myBox.put("RADIUS", squaresBorderRadius);
    _myBox.put("OPA", squaresBorderOpacity);
    _myBox.put("ICON", squaresIcon);
    _myBox.put("INNER", squaresInnerSquare);
    _myBox.put("SCORES", scores);
    _myBox.put("COINS", coins);
    _myBox.put("BUY", bought);
    _myBox.put("THEME", themeSwitch);
    _myBox.put("BG", levelsBg);
  }
}
