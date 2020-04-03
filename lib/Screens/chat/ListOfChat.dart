import 'package:flutter/material.dart';
import 'package:news_feed/models/User.dart';

class ListOfChat extends StatelessWidget {
  final User user;
  ListOfChat({this.user});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.name),
      subtitle: Text(user.email),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.photoUrl),
        radius: 24.0,
      ),
    );
  }
}
