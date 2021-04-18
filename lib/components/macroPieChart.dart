import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'indicator.dart';

class MacroPieChart extends StatefulWidget {
  MacroPieChart(
      {this.macroData, this.proteinColor, this.fatColor, this.carbsColor});

  GlobalKey _key = GlobalKey();
  MacroData macroData;
  final Color proteinColor;
  final Color fatColor;
  final Color carbsColor;

  @override
  State<StatefulWidget> createState() =>
      _MacroPieChartState(macroData, proteinColor, fatColor, carbsColor);
}

class _MacroPieChartState extends State<MacroPieChart> {
  _MacroPieChartState(
      this._macroData, this.proteinColor, this.fatColor, this.carbsColor);

  MacroData _macroData;
  final Color proteinColor;
  final Color fatColor;
  final Color carbsColor;
  double _aspectRatio = 1;

  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  @override
  void reassemble() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.reassemble();
  }

  void _afterLayout(_) {
    final RenderBox renderBox = widget._key.currentContext?.findRenderObject();
    _aspectRatio = renderBox?.size?.aspectRatio;
    _aspectRatio = _aspectRatio == null ? 0 : _aspectRatio;
    print("w: " +
        renderBox.size.width.toString() +
        " h: " +
        renderBox.size.height.toString());
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.scheduleFrameCallback(_afterLayout);
    _macroData = widget.macroData;
    var childrenWidgets = [
      const SizedBox(
        height: 18,
      ),
      Expanded(
        flex: 3,
        child: Align(
          alignment: Alignment.topLeft,
          child: buildPieChart(context),
        ),
      ),
      Expanded(
        child: Align(
          alignment: Alignment.bottomRight,
          child: buildNamedColumns(context),
        ),
      ),
      const SizedBox(
        width: 5,
      ),
    ];
    var wid = Card(
      key: widget._key,
      color: Colors.white,
      child: _aspectRatio > 1
          ? Row(children: childrenWidgets)
          : Column(children: childrenWidgets),
    );
    print(_aspectRatio);
    return wid;
  }

  FittedBox buildNamedColumns(BuildContext context) {
    return FittedBox(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Indicator(
            color: proteinColor,
            text: 'Proteins',
            isSquare: true,
            size: MediaQuery.of(context).size.shortestSide / 28 + 16,
          ),
          SizedBox(
            height: 4,
          ),
          Indicator(
              color: fatColor,
              text: 'Fats',
              isSquare: true,
              size: MediaQuery.of(context).size.shortestSide / 28 + 16),
          SizedBox(
            height: 4,
          ),
          Indicator(
              color: carbsColor,
              text: 'Carbs',
              isSquare: true,
              size: MediaQuery.of(context).size.shortestSide / 28 + 16),
          SizedBox(
            height: 4,
          ),
          Indicator(
              color: const Color(0xff7b8185),
              text: 'Remaining',
              isSquare: true,
              size: MediaQuery.of(context).size.shortestSide / 28 + 16),
          SizedBox(
            height: 18,
          ),
        ],
      ),
    );
  }

  AspectRatio buildPieChart(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: FittedBox(
        child: PieChart(
          PieChartData(
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: 0,
              centerSpaceRadius: MediaQuery.of(context).size.shortestSide / 8,
              sections: showingSections(context),
              startDegreeOffset: -90),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(BuildContext context) {
    return List.generate(4, (i) {
      final double fontSize = MediaQuery.of(context).size.shortestSide / 40;
      final double radius = MediaQuery.of(context).size.shortestSide / 10;
      switch (i) {
        case 0:
          return PieChartSectionData(
              color: proteinColor,
              value: _macroData.getProteinPercent(),
              title: _macroData.proteinGrams.toString() + 'g',
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffffffff),
                  fontFamily: "Arial"),
              showTitle: showProteinTitle());
        case 1:
          return PieChartSectionData(
              color: fatColor,
              value: _macroData.getFatPercent(),
              title: _macroData.fatGrams.toString() + 'g',
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffffffff)),
              showTitle: showFatsTitle());
        case 2:
          return PieChartSectionData(
              color: carbsColor,
              value: _macroData.getCarbsPercent(),
              title: _macroData.carbsGrams.toString() + 'g',
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffffffff)),
              showTitle: showCarbsTitle());
        case 3:
          return PieChartSectionData(
            color: const Color(0xff7b8185),
            value: _macroData.getRemainingPercent(),
            title: '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }

  bool showProteinTitle() =>
      (_macroData.getProteinPercent() > 15 ? true : false);
  bool showFatsTitle() => (_macroData.getFatPercent() > 15 ? true : false);
  bool showCarbsTitle() => (_macroData.getCarbsPercent() > 15 ? true : false);
}

class MacroData {
  MacroData({this.proteinGrams, this.fatGrams, this.carbsGrams, this.goalCals});

  final double proteinGrams;
  final double fatGrams;
  final double carbsGrams;
  final double goalCals;

  double getProteinPercent() {
    return (proteinGrams * 4) / goalCals * 100;
  }

  double getFatPercent() {
    return (fatGrams * 9) / goalCals * 100;
  }

  double getCarbsPercent() {
    return (carbsGrams * 4) / goalCals * 100;
  }

  double getRemainingPercent() {
    var difference =
        100 - getProteinPercent() - getCarbsPercent() - getCarbsPercent();
    if (difference < 0) return 0;
    return difference;
  }
}
