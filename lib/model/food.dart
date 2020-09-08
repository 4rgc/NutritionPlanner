import 'package:flutter/material.dart';
import 'package:fluttertestproj/components/listItem.dart';
import 'package:fluttertestproj/model/nutritionData.dart';

class Food implements FoodListItem {
  String name;
  NutritionData nutrition;
  String imagePath;

  Food({String name, NutritionData nutrition, String imagePath})
      : this.name = name,
        this.nutrition = nutrition,
        this.imagePath = imagePath;

  @override
  Widget buildCals(BuildContext context) {
    return Center(
      child: Text(getTotalCals().toStringAsFixed(1) + " cals"),
    );
  }

  double getTotalCals() {
    return (nutrition.proteins + nutrition.carbs) * 4 + nutrition.fat * 9;
  }

  @override
  Widget buildName(BuildContext context) {
    return Center(child: Text(name));
  }

  bool equals(Food otherFood) {
    return this.name == otherFood.name &&
        this.nutrition.equals(otherFood.nutrition) &&
        this.imagePath == otherFood.imagePath;
  }
}
