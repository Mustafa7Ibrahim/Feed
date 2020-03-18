import 'package:flutter/material.dart';
import 'package:news_feed/Screens/wrapper.dart';
import 'package:news_feed/models/User.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: User().currentUser,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          accentColor: Colors.red,
          primarySwatch: Colors.blue,
        ),
        home: Wrapper(),
      ),
    );
  }
}
