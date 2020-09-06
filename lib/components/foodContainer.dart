import 'package:eventhandler/eventhandler.dart';
import 'package:flutter/material.dart';
import 'package:fluttertestproj/model/food.dart';
import 'package:fluttertestproj/components/paddedLine.dart';
import 'package:fluttertestproj/components/unpaddedLine.dart';

import '../model/nutrition_icons.dart';
import 'opaqueContainer.dart';

//TODO: if field is empty write 0 on apply

class OverlayCloseEvent extends EventBase {
  OverlayCloseEvent({this.foodUpdated});
  final bool foodUpdated;
}

class FoodOverlayControllers {
  FoodOverlayControllers(Food food)
      : controllers = {
          "name": TextEditingController(text: food.name),
          "protein":
              TextEditingController(text: food.nutrition.proteins.toString()),
          "fat": TextEditingController(text: food.nutrition.fat.toString()),
          "carbs": TextEditingController(text: food.nutrition.carbs.toString()),
          "sugar": TextEditingController(text: food.nutrition.sugar.toString()),
          "fiber": TextEditingController(text: food.nutrition.fiber.toString())
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
  FoodContainer(this.food, /*this.width, this.height*/ this.color)
      : controllers = FoodOverlayControllers(food);

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
            230),
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
            )));
  }

  Widget buildUpperBar() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[buildDiscardButton(), buildSaveButton()],
      ),
    );
  }

  Widget buildDiscardButton() {
    return IconButton(
      iconSize: MediaQuery.of(context).size.shortestSide / 20,
      icon: Icon(
        Icons.close,
      ),
      onPressed: onDiscardPressed,
    );
  }

  Widget buildSaveButton() {
    return IconButton(
      iconSize: MediaQuery.of(context).size.shortestSide / 20,
      icon: Icon(
        Icons.check,
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
    final double verticalPadding = 8.0;
    final double lineThickness = 1.0;
    final foodFieldsHeight = (MediaQuery.of(context).size.height * 0.7) - 1;

    return Container(
        height: foodFieldsHeight,
        child: Column(children: <Widget>[
          Container(
              height: foodFieldsHeight * 0.3 - verticalPadding,
              child: buildPictureNameBar('')),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: PaddedLine(),
          ),
          Container(
              height: foodFieldsHeight * 0.7 - verticalPadding - lineThickness,
              child: buildNutritionDataFields())
        ]));
  }

  Widget buildPictureNameBar(String picturePath) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image(
          width: MediaQuery.of(context).size.width * 0.3,
          image: AssetImage(food.imagePath),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.3,
          child: TextField(
            controller: controllers.nameController,
            decoration: buildHintDecoration(" Name"),
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.shortestSide / 15),
          ),
        )
      ],
    );
  }

  Widget buildNutritionDataFields() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                buildProteinField(),
                buildFatField(),
              ],
            ),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                buildCarbsField(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[buildSugarField(), buildFiberField()],
                )
              ],
            ),
          )
        ]);
  }

  Widget buildFiberField() {
    return Row(
      // fiber
      children: <Widget>[
        buildPaddedIcon(Nutrition.barley),
        Container(
          width: MediaQuery.of(context).size.width * 0.2,
          child: TextField(
              keyboardType: TextInputType.number,
              controller: controllers.fiberController,
              decoration: buildHintDecoration(" Fiber (g)"),
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.shortestSide / 25)),
        )
      ],
    );
  }

  InputDecoration buildHintDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      //contentPadding: EdgeInsets.fromLTRB(5.0 , 20.0 , 5.0 , 20.0)
    );
  }

  Widget buildPaddedIcon(IconData iconData) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(
        iconData,
        size: MediaQuery.of(context).size.width / 25,
      ),
    );
  }

  Widget buildSugarField() {
    return Row(
      children: <Widget>[
        buildPaddedIcon(Nutrition.spoon_sugar),
        Container(
          width: MediaQuery.of(context).size.width * 0.2,
          child: TextField(
              keyboardType: TextInputType.number,
              controller: controllers.sugarController,
              decoration: buildHintDecoration(" Sugar (g)"),
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.shortestSide / 25)),
        )
      ],
    );
  }

  Widget buildCarbsField() {
    return Row(
      children: <Widget>[
        buildPaddedIcon(Nutrition.bread_slice),
        Container(
          width: MediaQuery.of(context).size.width * 0.2,
          child: TextField(
            keyboardType: TextInputType.number,
            controller: controllers.carbsController,
            decoration: buildHintDecoration(" Carbs (g)"),
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.shortestSide / 25,
            ),
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
          width: MediaQuery.of(context).size.width * 0.2,
          child: TextField(
              keyboardType: TextInputType.number,
              controller: controllers.fatController,
              decoration: buildHintDecoration(" Fat (g)"),
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.shortestSide / 25)),
        )
      ],
    );
  }

  Widget buildProteinField() {
    return Row(
      children: <Widget>[
        buildPaddedIcon(Nutrition.food_steak),
        Container(
          width: MediaQuery.of(context).size.width * 0.2,
          child: TextField(
              keyboardType: TextInputType.number,
              controller: controllers.proteinController,
              decoration: buildHintDecoration(" Proteins (g)"),
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.shortestSide / 25)),
        )
      ],
    );
  }
}
