import 'package:flutter/material.dart';
import 'package:news_feed/Screens/auth/Register.dart';
import 'package:news_feed/Screens/auth/SignIn.dart';

class Authencation extends StatefulWidget {
  @override
  _AuthencationState createState() => _AuthencationState();
}

class _AuthencationState extends State<Authencation> {
  bool showSignIn = true;

  void changeView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(changeView: changeView);
    } else {
      return Register(changeView: changeView);
    }
  }
}
