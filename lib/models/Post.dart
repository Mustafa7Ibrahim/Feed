import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_feed/Constant/constant.dart';
import 'package:uuid/uuid.dart';

final DateTime _dateTime = DateTime.now();
final String gPostId = Uuid().v4();

class Post {
  final String postId;
  final String ownerId;
  final String userName;
  final String description;
  final String mediaUrl;
  final String userProfileImg;
  final String timeStamp;

  Post({
    this.postId,
    this.ownerId,
    this.userName,
    this.description,
    this.mediaUrl,
    this.userProfileImg,
    this.timeStamp,
  });

  // Post getPostData(DocumentSnapshot document) {
  //   return Post(
  //       postId: document['postId'],
  //       ownerId: document['ownerId'],
  //       userName: document['username'],
  //       description: document['description'],
  //       mediaUrl: document['mediaUrl'],
  //       timeStamp: document['timeStamp'],
  //       userProfileImg: document['userProfileImg']);
  // }

  // Stream<Post> get getpost {
  //   return postCollection
  //       .document(ownerId)
  //       .collection('userPosts')
  //       .document(postId)
  //       .snapshots()
  //       .map(getPostData);
  // }

  Future addNewPost({String description, String mediaUrl}) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return await postCollection
        .document(user.uid)
        .collection('userPosts')
        .document(gPostId)
        .setData({
      'postId': gPostId,
      'ownerId': user.uid,
      'userName': user.displayName,
      'description': description,
      'mediaUrl': mediaUrl,
      'timeStamp': _dateTime,
      'userProfileImg': user.photoUrl,
    });
  }

  List<Post> postsList(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Post(
        postId: doc.data['postId'],
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
        .document()
        .collection('userPosts')
        .snapshots()
        .map(postsList);
  }
}
