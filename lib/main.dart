import 'package:news_feed/utilts/app_state_notifier.dart';
import 'package:news_feed/utilts/app_theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import './Screens/SignIn/SignIn.dart';
import './Screens/Wrapper.dart';
import 'models/User.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var user = prefs.getString('user');
  print(user);
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppStateNotifier(),
      child: Home(user: user),
    ),
  );
}

class Home extends StatelessWidget {
  final String user;

  const Home({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: User().currentUser,
      child: Consumer<AppStateNotifier>(
        builder: (context, appState, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppThemeProvider.lightTheme,
            darkTheme: AppThemeProvider.darkTheme,
            themeMode: appState.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
            home: user == null ? SignIn() : Wrapper(),
          );
        },
      ),
    );
  }
}
