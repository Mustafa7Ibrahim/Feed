import 'package:firebase_core/firebase_core.dart';
import 'package:news_feed/utilts/app_theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import './Screens/Wrapper.dart';
import 'models/user_model.dart';
import 'screens/sign_in/sign_in.dart';
import 'utilts/app_theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var user = prefs.getString('user');
  var userId = prefs.getString('userId');
  var theme = prefs.getBool('darkTheme');
  runApp(
    ChangeNotifierProvider<AppThemeProvider>(
      create: (context) => AppThemeProvider(
        themeData: theme == null || theme == false
            ? AppThemeProvider.lightTheme
            : AppThemeProvider.darkTheme,
      ),
      child: Home(user: user, userId: userId),
    ),
  );
}

class Home extends StatelessWidget {
  final String user;
  final String userId;

  const Home({Key key, this.user, this.userId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppThemeProvider>(context);
    return StreamProvider.value(
      value: UserModel().currentUser,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme.getTheme(),
        home: user == null ? SignIn() : Wrapper(userId: userId),
      ),
    );
  }
}
