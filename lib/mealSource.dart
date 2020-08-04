import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertestproj/food.dart';
import 'package:fluttertestproj/foodSource.dart';
import 'package:fluttertestproj/listItem.dart';

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
}