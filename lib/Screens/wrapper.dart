import 'package:flutter/material.dart';
import 'package:news_feed/Screens/Home/Home.dart';
import 'package:news_feed/Screens/authencation/SignIn.dart';
import 'package:news_feed/models/User.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return SignIn();
    } else {
      return Home();
    }
  }
}
