import 'package:flutter/material.dart';
import 'package:news_feed/Screens/SignIn/SignIn.dart';
import 'package:news_feed/Screens/Wrapper.dart';
import 'package:news_feed/models/User.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var user = prefs.getString('user');
  print(user);
  runApp(
    StreamProvider<User>.value(
      value: User().currentUser,
      child: MaterialApp(home: user == null ? SignIn() : Wrapper()),
    ),
  );
}
