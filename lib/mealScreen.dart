import 'package:eventhandler/eventhandler.dart';
import 'package:flutter/material.dart';
import 'package:fluttertestproj/foodOverlay.dart';
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
  _MealScreenState() {
    EventHandler().subscribe(_overlayCloseEventHandler);
  }
  final _foodOverlay = FoodOverlay();
  bool _foodOverlayVisible = false;

  void _overlayCloseEventHandler(OverlayCloseEvent event) {
    //if(event.foodUpdated)


    closeFoodOverlay();
  }

  void closeFoodOverlay() {
    setState(() => _foodOverlayVisible = false);

    Future.delayed(Duration(milliseconds: 200), () => {
        setState(() {
        _foodOverlay.clearOverlay();
      })
    });
  }

  @override
  void setState(fn) {
    if(mounted){
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
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
                      return buildFoodEntry(context, widget.meal.foods[index]);
                    }
                )
              ]
          ),
          AnimatedOpacity(
              opacity: _foodOverlayVisible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 200),
              child: Stack(
                children: _foodOverlay.toWidgetList(),
              )
          )
      ],
      )
    );
  }

  Widget buildFoodEntry(BuildContext context, Food food) {
    return Container(
        height: 50,
        margin: EdgeInsets.all(6),
        decoration: buildFoodEntryDecoration(),
        child: Material(
          child: InkWell (
            child: Container(
                child: Row(
                    children: getFoodRowWidgets(context, food)
                )
            ),
            onTap: () => foodRowOnTap(context, food),
          ),
        ),
    );
  }

  BoxDecoration buildFoodEntryDecoration() {
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

  Widget getFoodNameWidget(BuildContext context, Food food) {
    return Container(
        width: getNameWidth(context),
        decoration: buildFoodNameDecoration(),
        child: food.buildName(context)
    );
  }

  double getNameWidth(BuildContext context) => MediaQuery.of(context).size.width * 0.7 - 6;

  BoxDecoration buildFoodNameDecoration() {
    return BoxDecoration(
        border: Border(
          right: BorderSide(width: 2, color: Colors.blueGrey),
          left: BorderSide(width: 2, color: Colors.blueGrey),
        )
    );
  }

  Widget getFoodCalsWidget(BuildContext context, Food food) {
    return Container(
        width: getFoodCalsWidth(context),
        decoration: buildFoodCalsDecoration(),
        child: food.buildCals(context)
    );
  }

  double getFoodCalsWidth(BuildContext context) => MediaQuery.of(context).size.width * 0.3 - 6;

  BoxDecoration buildFoodCalsDecoration() {
    return BoxDecoration(
        border: Border(
            right: BorderSide(width: 2, color: Colors.blueGrey)
        )
    );
  }

  Future foodRowOnTap(BuildContext context, Food food) {
    return Future(() {
        addFoodOverlay(context, food);
      });
  }

  void addFoodOverlay(BuildContext context, Food food) {
    setState(() {
        _foodOverlay.addOverlay(context, food);
    });
    setState(() => _foodOverlayVisible = true);
  }
}