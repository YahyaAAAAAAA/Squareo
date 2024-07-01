import 'package:Squareo/compnents/custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:Squareo/utils/colors.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:numeral/numeral.dart';

// ignore: must_be_immutable
class AppBarBuild extends StatelessWidget implements PreferredSizeWidget {
  //* the app bar used for -> title for each level , go back to menu
  AppBarBuild({
    super.key,
    required this.textColor,
    required this.title,
    required this.appBarBackToMenu,
    required this.unlockFlag,
    required this.coins,
  });

  final Color textColor;
  final String title;
  final bool unlockFlag;
  final int coins;
  VoidCallback appBarBackToMenu;

  @override
  Widget build(BuildContext context) {
    CustomColors c = CustomColors();

    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: AnimatedContainer(
          height: 1.0,
          duration: Duration(milliseconds: 300),
          width: unlockFlag
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.width / 1.2,
          decoration: BoxDecoration(
            color: c.textColor,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Abel',
          color: textColor,
          fontSize: 41,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(
              color: c.bgSheetColor.withOpacity(0.6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: CustomPopup(
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
              child: Row(
                children: [
                  FittedBox(
                    child: Text(
                      coins.numeral(digits: 1).toString(),
                      style: TextStyle(
                        fontSize: 25,
                        color: c.textColor,
                        fontFamily: 'Abel',
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    CustomIcons.usd_square,
                    color: c.textColor,
                    size: 25,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
      leading: Visibility(
        visible: unlockFlag ? true : false,
        maintainAnimation: true,
        maintainState: true,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          curve: Curves.bounceInOut,
          opacity: unlockFlag ? 1 : 0,
          child: TextButton(
            onPressed: appBarBackToMenu,
            child: Icon(
              CustomIcons.left,
              color: textColor,
            ),
            style: ButtonStyle(
              overlayColor:
                  WidgetStatePropertyAll(c.textColor.withOpacity(0.2)),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}
