import 'package:flutter/material.dart';
import 'package:news_feed/Screens/chatting/chatting.dart';
import 'package:news_feed/models/User.dart';

class ListOfChats extends StatelessWidget {
  final User user;
  ListOfChats({this.user});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(user.name),
        subtitle: Text(user.email),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.photoUrl),
          radius: 24.0,
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Chatting(user: user),
          ),
        ),
      ),
    );
  }
}
