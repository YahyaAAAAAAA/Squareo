import 'package:Squareo/compnents/custom_icons.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:Squareo/utils/colors.dart';
import 'package:Squareo/utils/square.dart';
import 'package:Squareo/pages/home_page.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  //colors
  CustomColors c = CustomColors();

  //square util instance
  Square square = Square();

  //main list
  List<Widget>? list;

  @override
  void initState() {
    super.initState();

    //main list to display tutorial cards (editable)
    list = [
      Center(
        child: Text(
          "Welcome to Squareo",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 55,
            fontFamily: 'Abel',
            color: c.mainColor1,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "This grid of squares",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Abel',
              color: c.mainColor1,
              fontWeight: FontWeight.bold,
            ),
          ),
          Image.asset(
            'assets/images/move1.PNG',
            height: 200,
            width: 200,
          ),
        ],
      ),
      FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Colored squares move",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Abel',
                color: c.mainColor1,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image.asset(
              'assets/images/move1.PNG',
              height: 200,
              width: 200,
            ),
            Icon(
              CustomIcons.down,
              color: c.mainColor1,
              size: 30,
            ),
            Image.asset(
              'assets/images/move2.PNG',
              height: 200,
              width: 200,
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: Text(
                    "You Should Know",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Abel',
                      color: c.mainColor1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              color: c.mainColor1,
              thickness: 1.5,
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  CustomIcons.lock,
                  color: Colors.red.shade700,
                  size: 25,
                ),
                const SizedBox(width: 5),
                Icon(
                  CustomIcons.right,
                  color: c.mainColor1,
                  size: 20,
                ),
                const SizedBox(width: 5),
                Icon(
                  CustomIcons.unlock,
                  color: Colors.green.shade300,
                  size: 25,
                ),
                const SizedBox(width: 5),
                FittedBox(
                  child: Text(
                    "Your turn",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Abel',
                      color: c.mainColor1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    CustomIcons.palette,
                    color: Colors.red.shade700,
                    size: 30,
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    CustomIcons.right,
                    color: c.mainColor1,
                    size: 20,
                  ),
                  const SizedBox(width: 5),
                  FittedBox(
                    child: Text(
                      "Squares won't change color",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Abel',
                        color: c.mainColor1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    CustomIcons.palette,
                    color: Colors.green.shade300,
                    size: 30,
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    CustomIcons.right,
                    color: c.mainColor1,
                    size: 20,
                  ),
                  const SizedBox(width: 5),
                  FittedBox(
                    child: Text(
                      "Squares will change color",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Abel',
                        color: c.mainColor1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    CustomIcons.circle_1,
                    color: Colors.black,
                    size: 27,
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    CustomIcons.right,
                    color: c.mainColor1,
                    size: 20,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "Put squares to thier \"1\" position",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Abel',
                      color: c.mainColor1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    CustomIcons.circle_2,
                    color: Colors.black,
                    size: 27,
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    CustomIcons.right,
                    color: c.mainColor1,
                    size: 20,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "Put squares to thier \"2\" position",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Abel',
                      color: c.mainColor1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: Text(
                    "...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Abel',
                      color: c.mainColor1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Enjoy",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 45,
              fontFamily: 'Abel',
              color: c.mainColor1,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: c.mainColor1,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextButton(
              onPressed: () {
                Get.offAll(() => HomePage(),
                    transition: Transition.leftToRight);
              },
              child: Icon(
                CustomIcons.house_blank,
                color: c.textColor,
                size: 25,
              ),
              style: ButtonStyle(
                shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                overlayColor: WidgetStatePropertyAll(
                  c.textColor.withOpacity(0.2),
                ),
              ),
            ),
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) =>
          Get.offAll(() => HomePage(), transition: Transition.leftToRight),
      child: MeshGradient(
        points: c.points,
        options: MeshGradientOptions(blend: 3.5),
        child: Scaffold(
          backgroundColor: c.transparent,
          appBar: appBarBuild(context),
          body: cardSwiper(context),
        ),
      ),
    );
  }

  //swiper widget , just ui (don't change) , change the list in initState
  Swiper cardSwiper(BuildContext context) {
    return Swiper(
      containerHeight: MediaQuery.of(context).size.height / 4,
      containerWidth: MediaQuery.of(context).size.width / 2,
      itemHeight: MediaQuery.of(context).size.height / 2,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: c.textColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: list![index],
        );
      },
      itemCount: list!.length,
      itemWidth: 300.0,
      layout: SwiperLayout.STACK,
      indicatorLayout: PageIndicatorLayout.COLOR,
      autoplay: false,
      pagination: SwiperPagination(
        builder: DotSwiperPaginationBuilder(
          color: c.textColor,
          activeColor: c.bgSheetColor,
          size: 10,
          activeSize: 15,
        ),
        margin: const EdgeInsets.all(50),
      ),
      loop: false,
      control: SwiperControl(color: c.textColor, disableColor: c.transparent),
    );
  }

  //appbar , just ui
  AppBar appBarBuild(BuildContext context) {
    return AppBar(
      leading: TextButton(
        onPressed: () {
          ///method to go back to [HomePage]
          Get.offAll(() => HomePage(), transition: Transition.leftToRight);
        },
        style: ButtonStyle(
          overlayColor: WidgetStatePropertyAll(c.textColor.withOpacity(0.2)),
        ),
        child: const Icon(
          CustomIcons.left,
          color: Colors.white,
          size: 25,
        ),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: c.transparent,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: Container(
          height: 1.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: c.textColor,
          ),
        ),
      ),
      title: Text(
        'What is Squareo ?',
        style: TextStyle(
          color: c.textColor,
          fontFamily: 'Abel',
          fontSize: 41,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
