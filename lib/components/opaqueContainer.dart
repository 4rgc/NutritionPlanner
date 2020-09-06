import 'package:flutter/material.dart';

class OpaqueContainer extends StatefulWidget {
  OpaqueContainer(this.onTap, this.opacity);

  final Function onTap;
  final int opacity;

  @override
  State<StatefulWidget> createState() => _OpaqueContainerState();

}

class _OpaqueContainerState extends State<OpaqueContainer> {
  _OpaqueContainerState();
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color.fromARGB(widget.opacity, 60, 60, 60),
        child: GestureDetector(
          onTap: widget.onTap,
        )
    );
  }

}