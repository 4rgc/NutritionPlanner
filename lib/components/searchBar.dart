import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  SearchBar({this.onTextChanged});

  final Function(String) onTextChanged;

  @override
  State<StatefulWidget> createState() => _SearchBarState(onTextChanged);
}

class _SearchBarState extends State<SearchBar> {
  _SearchBarState(this._onTextChanged);

  final Function(String) _onTextChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.search, size: MediaQuery.of(context).size.height / 20),
        SizedBox(
          height: 1000,
          width: 8.0,
        ),
        Expanded(
          child: TextField(
            onChanged: _onTextChanged,
            style: TextStyle(fontSize: MediaQuery.of(context).size.height / 20),
          ),
        )
      ],
    );
  }
}
