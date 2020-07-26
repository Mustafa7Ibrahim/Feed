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
            margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
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
                    SizedBox(width: 8.0),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(4.0),
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 12,
                              offset: Offset(0, 8),
                              color: Theme.of(context)
                                  .iconTheme
                                  .color
                                  .withOpacity(0.1),
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
                              message.timestamp.toString(),
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
          )
        : Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(4.0),
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 12,
                              offset: Offset(0, 8),
                              color: Theme.of(context)
                                  .iconTheme
                                  .color
                                  .withOpacity(0.1),
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
                              message.timestamp.toString(),
                              style: TextStyle(
                                fontSize: 8.0,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    CircleAvatar(
                      backgroundImage: NetworkImage(currentUser.photoUrl),
                      radius: 18.0,
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
