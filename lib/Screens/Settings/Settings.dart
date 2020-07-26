import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utilts/app_theme_provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isSwitched = false;

  getCurrentTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final darkTheme = sharedPreferences.getBool('darkTheme');
    if (darkTheme == false || darkTheme == null)
      setState(() => isSwitched = false);
    else
      setState(() => isSwitched = true);
  }

  @override
  void initState() {
    getCurrentTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var changeTheme = Provider.of<AppThemeProvider>(context, listen: false);
    void switchChange(bool value) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      if (isSwitched == false) {
        changeTheme.setTheme(AppThemeProvider.darkTheme);
        setState(() {
          isSwitched = true;
          pref.setBool('darkTheme', true);
        });
      } else {
        changeTheme.setTheme(AppThemeProvider.lightTheme);
        setState(() {
          isSwitched = false;
          pref.setBool('darkTheme', false);
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Dark Theme'),
              Switch(
                value: isSwitched,
                onChanged: (boolVal) => switchChange(boolVal),
              )
            ],
          ),
        ),
      ),
    );
  }
}
