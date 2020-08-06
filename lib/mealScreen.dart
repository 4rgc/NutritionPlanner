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
  final overlayWidgets = List<Widget>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meal.name),
      ),
      body: Stack(
        children: <Widget>[
            Column(
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
                      return buildFoodRow(context, widget.meal.foods[index]);
                    }
                ),
              ]
          ),
      ] + overlayWidgets,
      )
    );
  }

  Widget buildFoodRow(BuildContext context, Food food) {
    return Container(
        height: 50,
        margin: EdgeInsets.all(6),
        decoration: buildFoodEntryBoxDecoration(),
        child: InkWell (
          child: Container(
              child: Row(
                  children: getFoodRowWidgets(context, food)
              )
          ),
          onTap: () => foodRowOnTap(context, food),
        ),
    );
  }

  BoxDecoration buildFoodEntryBoxDecoration() {
    return BoxDecoration(
      border: Border(
          top: BorderSide(width: 1, color: Colors.blueGrey),
          bottom: BorderSide(width: 1, color: Colors.blueGrey)
      ),
    );
  }

  List<Widget> getFoodRowWidgets(BuildContext context, Food food) {
    return <Widget>[
      getFoodNameWidget(context, food),
      getFoodCalsWidget(context, food)
    ];
  }

  Container getFoodNameWidget(BuildContext context, Food food) {
    return Container(
        width: getNameWidth(context),
        decoration: buildFoodNameDecorationBox(),
        child: food.buildName(context)
    );
  }

  double getNameWidth(BuildContext context) => MediaQuery.of(context).size.width * 0.7 - 6;

  BoxDecoration buildFoodNameDecorationBox() {
    return BoxDecoration(
        border: Border(
          right: BorderSide(width: 2, color: Colors.blueGrey),
          left: BorderSide(width: 2, color: Colors.blueGrey),
        )
    );
  }

  Container getFoodCalsWidget(BuildContext context, Food food) {
    return Container(
        width: getFoodCalsWidth(context),
        decoration: buildFoodCalsDecorationBox(),
        child: food.buildCals(context)
    );
  }

  double getFoodCalsWidth(BuildContext context) => MediaQuery.of(context).size.width * 0.3 - 6;

  BoxDecoration buildFoodCalsDecorationBox() {
    return BoxDecoration(
        border: Border(
            right: BorderSide(width: 2, color: Colors.blueGrey)
        )
    );
  }

  Future foodRowOnTap(BuildContext context, Food food) {
    return Future(() {
      setState(() {
        addFoodOverlay(food);
      });
    });
  }
  
  void closeFoodOverlayIfExists() {
    setState(() {
      overlayWidgets.clear();
    });
  }

  void addFoodOverlay(Food food) {
    overlayWidgets.add(
        buildOpaqueBackgroundContainer()
    );
    overlayWidgets.add(
        buildFoodContainer(food)
    );
  }

  Container buildOpaqueBackgroundContainer() {
    return Container(
        color: Color.fromARGB(230, 60, 60, 60),
        child: GestureDetector(
          onTap: () => closeFoodOverlayIfExists(),
        )
    );
  }

  Align buildFoodContainer(Food food) {
    return Align(
          alignment: Alignment.center,
          child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
              ),
              child: Center(child: Text(food.name))
          )
      );
  }
}