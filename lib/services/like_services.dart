import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:news_feed/constant/constant.dart';
import 'package:news_feed/models/like_model.dart';

class LikeServices {
  likePost({String postID}) async {
    User user = FirebaseAuth.instance.currentUser;
    final like = await postCollection.doc(postID).collection('likes').doc(user.uid).get();

    if (like.exists)
      _removeLike(like);
    else
      _addLike(postID, like, user);

    _updateLikesNumber(postID);
  }

  _updateLikesNumber(String postId) async {
    int likesNumber;
    QuerySnapshot likesData = await postCollection.doc(postId).collection('likes').get();
    likesNumber = likesData.docs.length;
    await postCollection.doc(postId).update({'likesNumber': likesNumber});
  }

  Future<bool> checkIfUserAlreadyLikePost(String postID) async {
    User user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot like =
        await postCollection.doc(postID).collection('likes').doc(user.uid).get();
    if (like.exists) {
      return true;
    } else {
      return false;
    }
  }

  _removeLike(DocumentSnapshot like) async {
    await like.reference.delete();
  }

  _addLike(String postID, DocumentSnapshot like, User user) async {
    final String likeDate = DateFormat().add_yMd().add_jms().format(DateTime.now());
    return like.reference.set({
      'postId': postID,
      'userName': user.displayName,
      'userImgURL': user.photoURL,
      'userID': user.uid,
      'likeDate': likeDate,
      'like': true,
    });
  }

  List<LikeModel> likesList(QuerySnapshot snapshot) {
    return snapshot.docs
        .map(
          (like) => LikeModel(
            likeDate: like.data()['likeDate'],
            postId: like.data()['postId'],
            userID: like.data()['userID'],
            userImgURL: like.data()['userImgURL'],
            userName: like.data()['userName'],
          ),
        )
        .toList();
  }
}
