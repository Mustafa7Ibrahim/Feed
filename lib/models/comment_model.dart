import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:news_feed/Constant/constant.dart';

class CommentModel {
  final String name;
  final String comment;
  final String postUid;
  final String timeStamp;
  final String userImageUrl;

  CommentModel({
    this.name,
    this.comment,
    this.timeStamp,
    this.userImageUrl,
    this.postUid,
  });

  String formattedDate = DateFormat().add_yMEd().add_jm().format(DateTime.now());

  Future addNewComment({String comment, String postId}) async {
    User user = FirebaseAuth.instance.currentUser;
    return await postCollection.doc(postId).collection('comments').doc().set({
      'postId': postId,
      'comment': comment,
      'userName': user.displayName,
      'userImageUrl': user.photoURL,
      'timeStamp': formattedDate,
    });
  }

  List<CommentModel> commentsList(QuerySnapshot snapshot) {
    return snapshot.docs.map((com) {
      return CommentModel(
        name: com.data()['userName'],
        postUid: com.data()['postId'],
        comment: com.data()['comment'],
        timeStamp: com.data()['timeStamp'] ?? '',
        userImageUrl: com.data()['userImageUrl'],
      );
    }).toList();
  }
}
