import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MainMenuItem extends StatelessWidget {
  //* Used in HomePage
  MainMenuItem({
    super.key,
    required this.onPressed,
    required this.text,
    required this.textColor,
    required this.icon,
    required this.borderColor,
    required this.bgColor,
    this.boxShadow,
  });

  String text;
  Color textColor;
  IconData icon;
  Color borderColor;
  Color bgColor;
  List<BoxShadow>? boxShadow = [];
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          // border: Border.all(width: 3, color: borderColor),
          borderRadius: BorderRadius.circular(12),
          color: bgColor,
          boxShadow: boxShadow,
        ),
        child: TextButton.icon(
          style: ButtonStyle(
            shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            overlayColor: WidgetStatePropertyAll(textColor.withOpacity(0.2)),
          ),
          onPressed: onPressed,
          label: Text(
            text,
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'Abel',
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          icon: Icon(
            icon,
            size: 25,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
