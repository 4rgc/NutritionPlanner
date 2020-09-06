import 'package:flutter/material.dart';
import 'package:fluttertestproj/components/mealCard.dart';
import 'package:fluttertestproj/screens/mealScreen.dart';
import 'package:fluttertestproj/model/mealSource.dart';
import 'package:fluttertestproj/util/macroColors.dart';

import '../components/macroPieChart.dart';
import '../model/meal.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  double totalProteins = MealSource.getTotalProteins();
  double totalFats = MealSource.getTotalFats();
  double totalCarbs = MealSource.getTotalCarbs();
  MacroData macroData = MacroData(
    proteinGrams: MealSource.getTotalProteins(),
    fatGrams: MealSource.getTotalFats(),
    carbsGrams: MealSource.getTotalCarbs(),
    goalCals: 2000
  );

  _getRequests()async{
    setState(() {
      macroData = MacroData(
          proteinGrams: MealSource.getTotalProteins(),
          fatGrams: MealSource.getTotalFats(),
          carbsGrams: MealSource.getTotalCarbs(),
          goalCals: 2000
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
        child: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          title: FittedBox(
            child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.08,
                ),
            ),
          ),

        ),
      ),
      body: Container(
        child: Scaffold(
          body: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MealCard(
                    meal: MealSource.data["1"],
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.3,
                    onTap: onMealCardTapped,
                  ),
                  MealCard(
                    meal: MealSource.data["2"],
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.3,
                    onTap: onMealCardTapped,
                  ),
                  MealCard(
                    meal: MealSource.data["3"],
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.3,
                    onTap: onMealCardTapped,
                  ),
                ],
              ),
              Expanded(
                child: MacroPieChart(
                  macroData: macroData,
                  proteinColor: MacroColors.proteins,
                  fatColor: MacroColors.fats,
                  carbsColor: MacroColors.carbs,
                ),
              )
            ],
          ),
        ),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void onMealCardTapped(Meal meal) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MealScreen(meal: meal),
        )
    ).then((val)=>{_getRequests()});
  }
}
