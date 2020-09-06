import 'package:flutter/material.dart';
import 'package:fluttertestproj/model/meal.dart';
import 'package:fluttertestproj/model/mealSource.dart';
import 'package:fluttertestproj/model/nutrition_icons.dart';
import 'package:fluttertestproj/util/macroColors.dart';

class MacroBar extends StatefulWidget {
  MacroBar({this.meal});

  final Meal meal;

  @override
  State<StatefulWidget> createState() => _MacroBarState(meal);
}

class _MacroBarState extends State<MacroBar> {
  _MacroBarState(Meal meal) : _meal = meal;

  final Meal _meal;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          buildBarElement(
              flex: getProteinFlexFactor(),
              color: MacroColors.proteins,
              icon: Nutrition.food_steak
          ),
          Container(
            height: double.infinity,
            width: 1,
            color: Colors.black,
          ),
          buildBarElement(
              flex: getFatFlexFactor(),
              color: MacroColors.fats,
              icon: Nutrition.water
          ),
          Container(
            height: double.infinity,
            width: 1,
            color: Colors.black,
          ),
          buildBarElement(
              flex: getCarbsFlexFactor(),
              color: MacroColors.carbs,
              icon: Nutrition.bread_slice
          ),
        ],
      )
    );
  }

  int getProteinFlexFactor() {
    return _meal.getTotalProteins().toInt() * 4;
  }

  int getFatFlexFactor() {
    return _meal.getTotalFats().toInt() * 9;
  }

  int getCarbsFlexFactor() {
    return _meal.getTotalCarbs().toInt() * 4;
  }

  Widget buildBarElement({int flex, Color color, IconData icon}) {
    if(flex == 0)
      return Container();
    else
      return Expanded(
        flex: flex,
        child: Stack(
                  children: [
                    Container(
                        color: color,
                    ),
                    FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 200, top: 200, bottom: 200),
                        child: Icon(
                          icon,
                          size: 500,
                        ),
                      ),
                    )
                  ],
                ),
      );
  }

}