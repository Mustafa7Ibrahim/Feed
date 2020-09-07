import 'package:flutter/material.dart';
import 'package:news_feed/models/user_model.dart';
import 'package:news_feed/models/message_model.dart';
import 'package:news_feed/widgets/record_messages/player.dart';
import 'package:provider/provider.dart';

class ListChat extends StatelessWidget {
  final MessageModel message;
  final UserModel friend;
  ListChat({this.message, this.friend});

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserModel>(context);
    return message.userId == currentUser.userId
        ? message.type == 'record'
            ? buildCurrentUserRecordMessage(context)
            : buildCurrentUserMessage(context)
        : message.type == 'record'
            ? buildFriendRecordMessage(context)
            : buildFriendMessage(context);
  }

  buildCurrentUserRecordMessage(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 12,
                    offset: Offset(0, 8),
                    color: Theme.of(context).appBarTheme.color.withOpacity(0.1),
                  ),
                ],
                color: Theme.of(context).appBarTheme.color,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Player(url: message.message),
                  SizedBox(height: 6.0),
                  Text(
                    message.timestamp,
                    style: TextStyle(
                      fontSize: 8.0,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 12.0),
          CircleAvatar(
            backgroundImage: NetworkImage(message.friendImg),
            radius: 18.0,
          ),
        ],
      ),
    );
  }

  buildFriendRecordMessage(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(message.friendImg),
            radius: 18.0,
          ),
          SizedBox(width: 12.0),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 12,
                    offset: Offset(0, 8),
                    color: Theme.of(context).appBarTheme.color.withOpacity(0.1),
                  ),
                ],
                color: Theme.of(context).appBarTheme.color,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Player(url: message.message),
                  SizedBox(height: 6.0),
                  Text(
                    message.timestamp,
                    style: TextStyle(
                      fontSize: 8.0,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 12.0),
          CircleAvatar(
            backgroundImage: NetworkImage(message.friendImg),
            radius: 18.0,
          ),
        ],
      ),
    );
  }

  buildCurrentUserMessage(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 12,
                        offset: Offset(0, 8),
                        color: Theme.of(context).appBarTheme.color.withOpacity(0.1),
                      ),
                    ],
                    color: Theme.of(context).appBarTheme.color,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        message.message,
                        textAlign: TextAlign.justify,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      SizedBox(height: 6.0),
                      Text(
                        message.timestamp,
                        style: TextStyle(
                          fontSize: 8.0,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12.0),
              CircleAvatar(
                backgroundImage: NetworkImage(message.friendImg),
                radius: 18.0,
              ),
            ],
          )
        ],
      ),
    );
  }

  buildFriendMessage(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
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
                radius: 18.0,
              ),
              SizedBox(width: 12.0),
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 12,
                        offset: Offset(0, 8),
                        color: Theme.of(context).appBarTheme.color.withOpacity(0.1),
                      ),
                    ],
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        message.message,
                        textAlign: TextAlign.justify,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      SizedBox(height: 6.0),
                      Text(
                        message.timestamp,
                        style: TextStyle(
                          fontSize: 8.0,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
