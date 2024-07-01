import 'package:flutter/material.dart';
import 'package:Squareo/utils/colors.dart';

// ignore: must_be_immutable
class ScaffoldBottom extends StatelessWidget {
  //* not the actual scaffold bottom sheet , it's the ui to access it through [cube.shoshowScafflodSheet]
  ScaffoldBottom({
    super.key,
    required this.c,
    required this.showScafflodSheet,
    required this.unlockFlag,
  });

  final CustomColors c;
  final bool unlockFlag;
  VoidCallback showScafflodSheet;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: unlockFlag ? showScafflodSheet : () {},
      child: Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height / 16,
        decoration: BoxDecoration(
          color: c.bgSheetColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              width: unlockFlag ? 350 : 200,
              height: MediaQuery.of(context).size.height / 400,
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: unlockFlag ? c.textColor : Colors.grey.shade500,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
