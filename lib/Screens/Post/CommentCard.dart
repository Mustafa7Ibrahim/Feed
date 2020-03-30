import 'package:flutter/material.dart';
import 'package:news_feed/Constant/constant.dart';
import 'package:news_feed/models/Comment.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;
  CommentCard({this.comment});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          elevation: 8.0,
          child: ListTile(
            title: Text(
              comment.name,
              style: TextStyle(color: textColor),
            ),
            subtitle: Text(
              comment.timeStamp,
              style: TextStyle(color: textColor),
            ),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(comment.userImageUrl),
              radius: 24.0,
            ),
          ),
        ),
        Text(
          comment.comment,
          style: TextStyle(color: textColor),
        ),
      ],
    );
  }
}
