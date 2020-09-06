import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertestproj/components/listItem.dart';
import 'package:fluttertestproj/model/nutritionData.dart';

import '../model/food.dart';

class FoodSource {
  static final data = {
    'egg' : Food(
      name: "egg",
      nutrition: NutritionData(
        proteins: 6,
        carbs: 10,
        fat: 5,
        sugar: 0,
        fiber: 0
      ),
      imagePath: 'assets/test/egg.jpg',
    )
  };

}