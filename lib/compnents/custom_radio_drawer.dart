import 'package:Squareo/utils/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomRadioDrawer extends StatelessWidget {
  CustomRadioDrawer({
    super.key,
    required int this.selectedValue,
    required String this.text,
    required this.value,
    required this.onChanged,
    required this.icon,
  });

  final int selectedValue;
  final String text;
  final int value;
  final IconData icon;
  final void Function(int?)? onChanged;

  CustomColors c = CustomColors();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: c.mainColor1.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
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
          SizedBox(width: 10),
          Icon(
            icon,
            color: c.textColor,
            size: 20,
          ),
          SizedBox(width: 10),
          FittedBox(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 20,
                color: c.textColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'Abel',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
