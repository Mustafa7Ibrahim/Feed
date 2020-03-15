import 'package:flutter/material.dart';
import 'package:news_feed/Auth/Auth.dart';
import 'package:news_feed/Screens/Home/Home.dart';
import 'package:news_feed/Screens/SignIn.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Auth auth = Auth();

    if (auth.id == null) {
      return SignIn();
    } else {
      return Home();
    }
  }
}
