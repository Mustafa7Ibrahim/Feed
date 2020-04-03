import 'package:flutter/material.dart';
import 'package:news_feed/Constant/constant.dart';
import 'package:news_feed/Screens/chat/ListOfChat.dart';
import 'package:news_feed/models/User.dart';
import 'package:provider/provider.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final listOfUser = Provider.of<List<User>>(context) ?? [];
    final currentUser = Provider.of<User>(context);

    return Container(
      color: backgroundColor,
      child: ListView.builder(
        itemCount: listOfUser.length,
        itemBuilder: (context, index) {
          if (listOfUser[index].userId != currentUser.userId) {
            return ListOfChat(
              user: listOfUser[index],
            );
          } else
            return Container();
        },
      ),
    );
  }
}
