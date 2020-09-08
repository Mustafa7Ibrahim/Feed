import 'package:flutter/material.dart';
import 'package:news_feed/models/comment_model.dart';
import 'package:news_feed/models/post_model.dart';
import 'package:news_feed/Constant/constant.dart';

import 'comment_card.dart';

class CommentsList extends StatelessWidget {
  final focus;
  final PostModel thisPost;

  CommentsList({this.thisPost, this.focus});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: postCollection
          .doc(thisPost.postId)
          .collection('comments')
          .orderBy('timeStamp', descending: true)
          .snapshots()
          .map(CommentModel().commentsList),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            child: Center(child: Text('No Comments')),
          );
        } else if (snapshot.hasError) {
          return Container(
            child: Center(child: Text('oh! no! we got erroe ${snapshot.error}')),
          );
        } else {
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return CommentCard(comment: snapshot.data[index]);
            },
          );
        }
      },
    );
  }
}
