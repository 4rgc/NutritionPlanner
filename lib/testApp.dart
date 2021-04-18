import 'package:flutter/material.dart';
import 'package:fluttertestproj/components/macroPieChart.dart';
import 'package:fluttertestproj/util/macroColors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TestScreen(),
    );
  }
}

class TestScreen extends StatefulWidget {
  TestScreen({this.title});

  final title;

  @override
  State<StatefulWidget> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  double _widthValue = 300;
  double _heightValue = 80;

  int counter = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            child: Flex(
          direction: Axis.vertical,
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 60,
                  height: 50,
                  child: Slider(
                    min: 0.0,
                    max: MediaQuery.of(context).size.width - 50,
                    value: _widthValue,
                    onChanged: (double value) {
                      setState(() {
                        _widthValue = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: RotatedBox(
                      quarterTurns: 1,
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.height - 60,
                        child: Slider(
                          min: 0.0,
                          max: MediaQuery.of(context).size.height - 10,
                          value: _heightValue,
                          onChanged: (double value) {
                            setState(() {
                              _heightValue = value;
                            });
                          },
                        ),
                      )),
                ),
                Container(
                    width: _widthValue,
                    height: _heightValue,
                    child: MacroPieChart(
                      macroData: MacroData(
                          proteinGrams: 50,
                          carbsGrams: 100,
                          fatGrams: 30,
                          goalCals: 2000),
                      proteinColor: MacroColors.proteins,
                      carbsColor: MacroColors.carbs,
                      fatColor: MacroColors.fats,
                    ))
              ],
            )
          ],
        )),
      ),
    );
  }

  void onCardTap() {
    setState(() {
      counter++;
    });
  }
}
