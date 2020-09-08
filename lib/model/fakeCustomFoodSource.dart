import 'package:fluttertestproj/model/foodSource.dart';
import 'package:fluttertestproj/model/nutritionData.dart';

import 'foodSource.dart';
import 'food.dart';

class FakeCustomFoodSource implements FoodSource {
  static final FakeCustomFoodSource _singleton =
      FakeCustomFoodSource._internal();

  factory FakeCustomFoodSource() {
    return _singleton;
  }

  FakeCustomFoodSource._internal();

  final data = {
    'egg': Food(
      name: "egg",
      nutrition:
          NutritionData(proteins: 6, carbs: 10, fat: 5, sugar: 0, fiber: 0),
      imagePath: 'assets/test/egg.jpg',
    )
  };
}
