import 'package:flutter/material.dart';
import 'package:news_feed/Constant/constant.dart';
import 'package:news_feed/models/Comment.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;
  CommentCard({this.comment});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: forgroungColor,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      elevation: 0.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: Text(
              comment.name,
              style: TextStyle(
                color: blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(comment.userImageUrl),
              radius: 18.0,
            ),
            trailing: Text(
              comment.timeStamp,
              style: TextStyle(color: blackColor),
            ),
            dense: true,
          ),
          Container(
            margin: EdgeInsets.only(left: 70.0, right: 66.0),
            child: Text(
              comment.comment,
              style: TextStyle(color: blackColor, fontSize: 15.0),
            ),
          ),
          Divider(color: homeColor),
        ],
      ),
    );
  }
}
