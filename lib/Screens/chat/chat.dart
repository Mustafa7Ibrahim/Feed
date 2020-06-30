import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_feed/Screens/chat/list_of_chats.dart';
import 'package:news_feed/models/User.dart';
import 'package:provider/provider.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('People'),
        centerTitle: true,
      ),
      body: Container(
        child: StreamBuilder<List<User>>(
            stream: User().listOfUsers,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        if (snapshot.data[index].userId != currentUser.userId) {
                          return ListOfChats(
                            user: snapshot.data[index],
                            currentUser: currentUser,
                          );
                        } else
                          return Container();
                      },
                    )
                  : Center(
                      child: SpinKitFoldingCube(
                        color: Theme.of(context).primaryColor,
                        size: 24.0,
                      ),
                    );
            }),
      ),
    );
  }
}
