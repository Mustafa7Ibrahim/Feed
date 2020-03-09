import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_feed/Auth/Auth.dart';

class Collection {
  // this is the user collection
  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  // this is the post collection
  final CollectionReference postCollection =
      Firestore.instance.collection('posts');

  // this is ths feed collection
  final CollectionReference feedCollection =
      Firestore.instance.collection('feed');

  // an object of auth
  Auth _auth = Auth();

  // this fuction whene you upload a new post
  Future uploadPost({String name, String content, String imageUrl}) async {
    return await postCollection.document(_auth.userId).setData({
      'name': name,
      'content': content,
      'imageUrl': imageUrl,
    });
  }
}
