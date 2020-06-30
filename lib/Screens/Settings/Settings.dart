import 'package:flutter/material.dart';
import 'package:news_feed/utilts/app_state_notifier.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
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
              Text("Dark Mode"),
              Switch(
                value: Provider.of<AppStateNotifier>(context).isDarkModeOn,
                onChanged: (boolVal) {
                  Provider.of<AppStateNotifier>(context, listen: false)
                      .updateTheme(boolVal);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
