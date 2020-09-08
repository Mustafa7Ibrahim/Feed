import 'package:flutter/material.dart';
import 'package:news_feed/models/comment_model.dart';

class CommentCard extends StatelessWidget {
  final CommentModel comment;
  CommentCard({this.comment});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(comment.userImageUrl),
            radius: 18.0,
          ),
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.all(12.0),
            margin: EdgeInsets.only(right: 12.0, bottom: 12.0),
            decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.color,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  comment.name,
                  style: Theme.of(context).textTheme.caption,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    comment.comment,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    comment.timeStamp,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
