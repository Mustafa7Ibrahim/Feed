import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_feed/Auth/Auth.dart';
import 'package:news_feed/Constant/constant.dart';

class User {
  final String userId;
  final String name;
  final String email;
  final String photoUrl;

  Auth _auth = Auth();

  User({
    this.userId,
    this.name,
    this.photoUrl,
    this.email,
  });

  Future addNewUser(
    String id,
    String name,
    String email,
    String photoUrl,
  ) async {
    return await userCollection.document(id).setData({
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
    });
  }

  User getUserData(DocumentSnapshot document) {
    return User(
        userId: document.data['id'],
        email: document.data['email'],
        name: document.data['name'],
        photoUrl: document.data['photoUrl']);
  }

  Stream<User> get userData {
    return userCollection.document(_auth.id).snapshots().map(getUserData);
  }
}
