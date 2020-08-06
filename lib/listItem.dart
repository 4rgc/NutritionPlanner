import 'package:flutter/material.dart';

abstract class FoodListItem {
  Widget buildName(BuildContext context);

  Widget buildCals(BuildContext context);
}