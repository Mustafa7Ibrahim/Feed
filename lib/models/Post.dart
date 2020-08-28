import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:news_feed/Constant/constant.dart';

class Post {
  final String ownerId;
  final String userName;
  final String description;
  final String mediaUrl;
  final String userProfileImg;
  final String timeStamp;
  final postId;

  String formattedDate = DateFormat().add_yMEd().add_jm().format(DateTime.now());

  Post({
    this.ownerId,
    this.userName,
    this.description,
    this.mediaUrl,
    this.userProfileImg,
    this.timeStamp,
    this.postId,
  });

  Future addNewPost({String description, String mediaUrl}) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return await postCollection.document().setData({
      'ownerId': user.uid,
      'userName': user.displayName,
      'description': description,
      'mediaUrl': mediaUrl,
      'timeStamp': formattedDate,
      'userProfileImg': user.photoUrl,
    });
  }

  List<Post> postsList(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Post(
        postId: doc.documentID,
        ownerId: doc.data['ownerId'],
        userName: doc.data['userName'],
        description: doc.data['description'],
        userProfileImg: doc.data['userProfileImg'],
        mediaUrl: doc.data['mediaUrl'],
        timeStamp: doc.data['timeStamp'],
      );
    }).toList();
  }

  Stream<List<Post>> get getPosts {
    return postCollection.orderBy('timeStamp', descending: true).snapshots().map(postsList);
  }
}
