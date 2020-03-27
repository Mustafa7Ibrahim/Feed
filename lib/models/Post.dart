import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_feed/Constant/constant.dart';

class Post {
  final String ownerId;
  final String userName;
  final String description;
  final String mediaUrl;
  final String userProfileImg;
  final String timeStamp;

  DateTime _dateTime = DateTime.now();

  Post({
    this.ownerId,
    this.userName,
    this.description,
    this.mediaUrl,
    this.userProfileImg,
    this.timeStamp,
  });

  // Post getPostData(DocumentSnapshot document) {
  //   return Post(
  //       ownerId: document['ownerId'],
  //       userName: document['username'],
  //       description: document['description'],
  //       mediaUrl: document['mediaUrl'],
  //       timeStamp: document['timeStamp'],
  //       userProfileImg: document['userProfileImg']);
  // }

  // Stream<Post> get getpost {
  //   return postCollection.document(ownerId).snapshots().map(getPostData);
  // }

  Future addNewPost({String description, String mediaUrl}) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return await postCollection.document().setData({
      'ownerId': user.uid,
      'userName': user.displayName,
      'description': description,
      'mediaUrl': mediaUrl,
      'timeStamp': _dateTime.toString(),
      'userProfileImg': user.photoUrl,
    });
  }

  List<Post> postsList(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Post(
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
    return postCollection
        .orderBy('timeStamp', descending: true)
        .snapshots()
        .map(postsList);
  }
}
