import 'package:flutter/material.dart';
import 'package:fluttertestproj/components/countingFoodCard.dart';
import 'package:fluttertestproj/components/foodCard.dart';
import 'package:fluttertestproj/components/searchBar.dart';
import 'package:fluttertestproj/components/searchSwitch.dart';
import 'package:fluttertestproj/model/food.dart';
import 'package:fluttertestproj/model/foodSource.dart';
import 'package:fluttertestproj/model/meal.dart';

class FoodSearchScreen extends StatefulWidget {
  FoodSearchScreen({this.meal});

  final Meal meal;
  List<Food> _foundFoods = FoodSource.data.values.toList();

  @override
  State<StatefulWidget> createState() => _FoodSearchScreenState(meal);
}

class _FoodSearchScreenState extends State<FoodSearchScreen> {
  _FoodSearchScreenState(Meal meal) : _meal = meal {
    isAddScreen = _meal != null;
  }

  final Meal _meal;
  bool isAddScreen;
  String searchBarText = "";
  List<int> foodCounters = [];

  @override
  Widget build(BuildContext context) {
    print("build called");
    countFoodsInMeal();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
        child: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          title: FittedBox(
            child: Text(
              getScreenName(),
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
      body: Column(
        children: [
          AspectRatio(
              aspectRatio: MediaQuery.of(context).size.aspectRatio * 9,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: SearchBar(onTextChanged: searchBarTextChanged),
              )),
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SearchSwitch(
                onCustomPressed: customPressed,
                onOnlinePressed: onlinePressed,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget._foundFoods.length,
                itemBuilder: (BuildContext context, int index) {
                  return AspectRatio(
                    aspectRatio: MediaQuery.of(context).size.aspectRatio * 9,
                    child: CountingFoodCard(
                      food: widget._foundFoods[index],
                      onTap: () =>
                          foodRowOnTap(context, widget._foundFoods[index]),
                      counter: foodCounters[index],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  void countFoodsInMeal() {
    for (int i = 0; i < widget._foundFoods.length; i++) {
      foodCounters.insert(
          i,
          _meal.foods
              .where((element) => element == widget._foundFoods.elementAt(i))
              .length);
    }
  }

  String getScreenName() {
    if (isAddScreen)
      return "Search foods for " + _meal.name;
    else
      return "Search foods";
  }

  foodRowOnTap(BuildContext context, Food food) {
    setState(() {
      if (isAddScreen) {
        _meal.foods.add(food);
      } else
        //  TODO: Make it open the food overlay
        return;
    });
  }

  searchBarTextChanged(String newText) {
    setState(() {
      if (newText == "") {
        widget._foundFoods = FoodSource.data.values.toList();
      } else {
        widget._foundFoods = FoodSource.data.values
            .where((element) =>
                element.name.toLowerCase().contains(newText.toLowerCase()))
            ?.toList();
      }
      //if(_foundFoods.isEmpty)
      //TODO: show text that no foods are found
    });
  }

  customPressed() {
    return;
  }

  onlinePressed() {
    return;
  }
}
