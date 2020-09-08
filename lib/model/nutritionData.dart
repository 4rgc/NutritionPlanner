class NutritionData {
  double proteins;
  double carbs;
  double fat;
  double sugar;
  double fiber;

  NutritionData(
      {double proteins, double carbs, double fat, double sugar, double fiber})
      : this.proteins = proteins,
        this.carbs = carbs,
        this.fat = fat,
        this.sugar = sugar,
        this.fiber = fiber;

  bool equals(NutritionData otherNutritionData) {
    return this.proteins == otherNutritionData.proteins &&
        this.carbs == otherNutritionData.carbs &&
        this.fat == otherNutritionData.fat &&
        this.sugar == otherNutritionData.sugar &&
        this.fiber == otherNutritionData.fiber;
  }
}
