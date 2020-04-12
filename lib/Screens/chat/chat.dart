import 'package:flutter/material.dart';
import 'package:news_feed/Screens/chat/list_of_chats.dart';
import 'package:news_feed/models/User.dart';
import 'package:provider/provider.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final listOfUser = Provider.of<List<User>>(context) ?? [];
    final currentUser = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('People'),
        centerTitle: true,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: listOfUser.length,
          itemBuilder: (context, index) {
            if (listOfUser[index].userId != currentUser.userId) {
              return ListOfChats(
                user: listOfUser[index],
                currentUser: currentUser,
              );
            } else
              return Container();
          },
        ),
      ),
    );
  }
}
