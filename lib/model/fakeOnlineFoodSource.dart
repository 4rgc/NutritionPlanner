import 'package:fluttertestproj/model/nutritionData.dart';
import 'food.dart';
import 'foodSource.dart';

class FakeOnlineFoodSource implements FoodSource {
  static final FakeOnlineFoodSource _singleton =
      FakeOnlineFoodSource._internal();

  factory FakeOnlineFoodSource() {
    return _singleton;
  }

  FakeOnlineFoodSource._internal();

  final data = {
    'egg': Food(
      name: "egg",
      nutrition:
          NutritionData(proteins: 6, carbs: 10, fat: 5, sugar: 0, fiber: 0),
      imagePath: 'assets/test/egg.jpg',
    )
  };
}
