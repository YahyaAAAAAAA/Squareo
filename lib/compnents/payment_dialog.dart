import 'package:Squareo/compnents/custom_icons.dart';
import 'package:Squareo/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:numeral/numeral.dart';

// ignore: must_be_immutable
class PaymentDialog extends StatelessWidget {
  PaymentDialog({
    super.key,
    required this.c,
    required this.price,
    required this.name,
    required this.paymentCheck,
    required this.rankText,
    required this.rankColor,
    required this.coins,
  });

  final CustomColors c;
  final int price;
  final String name;
  final String rankText;
  final Color rankColor;
  final int coins;
  VoidCallback paymentCheck;

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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: c.transparent,
      content: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: c.bgSheetColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  //add beuatiful
                  price.beautiful.toString(),
                  style: TextStyle(
                    color: c.textColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Abel',
                  ),
                ),
                SizedBox(width: 10),
                Icon(
                  CustomIcons.usd_square,
                  color: c.textColor,
                )
              ],
            ),
            lineThrow(context, price.toString().length * 40),
            SizedBox(height: 5),
            FittedBox(
              child: Text(
                rankText,
                style: TextStyle(
                  fontFamily: 'Abel',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: rankColor,
                ),
              ),
            ),
            SizedBox(height: 10),
            FittedBox(
              child: RichText(
                text: TextSpan(
                  text: (price <= coins)
                      ? 'Are you sure you want to buy '
                      : 'Not enough squares , you need ',
                  children: [
                    TextSpan(
                        text: (price <= coins)
                            ? name[0].toUpperCase() + name.substring(1)
                            : " ${(price - coins).beautiful} Squares",
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontFamily: 'Abel',
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ))
                  ],
                  style: TextStyle(
                    color: c.textColor,
                    fontFamily: 'Abel',
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: (price <= coins)
                  ? MainAxisAlignment.spaceEvenly
                  : MainAxisAlignment.center,
              children: [
                (price <= coins)
                    ? IconButton(
                        onPressed: paymentCheck,
                        tooltip: 'Confirm ?',
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(c.mainColor1),
                          overlayColor: WidgetStatePropertyAll(
                            c.textColor.withOpacity(0.2),
                          ),
                        ),
                        icon: Icon(
                          Icons.check,
                          color: c.textColor,
                        ),
                      )
                    : SizedBox(),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(c.mainColor1),
                    overlayColor:
                        WidgetStatePropertyAll(c.textColor.withOpacity(0.2)),
                  ),
                  tooltip: 'Cancel ?',
                  icon: Icon(
                    Icons.clear,
                    color: c.textColor,
                    size: 25,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
