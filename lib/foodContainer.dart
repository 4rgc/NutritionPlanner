import 'package:eventhandler/eventhandler.dart';
import 'package:flutter/material.dart';
import 'package:fluttertestproj/food.dart';
import 'package:fluttertestproj/paddedLine.dart';
import 'package:fluttertestproj/unpaddedLine.dart';

import 'nutrition_icons.dart';
import 'opaqueContainer.dart';

class OverlayCloseEvent extends EventBase {
  OverlayCloseEvent({this.foodUpdated});
  final bool foodUpdated;
}

class FoodOverlayControllers {
  FoodOverlayControllers(Food food) : controllers = {
    "name":     TextEditingController(text: food.name),
    "protein":  TextEditingController(text: food.nutrition.proteins.toString()),
    "fat":      TextEditingController(text: food.nutrition.fat.toString()),
    "carbs":    TextEditingController(text: food.nutrition.carbs.toString()),
    "sugar":    TextEditingController(text: food.nutrition.sugar.toString()),
    "fiber":    TextEditingController(text: food.nutrition.fiber.toString())
  };

  final Map<String, dynamic> controllers;

  TextEditingController get nameController => controllers["name"];
  TextEditingController get proteinController => controllers["protein"];
  TextEditingController get fatController => controllers["fat"];
  TextEditingController get carbsController => controllers["carbs"];
  TextEditingController get sugarController => controllers["sugar"];
  TextEditingController get fiberController => controllers["fiber"];
}

class FoodContainer extends StatefulWidget {

  FoodContainer(this.food, /*this.width, this.height*/ this.color) :
        controllers = FoodOverlayControllers(food);

  Food food;
  //final double width;
  //final double height;
  final Color color;
  final FoodOverlayControllers controllers;

  @override
  State<StatefulWidget> createState() => _FoodContainerState(controllers, food);

}

class _FoodContainerState extends State<FoodContainer> {
  _FoodContainerState(this.controllers, this.food);

  final controllers;
  var food;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          OpaqueContainer(
                  () => EventHandler().send(OverlayCloseEvent(foodUpdated: false)),
              230
          ),
          buildFoodContainer(context)
        ],
    );
  }

  Widget buildFoodContainer(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
            ),
            child: Container(
              height: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  buildUpperBar(),
                  UnpaddedLine(),
                  buildFoodFields()
                ],
              ),
            )
        )
    );
  }

  Widget buildUpperBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        buildDiscardButton(),
        buildSaveButton()
      ],
    );
  }

  Widget buildDiscardButton() {
    return IconButton(
      icon: Icon(
          Icons.close
      ),
      onPressed: onDiscardPressed,
    );
  }

  Widget buildSaveButton() {
    return IconButton(
      icon: Icon(
          Icons.check
      ),
      onPressed: onSavePressed,
    );
  }

  void onDiscardPressed() {
    EventHandler().send(OverlayCloseEvent(foodUpdated: false));
  }

  void onSavePressed() {
    food.name = controllers.nameController.text;
    food.nutrition.proteins = double.parse(controllers.proteinController.text);
    food.nutrition.fat = double.parse(controllers.fatController.text);
    food.nutrition.carbs = double.parse(controllers.carbsController.text);
    food.nutrition.sugar = double.parse(controllers.sugarController.text);
    food.nutrition.fiber = double.parse(controllers.fiberController.text);

    EventHandler().send(OverlayCloseEvent(foodUpdated: true));
  }

  Widget buildFoodFields() {
    return Container(
        child: Column(
            children: <Widget>[
              ///TODO: replace empty picture path with real one
              buildPictureNameBar(''),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: PaddedLine(),
              ),
              buildNutritionDataFields()
            ])
    );
  }

  Widget buildNutritionDataFields() {
    return Container(
      height: 180,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildProteinField(),
                buildFatField(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                buildCarbsField(),
                Column(
                  children: <Widget>[
                    buildSugarField(),
                    buildFiberField()
                  ],
                )
              ],
            )
          ]),
    );
  }

  Widget buildFiberField() {
    return Row( // fiber
      children: <Widget>[
        buildPaddedIcon(Nutrition.barley),
        Container(
          width: 100,
          child: TextField(
              keyboardType: TextInputType.number,
              controller: controllers.fiberController,
              decoration: buildHintDecoration(" Fiber (g)")
          ),
        )
      ],
    );
  }

  InputDecoration buildHintDecoration(String hint) {
    return InputDecoration(
        hintText: hint
    );
  }

  Widget buildPaddedIcon(IconData iconData) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(iconData),
    );
  }

  Widget buildSugarField() {
    return Row(
      children: <Widget>[
        buildPaddedIcon(Nutrition.spoon_sugar),
        Container(
          width: 100,
          child: TextField(
              keyboardType: TextInputType.number,
              controller: controllers.sugarController,
              decoration: buildHintDecoration(" Sugar (g)")
          ),
        )
      ],
    );
  }

  Widget buildCarbsField() {
    return Row(
      children: <Widget>[
        buildPaddedIcon(Nutrition.bread_slice),
        Container(
          width: 100,
          child: TextField(
              keyboardType: TextInputType.number,
              controller: controllers.carbsController,
              decoration: buildHintDecoration(" Carbs (g)")
          ),
        )
      ],
    );
  }

  Widget buildFatField() {
    return Row(
      children: <Widget>[
        buildPaddedIcon(Nutrition.water),
        Container(
          width: 100,
          child: TextField(
              keyboardType: TextInputType.number,
              controller: controllers.fatController,
              decoration: buildHintDecoration(" Fat (g)")
          ),
        )
      ],
    );
  }

  Widget buildProteinField() {
    return Row(
      children: <Widget>[
        buildPaddedIcon(Nutrition.food_steak),
        Container(
          width: 100,
          child: TextField(
              keyboardType: TextInputType.number,
              controller: controllers.proteinController,
              decoration: buildHintDecoration(" Proteins (g)")
          ),
        )
      ],
    );
  }

  Widget buildPictureNameBar(String picturePath) {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image(
              width: 80,
              height: 80,
              image: AssetImage('assets/test/egg.jpg')
          ),
          Container(
            width: 180,
            child: TextField(
              controller: controllers.nameController,
              decoration: buildHintDecoration(" Name"),

            ),
          )
        ],
      ),
    );
  }
}