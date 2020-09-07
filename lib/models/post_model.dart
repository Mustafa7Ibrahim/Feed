import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:news_feed/Constant/constant.dart';

class PostModel {
  final String ownerId;
  final String userName;
  final String description;
  final String mediaUrl;
  final String userProfileImg;
  final String timeStamp;
  final postId;

  String formattedDate = DateFormat().add_yMEd().add_jm().format(DateTime.now());

  PostModel({
    this.ownerId,
    this.userName,
    this.description,
    this.mediaUrl,
    this.userProfileImg,
    this.timeStamp,
    this.postId,
  });

  Future addNewPost({String description, String mediaUrl}) async {
    User user = FirebaseAuth.instance.currentUser;
    return await postCollection.doc().set({
      'ownerId': user.uid,
      'userName': user.displayName,
      'description': description,
      'mediaUrl': mediaUrl,
      'timeStamp': formattedDate,
      'userProfileImg': user.photoURL,
    });
  }

  List<PostModel> postsList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return PostModel(
        postId: doc.id,
        ownerId: doc.data()['ownerId'],
        userName: doc.data()['userName'],
        description: doc.data()['description'],
        userProfileImg: doc.data()['userProfileImg'],
        mediaUrl: doc.data()['mediaUrl'],
        timeStamp: doc.data()['timeStamp'],
      );
    }).toList();
  }

  Stream<List<PostModel>> get getPosts {
    return postCollection.orderBy('timeStamp', descending: true).snapshots().map(postsList);
  }
}
