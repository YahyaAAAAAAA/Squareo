import 'package:Squareo/compnents/custom_icons.dart';
import 'package:Squareo/utils/square.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reorderable_grid_view/entities/order_update_entity.dart';
import 'package:flutter_reorderable_grid_view/widgets/reorderable_builder.dart';
import 'package:Squareo/compnents/app_bar_bottom.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

// ignore: must_be_immutable
class MainGrid extends StatelessWidget {
  //* The actual grid ui, no logic here -> better keep it as is
  MainGrid({
    super.key,
    required this.unlockFlag,
    required this.textColor,
    required ScrollController scrollController,
    required this.activeDrag,
    required this.containerShadow,
    required GlobalKey<State<StatefulWidget>> gridViewKey,
    required this.columnSize,
    required this.generatedChildren,
    required this.onReorderList,
    required this.lockColor,
    required this.unlockColor,
    required this.height,
    required this.padding,
    required this.borderRadius,
    this.canChange = false,
    this.position = CustomIcons.circle_1,
  })  : _scrollController = scrollController,
        _gridViewKey = gridViewKey;

  final bool unlockFlag;
  final Color textColor;
  final ScrollController _scrollController;
  final bool activeDrag;
  final List<BoxShadow> containerShadow;
  final GlobalKey<State<StatefulWidget>> _gridViewKey;
  final int columnSize;
  final generatedChildren;
  final void Function(List<OrderUpdateEntity>)? onReorderList;
  final Color lockColor;
  final Color unlockColor;
  final double height;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  bool canChange = false;
  final IconData position;
  Square square = Square();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        AppBarBottom(
          lockColor: lockColor,
          unlockColor: unlockColor,
          unlockFlag: unlockFlag,
          textColor: textColor,
          canChange: canChange,
          position: position,
        ),
        Container(
          //if platform is web
          width: kIsWeb
              ? 360
              //if platform is android or ios
              : Platform.isAndroid || Platform.isIOS
                  ? 480
                  //if platform is windows or mac
                  : 390,
          height: MediaQuery.of(context).size.height / 2,
          padding: padding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: ReorderableBuilder(
                  scrollController: _scrollController,
                  enableDraggable: activeDrag,
                  enableLongPress: false,
                  //! might have to change it (not my fault) it's the package
                  //initDelay: Duration(milliseconds: 270),
                  dragChildBoxDecoration: BoxDecoration(
                    boxShadow: containerShadow,
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  onReorder: onReorderList,
                  onDragStarted: () {
                    square.playSound("drag");
                  },
                  builder: (children) {
                    return GridView.builder(
                      shrinkWrap: true,
                      key: _gridViewKey,
                      controller: _scrollController,
                      itemCount: children.length,
                      itemBuilder: (context, index) {
                        return children[index];
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columnSize,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      ),
                    );
                  },
                  children: generatedChildren,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
