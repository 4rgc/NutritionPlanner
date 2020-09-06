import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertestproj/model/food.dart';
import 'package:fluttertestproj/model/foodSource.dart';
import 'package:fluttertestproj/components/listItem.dart';

import 'meal.dart';

class MealSource {
  static final data = {
    "1" : Meal(
      name: "Meal 1",
      foods: [FoodSource.data["egg"]]
    ),
    "2" : Meal(
        name: "Meal 2",
        foods: [
          FoodSource.data["egg"],
          FoodSource.data["egg"]
        ]
    ),
    "3" : Meal(
        name: "Meal 3",
        foods: [
          FoodSource.data["egg"],
          FoodSource.data["egg"],
          FoodSource.data["egg"]
        ]
    )
  };

  static double getTotalProteins() {
    var totalProteins = 0.0;
    for(Meal meal in data.values) {
      totalProteins += meal.getTotalProteins();
    }
    return totalProteins;
  }

  static double getTotalFats() {
    var totalFats = 0.0;
    for(Meal meal in data.values) {
      totalFats += meal.getTotalFats();
    }
    return totalFats;
  }

  static double getTotalCarbs() {
    var totalCarbs = 0.0;
    for(Meal meal in data.values) {
      totalCarbs += meal.getTotalCarbs();
    }
    return totalCarbs;
  }
}