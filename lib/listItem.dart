import 'package:flutter/material.dart';

abstract class ListItem {
  Widget buildName(BuildContext context);

  Widget buildCals(BuildContext context);
}