import 'package:flutter/material.dart';
import 'package:news_feed/Screens/chatting/chatting.dart';
import 'package:news_feed/models/user_model.dart';

class ListOfChats extends StatefulWidget {
  final UserModel currentUser;
  final UserModel user;
  ListOfChats({this.user, this.currentUser});

  @override
  _ListOfChatsState createState() => _ListOfChatsState();
}

class _ListOfChatsState extends State<ListOfChats> {
  int chatId;

  chatIDgen() {
    int currentUserAuth = widget.currentUser.userId.hashCode;
    int friend = widget.user.userId.hashCode;

    if (currentUserAuth > friend)
      return chatId = currentUserAuth + friend;
    else
      return chatId = friend + currentUserAuth;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).appBarTheme.color,
      child: ListTile(
          title: Text(widget.user.name),
          subtitle: Text(widget.user.email),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(widget.user.photoUrl),
            radius: 24.0,
          ),
          onTap: () {
            chatIDgen();
            print(chatId);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Chatting(
                  freind: widget.user,
                  chatId: chatId.toString(),
                ),
              ),
            );
          }),
    );
  }
}
