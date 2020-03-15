import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_feed/Auth/Auth.dart';
import 'package:news_feed/Constant/constant.dart';
import 'package:news_feed/models/User.dart';
import 'package:uuid/uuid.dart';

class Post {
  final String postId;
  final String ownerId;
  final String userName;
  final String description;
  final String mediaUrl;
  final String userProfileImg;
  final Timestamp timeStamp;

  final DateTime timestamp = DateTime.now();
  final String gPostId = Uuid().v4();
  final Auth auth = Auth();
  final User user = User();

  Post({
    this.postId,
    this.ownerId,
    this.userName,
    this.description,
    this.mediaUrl,
    this.userProfileImg,
    this.timeStamp,
  });

  Post getPostData(DocumentSnapshot document) {
    return Post(
        postId: document['postId'],
        ownerId: document['ownerId'],
        userName: document['username'],
        description: document['description'],
        mediaUrl: document['mediaUrl'],
        timeStamp: document['timeStamp'],
        userProfileImg: document['userProfileImg']);
  }

  Stream<Post> get getpost {
    return postCollection
        .document(auth.id)
        .collection('postCollection')
        .document(postId)
        .snapshots()
        .map(getPostData);
  }

  Future addNewPost({String description, String mediaUrl}) async {
    return await postCollection
        .document(auth.id)
        .collection('postCollection')
        .document(gPostId)
        .setData({
      'postId': gPostId,
      'ownerId': auth.id,
      'userName': user.name,
      'description': description,
      'mediaUrl': mediaUrl,
      'timeStamp': timeStamp,
      'userProfileImg': user.photoUrl,
    });
  }

  List<Post> postsList(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Post(
        postId: doc.data['postId'] ?? 'null',
        ownerId: doc.data['ownerId'] ?? 'null',
        userName: doc.data['userName'] ?? 'null',
        description: doc.data['description'] ?? 'null',
        userProfileImg: doc.data['userProfileImg'] ?? 'null',
        mediaUrl: doc.data[mediaUrl] ?? 'null',
        timeStamp: doc.data['timeStamp'] ?? 'null',
      );
    }).toList();
  }

  Stream<List<Post>> get getPosts {
    return postCollection.snapshots().map(postsList);
  }
}
