import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertestproj/model/meal.dart';

class MealCard extends StatefulWidget {
  MealCard({this.meal, this.width, this.height, Function(Meal) onTap}) : _onTap = (onTap == null ? () {} : onTap);

  final Meal meal;
  double width;
  double height;
  final Function(Meal) _onTap;

  @override
  _MealCardState createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: widget.width,
        height: widget.height,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(100),
          onTap: () => widget._onTap(widget.meal),
          child: FittedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildMealName(),
                buildCalories()
              ],
            ),
          ),
        ),
      ),
    );
  }

  FittedBox buildCalories() {
    return FittedBox(
      fit: BoxFit.fitHeight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: AutoSizeText(
                        "Cals: ",
                        style: TextStyle(
                          fontSize: 120
                        ),
                        minFontSize: 20,
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, right: 8),
                    child: AutoSizeText(
                        widget.meal.getTotalCals().toString(),
                        style: TextStyle(
                          fontSize: 100
                        ),
                      minFontSize: 20,
                    ),
                  )
                ],
              ),
            );
  }

  Padding buildMealName() {
    return Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  widget.meal.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 120
                  ),
                ),
              ),
            );
  }
}