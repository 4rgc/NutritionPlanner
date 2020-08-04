import 'package:flutter/material.dart';
import 'package:fluttertestproj/listItem.dart';
import 'package:fluttertestproj/nutritionData.dart';

class Food implements ListItem{
  final String name;
  final NutritionData nutrition;

  Food({String name, NutritionData nutrition}) : this.name=name, this.nutrition = nutrition;


  @override
  Widget buildCals(BuildContext context) {
    return Center(
      child: Text( getTotalCals().toStringAsFixed(1) + " cals" ),
    );
  }

  double getTotalCals() {
    return (nutrition.proteins + nutrition.carbs) * 4 + nutrition.fat * 9;
  }

  @override
  Widget buildName(BuildContext context) {
    return Center(
      child: Text( name )
    );
  }
}