import 'package:flutter/material.dart';
import 'package:news_feed/Screens/SignIn/SignIn.dart';
import 'package:news_feed/Screens/WrapMainHome.dart';
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
      child: MaterialApp(home: user == null ? SignIn() : WrapMainHome()),
    ),
  );
}

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext contex-t) {
//     return StreamProvider<User>.value(
//       value: User().currentUser,
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: Wrapper(),
//       ),
//     );
//   }
// }
