import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: buildBackgroundDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
          child: AppBar(
            toolbarHeight: MediaQuery.of(context).size.height * 0.1,
            title: FittedBox(
              child: Text(
                "Log In",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.04,
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
          children: [],
        ),
      ),
    );
  }

  BoxDecoration buildBackgroundDecoration() {
    return BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/bg_gradient.jpg'),
            fit: BoxFit.cover));
  }
}
