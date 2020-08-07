import 'food.dart';

class Meal {
  String name;
  List<Food> foods;

  Meal({String name, List<Food> foods})
      : this.name = name, this.foods = foods;
}