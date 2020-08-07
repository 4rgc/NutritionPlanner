import 'package:flutter/material.dart';

class PaddedLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.symmetric(horizontal:10.0),
      child:Container(
        height:1.0,
        color: Colors.black,
      )
    );
  }
}