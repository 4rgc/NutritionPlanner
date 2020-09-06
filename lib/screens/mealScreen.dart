import 'package:eventhandler/eventhandler.dart';
import 'package:flutter/material.dart';
import 'package:fluttertestproj/components/foodCard.dart';
import 'package:fluttertestproj/components/foodContainer.dart';
import 'package:fluttertestproj/components/macroBar.dart';
import 'package:fluttertestproj/model/meal.dart';
import 'package:fluttertestproj/screens/foodSearchScreen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../model/food.dart';

class MealScreen extends StatefulWidget {
  MealScreen({Key key, this.meal}) : super(key: key);

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
  FoodContainer _foodContainer;
  bool _foodContainerVisible = false;

  _getRequests() async {
    setState(() {});
  }

  void _overlayCloseEventHandler(OverlayCloseEvent event) {
    closeFoodContainer();
  }

  void closeFoodContainer() {
    setState(() => _foodContainerVisible = false);
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
          child: AppBar(
            toolbarHeight: MediaQuery.of(context).size.height * 0.1,
            title: FittedBox(
              child: Text(
                widget.meal.name,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.08,
                ),
              ),
            ),
            leadingWidth: MediaQuery.of(context).size.width * 0.12,
            leading: FittedBox(
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                iconSize: MediaQuery.of(context).size.height * 0.12,
                onPressed: () => Navigator.pop(context, true),
              ),
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Cals: " + widget.meal.getTotalCals().toString(),
                      style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.shortestSide / 10)),
                  AspectRatio(
                    aspectRatio: MediaQuery.of(context).size.aspectRatio * 15,
                    child: MacroBar(meal: widget.meal),
                  ),
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: widget.meal.foods.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AspectRatio(
                            aspectRatio:
                                MediaQuery.of(context).size.aspectRatio * 9,
                            child: FoodCard(
                                food: widget.meal.foods[index],
                                onTap: () => foodRowOnTap(
                                    context, widget.meal.foods[index])),
                          );
                        }),
                  )
                ]),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: MediaQuery.of(context).size.longestSide / 6,
                height: MediaQuery.of(context).size.longestSide / 6,
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FloatingActionButton(
                      onPressed: () => onAddFoodPressed(widget.meal),
                      child: Icon(
                        MdiIcons.plus,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: _foodContainerVisible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 200),
              child: _foodContainer,
              onEnd: onFoodContainerDisableAnimationEnded,
            )
          ],
        ));
  }

  BoxDecoration buildFoodEntryDecoration() {
    return BoxDecoration(
      border: Border(
          top: BorderSide(width: 1, color: Colors.blueGrey),
          bottom: BorderSide(width: 1, color: Colors.blueGrey)),
    );
  }

  List<Widget> buildFoodRowWidgets(BuildContext context, Food food) {
    return <Widget>[
      buildFoodNameWidget(context, food),
      buildFoodCalsWidget(context, food)
    ];
  }

  Widget buildFoodNameWidget(BuildContext context, Food food) {
    return Container(
        width: getNameWidth(context),
        decoration: buildFoodNameDecoration(),
        child: food.buildName(context));
  }

  double getNameWidth(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.7 - 6;

  BoxDecoration buildFoodNameDecoration() {
    return BoxDecoration(
        border: Border(
      right: BorderSide(width: 2, color: Colors.blueGrey),
      left: BorderSide(width: 2, color: Colors.blueGrey),
    ));
  }

  Widget buildFoodCalsWidget(BuildContext context, Food food) {
    return Container(
        width: getFoodCalsWidth(context),
        decoration: buildFoodCalsDecoration(),
        child: food.buildCals(context));
  }

  double getFoodCalsWidth(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.3 - 6;

  BoxDecoration buildFoodCalsDecoration() {
    return BoxDecoration(
        border: Border(right: BorderSide(width: 2, color: Colors.blueGrey)));
  }

  Future foodRowOnTap(BuildContext context, Food food) {
    return Future(() {
      addFoodContainer(context, food);
    });
  }

  void addFoodContainer(BuildContext context, Food food) {
    setState(() {
      _foodContainer = FoodContainer(food, Colors.black);
    });
    setState(() => _foodContainerVisible = true);
  }

  onFoodContainerDisableAnimationEnded() {
    if (!_foodContainerVisible) {
      setState(() {
        _foodContainer = null;
      });
    }
  }

  onAddFoodPressed(Meal meal) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                FoodSearchScreen(meal: meal))).then((value) => _getRequests());
  }
}
