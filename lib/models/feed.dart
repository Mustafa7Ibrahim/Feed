import 'package:cloud_firestore/cloud_firestore.dart';

class Feed {
  final String postId;
  final String userId;
  final String userName;
  final String mediaUrl;
  final String userProfileImg;
  final Timestamp timeStamp;

  Feed({
    this.postId,
    this.userId,
    this.userName,
    this.mediaUrl,
    this.userProfileImg,
    this.timeStamp,
  });

  factory Feed.getFeedData(DocumentSnapshot document){

    return Feed(
      postId: document['postId'],
      userId: document['userId'],
      userName: document['userName'],
      mediaUrl: document['mediaUrl'],
      userProfileImg: document['userProfileImg'],
      timeStamp: document['timeStamp']
    );
  }
}
