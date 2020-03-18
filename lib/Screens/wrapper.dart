import 'package:flutter/material.dart';
import 'package:news_feed/Screens/Home/Home.dart';
import 'package:news_feed/Screens/SignIn.dart';
import 'package:news_feed/models/User.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {

  // this way when i  just use the nurmal way of google sign in
  // final GoogleSignIn googleSignIn = GoogleSignIn();
  // bool isLoaggedIn;

  // @override
  // void initState() {
  //   super.initState();
  //   isSignIn();
  // }

  // void isSignIn() async {
  //   isLoaggedIn = await googleSignIn.isSignedIn();
  // }

  @override
  Widget build(BuildContext context) {
    // provid the build widget with the current user state
    final user = Provider.of<User>(context);
    // checking if the user has already sign in
    if (user == null) {
      return SignIn();
    } else {
      return Home();
    }
  }
}
