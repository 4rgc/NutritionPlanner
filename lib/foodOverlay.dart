import 'package:eventhandler/eventhandler.dart';
import 'package:flutter/material.dart';
import 'package:fluttertestproj/mealScreen.dart';
import 'package:fluttertestproj/nutrition_icons.dart';
import 'package:fluttertestproj/paddedLine.dart';
import 'package:fluttertestproj/unpaddedLine.dart';

import 'food.dart';

class OverlayCloseEvent extends EventBase {
  OverlayCloseEvent({this.foodUpdated});
  final bool foodUpdated;
}

class FoodOverlay {
  FoodOverlay();

  final _widgets = List<Widget>();
  var food = Food();

  var nameController = TextEditingController();
  var proteinController = TextEditingController();
  var fatController = TextEditingController();
  var carbsController = TextEditingController();
  var sugarController = TextEditingController();
  var fiberController = TextEditingController();


  List<Widget> toWidgetList() {
    return List<Widget>.from(_widgets);
  }

  void addOverlay(BuildContext context, Food food) {
    this.food = food;
    nameController.text = food.name;
    proteinController.text = food.nutrition.proteins.toString();
    fatController.text = food.nutrition.fat.toString();
    carbsController.text = food.nutrition.carbs.toString();
    sugarController.text = food.nutrition.sugar.toString();
    fiberController.text = food.nutrition.fiber.toString();

    _widgets.add(buildOpaqueBackgroundContainer());
    _widgets.add(buildFoodContainer(MediaQuery.of(context).size));
  }

  void clearOverlay() {
    _widgets.clear();
  }

  Widget buildOpaqueBackgroundContainer() {
    return Container(
        color: Color.fromARGB(230, 60, 60, 60),
        child: GestureDetector(
          onTap: () => EventHandler().send(OverlayCloseEvent(foodUpdated: false)),
        )
    );
  }

  Widget buildFoodContainer(Size displaySize) {
    return Align(
        alignment: Alignment.center,
        child: Container(
            height: displaySize.height * 0.8,
            width: displaySize.width * 0.8,
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
    food.name = nameController.text;
    food.nutrition.proteins = double.parse(proteinController.text);
    food.nutrition.fat = double.parse(fatController.text);
    food.nutrition.carbs = double.parse(carbsController.text);
    food.nutrition.sugar = double.parse(sugarController.text);
    food.nutrition.fiber = double.parse(fiberController.text);

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
                  controller: fiberController,
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
                controller: sugarController,
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
                  controller: carbsController,
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
                controller: fatController,
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
                controller: proteinController,
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
                    controller: nameController,
                    decoration: buildHintDecoration(" Name"),

                  ),
                )
            ],
        ),
      );
  }
}