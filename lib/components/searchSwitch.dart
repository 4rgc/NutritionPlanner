import 'package:flutter/material.dart';

class SearchSwitch extends StatefulWidget {
  SearchSwitch({this.onCustomPressed, this.onOnlinePressed});

  final Function onCustomPressed;
  final Function onOnlinePressed;

  @override
  State<StatefulWidget> createState() => _SearchSwitchState();
}

class _SearchSwitchState extends State<SearchSwitch> {
  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ToggleButtons(
          children: [Text("Custom"), Text("Online")],
          constraints:
              BoxConstraints.expand(width: constraints.maxWidth / 2 - 1.5),
          onPressed: (int index) {
            setState(() {
              for (int buttonIndex = 0;
                  buttonIndex < isSelected.length;
                  buttonIndex++) {
                if (buttonIndex == index) {
                  isSelected[buttonIndex] = true;
                } else {
                  isSelected[buttonIndex] = false;
                }
              }
            });
            if (index == 0) {
              if (widget.onCustomPressed != null) widget.onCustomPressed();
            } else if (index == 1) {
              if (widget.onOnlinePressed != null) widget.onOnlinePressed();
            }
          },
          isSelected: isSelected,
        );
      },
    );
  }
}
