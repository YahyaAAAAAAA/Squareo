import 'package:Squareo/compnents/custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:Squareo/utils/colors.dart';
import 'package:flutter_popup/flutter_popup.dart';

class AppBarBottom extends StatelessWidget {
  //* used for lock,unlock icon -> indicating the user can or cannot start dragging the squares .
  const AppBarBottom({
    super.key,
    required this.unlockFlag,
    required this.textColor,
    required this.lockColor,
    required this.unlockColor,
    this.canChange = false,
    this.position = CustomIcons.circle_1,
  });

  final bool unlockFlag;
  final bool canChange;
  final IconData position;
  final Color textColor;
  final Color lockColor;
  final Color unlockColor;

  @override
  Widget build(BuildContext context) {
    CustomColors c = CustomColors();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomPopup(
          content: Text(
            canChange
                ? 'Squares will change color'
                : "Squares won't change color",
            style: TextStyle(
              color: c.mainColor1,
              fontFamily: 'Abel',
              fontWeight: FontWeight.bold,
            ),
          ),
          child: Container(
            width: 45,
            height: 45,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 3, color: c.textColor),
              color: c.textColor.withOpacity(0.5),
            ),
            child: Icon(
              CustomIcons.palette,
              color: canChange ? Colors.green.shade700 : Colors.red.shade700,
              size: 27,
            ),
          ),
        ),
        SizedBox(width: 5),
        CustomPopup(
          content: Text(
            unlockFlag ? 'Your turn' : "Not your turn",
            style: TextStyle(
              color: c.mainColor1,
              fontFamily: 'Abel',
              fontWeight: FontWeight.bold,
            ),
          ),
          child: Container(
            width: 45,
            height: 45,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 3, color: c.textColor),
              color: c.textColor.withOpacity(0.5),
            ),
            child: Icon(
              unlockFlag ? CustomIcons.unlock : CustomIcons.lock,
              color: unlockFlag ? Colors.green.shade700 : Colors.red.shade700,
              size: 27,
            ),
          ),
        ),
        SizedBox(width: 5),
        CustomPopup(
          content: Text(
            'Put colored squares to thier position to the shown number',
            style: TextStyle(
              color: c.mainColor1,
              fontFamily: 'Abel',
              fontWeight: FontWeight.bold,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(4),
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 3, color: c.textColor),
              color: c.textColor.withOpacity(0.5),
            ),
            child: Icon(
              position,
              color: Colors.black,
              size: 27,
            ),
          ),
        ),
      ],
    );
  }
}
