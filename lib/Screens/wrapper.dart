// import 'package:flutter/material.dart';
// import 'package:news_feed/Screens/SignIn/SignIn.dart';
// import 'package:news_feed/Screens/WrapMain.dart';
// import 'package:news_feed/models/User.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Wrapper extends StatefulWidget {
//   @override
//   _WrapperState createState() => _WrapperState();
// }

// class _WrapperState extends State<Wrapper> {
//   bool sign;

//   saveState(User user) async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     if (user != null)
//       preferences.setBool('Signed', true);
//     else
//       preferences.setBool('Signed', false);
//   }

//   getState(bool sign) async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     sign = preferences.getBool('Signed');
//   }

//   @override
//   Widget build(BuildContext context) {
//     // provid the build widget with the current user state

//     final user = Provider.of<User>(context);
//     saveState(user);

//     // checking if the user has already sign in
//     if (getState(sign) == true) {
//       return WrapMainHome();
//     } else {
//       return SignIn();
//     }
//   }
// }
