import 'package:news_feed/utilts/app_theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import './Screens/SignIn/SignIn.dart';
import './Screens/Wrapper.dart';
import 'models/User.dart';
import 'utilts/app_theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var user = prefs.getString('user');
  var theme = prefs.getBool('darkTheme');
  print(user);
  runApp(
    ChangeNotifierProvider<AppThemeProvider>(
      create: (context) => AppThemeProvider(
        themeData: theme == null || theme == false
            ? AppThemeProvider.lightTheme
            : AppThemeProvider.darkTheme,
      ),
      child: Home(user: user),
    ),
  );
}

class Home extends StatelessWidget {
  final String user;

  const Home({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppThemeProvider>(context);
    return StreamProvider.value(
      value: User().currentUser,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme.getTheme(),
        home: user == null ? SignIn() : Wrapper(),
      ),
    );
  }
}
