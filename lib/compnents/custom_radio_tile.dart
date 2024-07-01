import 'package:Squareo/compnents/custom_icons.dart';
import 'package:Squareo/utils/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomRadioTile extends StatelessWidget {
  CustomRadioTile({
    super.key,
    required int this.selectedValue,
    required String this.text,
    required this.value,
    required this.onChanged,
    required this.textOrIcon,
    this.isBought,
    this.squaresIcon,
    this.size = 24,
  });

  final int selectedValue;
  final String text;
  final int value;
  double size = 24;
  final void Function(int?)? onChanged;
  final bool textOrIcon;

  bool? isBought = false;
  IconData? squaresIcon = null;
  CustomColors c = CustomColors();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio(
          visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity),
          value: value,
          groupValue: selectedValue,
          onChanged: onChanged,
          activeColor: c.textColor,
          overlayColor: WidgetStatePropertyAll(c.textColor.withOpacity(0.5)),
          fillColor: WidgetStatePropertyAll(c.textColor),
        ),
        textOrIcon
            ? FittedBox(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 20,
                    color: c.textColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Abel',
                  ),
                ),
              )
            : Icon(
                squaresIcon,
                color: c.textColor,
                size: size,
              ),
        SizedBox(width: 5),
        Icon(
          isBought == false ? CustomIcons.lock : null,
          size: 13,
          color: c.textColor,
          weight: 10,
        )
      ],
    );
  }
}
