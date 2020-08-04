import 'package:flutter/material.dart';
import 'package:fluttertestproj/foodScreen.dart';
import 'package:fluttertestproj/meal.dart';

import 'food.dart';

class MealScreen extends StatefulWidget {
  MealScreen({Key key, this.meal}) : super(key: key) ;

  // This widget is the home page of your application. It is stateful, meaning
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final Meal meal;

  @override
  _MealScreenState createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meal.name),
      ),
      body: Column(
        children: <Widget>[
          Center(
              heightFactor: 3,
              child: Text("What you ate for " + widget.meal.name)
          ),
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: widget.meal.foods.length,
              itemBuilder: (BuildContext context, int index) {
                return buildFood(context, widget.meal.foods[index]);
              }
          ),
        ]
      )
    );
  }

  Widget buildFood(BuildContext context, Food food) {
    return Container(
        height: 50,
        margin: EdgeInsets.all(6),
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(width: 1, color: Colors.blueGrey),
              bottom: BorderSide(width: 1, color: Colors.blueGrey)
          ),
        ),
        child: InkWell (
          child: Container(
              child: Row(
                  children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width * 0.7 - 6,
                        decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(width: 2, color: Colors.blueGrey),
                              left: BorderSide(width: 2, color: Colors.blueGrey),
                            )
                        ),
                        child: food.buildName(context)
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.3 - 6,
                        decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(width: 2, color: Colors.blueGrey)
                            )
                        ),
                        child: food.buildCals(context)
                    )
                  ]
              )
          ),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FoodScreen(
                  food: food
              ))
          ),
        ),
    );
  }
}