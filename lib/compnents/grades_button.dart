import 'package:Squareo/utils/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GradesButton extends StatelessWidget {
  GradesButton({
    super.key,
    required this.c,
    required this.onPressed,
    required this.text,
    required this.icon,
  });

  final CustomColors c;
  final String text;
  final IconData icon;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(c.mainColor1.withOpacity(1)),
        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        overlayColor: WidgetStatePropertyAll(c.textColor.withOpacity(0.2)),
      ),
      label: Text(
        text,
        style: TextStyle(
          color: c.textColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: 'Abel',
        ),
      ),
      icon: Icon(
        icon,
        color: c.textColor,
        size: 20,
      ),
    );
  }
}
