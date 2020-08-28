import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:news_feed/Constant/constant.dart';

class Comment {
  final String name;
  final String comment;
  final String postUid;
  final String timeStamp;
  final String userImageUrl;

  Comment({
    this.name,
    this.comment,
    this.timeStamp,
    this.userImageUrl,
    this.postUid,
  });

  String formattedDate = DateFormat().add_yMEd().add_jm().format(DateTime.now());

  Future addNewComment({String comment, String postId}) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return await postCollection.document(postId).collection('comments').document().setData({
      'postId': postId,
      'comment': comment,
      'userName': user.displayName,
      'userImageUrl': user.photoUrl,
      'timeStamp': formattedDate,
    });
  }

  List<Comment> commentsList(QuerySnapshot snapshot) {
    return snapshot.documents.map((com) {
      return Comment(
        name: com.data['userName'],
        postUid: com.data['postId'],
        comment: com.data['comment'],
        timeStamp: com.data['timeStamp'] ?? '',
        userImageUrl: com.data['userImageUrl'],
      );
    }).toList();
  }
}
