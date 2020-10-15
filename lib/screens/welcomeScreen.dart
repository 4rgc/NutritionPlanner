import 'package:flutter/material.dart';
import 'package:fluttertestproj/screens/loginScreen.dart';

import 'mainScreen.dart';

class WelcomeScreenController {
  WelcomeScreenController() {
    showWelcomePage();
  }

  bool _showWelcomePage;
  bool _showLoginPage;

  void showWelcomePage() {
    _showWelcomePage = true;
    _showLoginPage = false;
  }

  bool isWelcomePageBeingShown() => _showWelcomePage;

  void showLoginPage() {
    _showWelcomePage = false;
    _showLoginPage = true;
  }

  bool isLoginPageBeingShown() => _showLoginPage;
}

class WelcomeScreen extends StatefulWidget {
  final controller = new WelcomeScreenController();

  @override
  State<StatefulWidget> createState() => _WelcomeScreenState(controller);
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  _WelcomeScreenState(this.controller);

  final WelcomeScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: buildBackgroundDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          child: Column(
            children: [
              controller.isWelcomePageBeingShown()
                  ? Expanded(child: new WelcomePage(controller))
                  : new Container(),
            ],
          ),
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

class WelcomePage extends StatelessWidget {
  WelcomePage(this.controller);

  WelcomeScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 1, child: Container()),
        Expanded(
          flex: 6,
          child: Center(
            child: buildTitle(),
          ),
        ),
        Expanded(
          flex: 8,
          child: Container(
            child: Column(
              children: [
                Expanded(child: Container(), flex: 2),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 120, left: 120),
                      child: buildSignInButton(context),
                    ),
                    flex: 2),
                Expanded(child: Container(), flex: 2),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 120, left: 120),
                      child: buildSignUpButton(),
                    ),
                    flex: 2),
                Expanded(child: Container(), flex: 6),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildSignUpButton() {
    return Card(
      color: Colors.transparent,
      child: InkWell(
          child: Center(
              child: Text("Sign Up",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'RopaSans',
                      fontSize: 36))),
          onTap: () {}),
    );
  }

  Widget buildSignInButton(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: InkWell(
          child: Center(
              child: Text("Sign In",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'RopaSans',
                      fontSize: 36))),
          onTap: () => signInPressed(context)),
    );
  }

  Widget buildTitle() {
    return Text(
      "Nutrition Planner",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontFamily: "RougeScript",
          fontSize: 90,
          color: Colors.white,
          shadows: [
            Shadow(
              offset: Offset(3.0, 3.0),
              blurRadius: 12.0,
              color: Color.fromARGB(255, 0, 0, 0),
            )
          ]),
    );
  }

  void signInPressed(BuildContext context) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => MainScreen(
                  title: "Nutrition Planner",
                )));
  }
}
