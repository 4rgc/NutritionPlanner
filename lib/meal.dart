import 'food.dart';

class Meal {
  final String name;
  final List<Food> foods;

  Meal({String name, List<Food> foods})
      : this.name = name, this.foods = foods;
}