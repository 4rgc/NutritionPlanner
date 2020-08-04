import 'package:flutter/material.dart';

import 'food.dart';

class FoodScreen extends StatefulWidget {
  FoodScreen({Key key, this.food}) : super(key: key);

  final Food food;

  @override
  State<StatefulWidget> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.food.name),
      ),
      body: Container()
    );
  }
  
}