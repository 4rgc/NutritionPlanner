import '../model/food.dart';

class Meal {
  String name;
  List<Food> foods;

  Meal({String name, List<Food> foods})
      : this.name = name, this.foods = foods;

  double getTotalCals() {
      var totalCals = 0.0;
      for(Food f in foods){
        totalCals += f.getTotalCals();
      }
      return totalCals;
  }

  double getTotalProteins() {
    var totalProteins = 0.0;
    for(Food f in foods){
      totalProteins += f.nutrition.proteins;
    }
    return totalProteins;
  }

  double getTotalFats() {
    var totalFats = 0.0;
    for(Food f in foods){
      totalFats += f.nutrition.fat;
    }
    return totalFats;
  }

  double getTotalCarbs() {
    var totalCarbs = 0.0;
    for(Food f in foods){
      totalCarbs += f.nutrition.carbs;
    }
    return totalCarbs;
  }
}