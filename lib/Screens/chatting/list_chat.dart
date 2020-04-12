import 'package:flutter/material.dart';
import 'package:news_feed/models/User.dart';
import 'package:news_feed/models/message.dart';
import 'package:provider/provider.dart';

class ListChat extends StatelessWidget {
  final Message message;
  final User friend;
  ListChat({this.message, this.friend});

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<User>(context);
    return message.userId != currentUser.userId
        ? Container(
            margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(message.friendImg),
                      radius: 24.0,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 4.0,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 12.0,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Text(
                        message.message,
                        textAlign: TextAlign.justify,
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 58.0),
                  child: Text(
                    message.timestamp.toString(),
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
          )
        : Container(
            margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 4.0,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 12.0,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Text(message.message),
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(currentUser.photoUrl),
                      radius: 24.0,
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(right: 58.0),
                  child: Text(message.timestamp.toString()),
                ),
              ],
            ),
          );
  }
}
