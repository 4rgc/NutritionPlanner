import 'package:eventhandler/eventhandler.dart';
import 'package:flutter/material.dart';
import 'package:fluttertestproj/mealScreen.dart';

import 'food.dart';

class OverlayCloseEvent extends EventBase {}

class FoodOverlay {
  FoodOverlay();

  final _widgets = List<Widget>();

  List<Widget> toWidgetList() {
    return List<Widget>.from(_widgets);
  }

  void addOverlay(BuildContext context, Food food) {
    _widgets.add(buildOpaqueBackgroundContainer());
    _widgets.add(buildFoodContainer(MediaQuery.of(context).size, food));
  }

  void clearOverlay() {
    _widgets.clear();
  }

  Container buildOpaqueBackgroundContainer() {
    return Container(
        color: Color.fromARGB(230, 60, 60, 60),
        child: GestureDetector(
          onTap: () => EventHandler().send(OverlayCloseEvent()),
        )
    );
  }

  Align buildFoodContainer(Size displaySize, Food food) {
    return Align(
        alignment: Alignment.center,
        child: Container(
            height: displaySize.height * 0.8,
            width: displaySize.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
            ),
            child: Center(child: Text(food.name))
        )
    );
  }


}