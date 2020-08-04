import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertestproj/listItem.dart';
import 'package:fluttertestproj/nutritionData.dart';

import 'food.dart';

class FoodSource {
  static final data = {
    'egg' : Food(
      name: "egg",
      nutrition: NutritionData(
        proteins: 6,
        carbs: 0,
        fat: 5,
        sugar: 0,
        fiber: 0
      )
    )
  };

}