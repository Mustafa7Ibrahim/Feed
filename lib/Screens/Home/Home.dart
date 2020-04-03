import 'package:flutter/material.dart';
import 'package:news_feed/Auth/Auth.dart';
import 'package:news_feed/Screens/Home/PostsList.dart';
import 'package:news_feed/Constant/constant.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: homeColor,
        centerTitle: true,
        elevation: 0.0,
        title: Text('Home', style: TextStyle(color: whiteColor)),
        leading: IconButton(
          icon: Icon(Icons.remove_circle_outline, color: whiteColor),
          onPressed: () => auth.signOutGoogle(context),
        ),
      ),
      // the list of posts
      body: PostsList(),
    );
  }
}
