import 'package:flutter/material.dart';
import 'package:news_feed/Screens/SignIn/SignIn.dart';
import 'package:news_feed/Screens/Wrapper.dart';
import 'package:news_feed/models/User.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/Post.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var user = prefs.getString('user');
  print(user);
  runApp(
    MultiProvider(
      providers: [
        StreamProvider<User>.value(value: User().currentUser),
        StreamProvider<List<Post>>.value(value: Post().getPosts),
        StreamProvider<List<User>>.value(value: User().listOfUsers),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: user == null ? SignIn() : Wrapper(),
      ),
    ),
  );
}
