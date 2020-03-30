import 'package:flutter/material.dart';
import 'package:news_feed/Screens/Post/CommentCard.dart';
import 'package:news_feed/models/Comment.dart';
import 'package:news_feed/models/Post.dart';
import 'package:news_feed/Constant/constant.dart';

class CommentsList extends StatefulWidget {
  final Post thisPost;
  CommentsList({this.thisPost});

  @override
  _CommentsListState createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  Comment comment = Comment();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: commentsCollection
          .orderBy('timeStamp', descending: true)
          .snapshots()
          .map(comment.commentsList),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            height: 54.0,
            child: Center(
              child: Text(
                'No Comments',
                style: TextStyle(color: textColor),
              ),
            ),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Oh no! Error! ${snapshot.error}',
              style: TextStyle(color: textColor),
            ),
          );
        }
        if (snapshot.data['postId'] ==
            (widget.thisPost.ownerId + widget.thisPost.timeStamp)) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return CommentCard(comment: snapshot.data[index]);
            },
          );
        }
        return Container();
      },
    );
  }
}
