import 'package:get/get.dart';

class Target {
  //targets index (can change)
  int index;

  //ensure to save the init index of the target
  int initIndex = 0;

  //ensure to save the second index of the target
  int secondIndex = 0;

  //targets color (can change)
  RxString color = ''.obs;

  //constructor
  Target({
    required this.index,
    required this.color,
  }) {
    initIndex = index;
    secondIndex = index;
  }
}
