import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertestproj/model/food.dart';
import 'package:fluttertestproj/util/macroColors.dart';

class FoodCard extends StatefulWidget {
  FoodCard({this.food, this.onTap});

  final Food food;
  final Function onTap;

  @override
  State<StatefulWidget> createState() => _FoodCardState(food, onTap);
}

class _FoodCardState extends State<FoodCard> {
  _FoodCardState(Food food, Function onTap)
      : _food = food,
        _onTap = onTap;

  final Food _food;
  final Function _onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: InkWell(
        onTap: _onTap == null
            ? () {
                print("oshimashita");
              }
            : _onTap,
        child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Card(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [buildImageAndName(), buildNutritionProportion()],
            ))),
      ),
    );
  }

  Widget buildImageAndName() {
    return FittedBox(
      child: Row(children: [
        buildImage(),
        Container(
          width: 100,
          height: 100,
        ),
        buildName(),
      ]),
    );
  }

  Padding buildImage() {
    return Padding(
      padding: const EdgeInsets.all(100.0),
      child: Card(
        child: Image(
            width: 1000, height: 1000, image: AssetImage(_food.imagePath)),
        elevation: 15,
      ),
    );
  }

  Container buildName() {
    return Container(
      //color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Text(
          _food.name,
          style: TextStyle(fontSize: 800),
        ),
      ),
    );
  }

  FittedBox buildNutritionProportion() {
    double carbs = _food.nutrition.carbs;
    double proteins = _food.nutrition.proteins;
    double fats = _food.nutrition.fat;

    double nutrientMax = max(max(proteins, fats), carbs);

    return FittedBox(
      child: Container(
        child: Row(children: [
          Padding(
              padding: const EdgeInsets.only(
                  left: 400.0, top: 100.0, bottom: 100.0, right: 300.0),
              child: Container(
                width: 1000,
                height: 1000,
                child: Row(
                  children: [
                    Flexible(
                        child: buildNutrientProportionColumn(
                            proteins, nutrientMax, MacroColors.proteins)),
                    Flexible(
                        child: buildNutrientProportionColumn(
                            fats, nutrientMax, MacroColors.fats)),
                    Flexible(
                        child: buildNutrientProportionColumn(
                            carbs, nutrientMax, MacroColors.carbs))
                  ],
                ),
              ))
        ]),
      ),
    );
  }

  Column buildNutrientProportionColumn(
      double nutrient, double nutrientAvg, Color color) {
    return Column(
      children: [
        Flexible(
            flex: getRemainingNutrientFlex(nutrient, nutrientAvg),
            child: Container(
              height: 1000,
            )),
        Expanded(
          flex: getNutrientFlex(nutrient, nutrientAvg),
          child: Container(
            color: color,
            height: 1000,
            width: double.infinity,
          ),
        ),
      ],
    );
  }

  int getNutrientFlex(double nutrient, double nutrientMax) {
    int flex = (nutrient / nutrientMax * 100).toInt();
    if (flex <= 0)
      return 1;
    else
      return flex;
  }

  int getRemainingNutrientFlex(double nutrient, double nutrientMax) {
    int flex = (100 - (nutrient / nutrientMax * 100)).toInt();
    if (flex <= 0) {
      return 1;
    } else
      return flex;
  }
}
