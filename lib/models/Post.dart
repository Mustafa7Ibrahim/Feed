import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String postId;
  final String ownerId;
  final String userName;
  final String description;
  final String mediaUrl;

  Post({
    this.postId,
    this.ownerId,
    this.userName,
    this.description,
    this.mediaUrl,
  });

  factory Post.getPostData(DocumentSnapshot document) {
    return Post(
      postId: document['postId'],
      ownerId: document['ownerId'],
      userName: document['username'],
      description: document['description'],
      mediaUrl: document['mediaUrl'],
    );
  }
}
