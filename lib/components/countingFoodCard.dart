import 'package:flutter/material.dart';
import 'package:fluttertestproj/components/foodCard.dart';
import 'package:fluttertestproj/model/food.dart';

class CountingFoodCard extends StatefulWidget {
  CountingFoodCard({this.food, this.onTap, this.counter});

  final Food food;
  final Function onTap;
  final int counter;

  @override
  State<StatefulWidget> createState() =>
      new _CountingFoodCardState(food: food, onTap: onTap);
}

class _CountingFoodCardState extends State<CountingFoodCard> {
  _CountingFoodCardState({this.food, this.onTap});
  final Food food;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: FoodCard(
            food: food,
            onTap: onTap,
          ),
        ),
        Positioned(
          // draw a red marble
          top: 0.0,
          right: 0.0,
          child: CircleAvatar(
              radius: MediaQuery.of(context).size.height / 42,
              backgroundColor: Colors.redAccent,
              child: FittedBox(
                child: Text(
                  widget.counter.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              )),
        ),
      ],
    );
  }
}
