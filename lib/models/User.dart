import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String userId;
  final String name;
  final String email;
  final String photoUrl;

  User({
    this.userId,
    this.name,
    this.photoUrl,
    this.email,
  });

  factory User.getUserData(DocumentSnapshot document) {
    return User(
        userId: document.data['id'],
        email: document.data['email'],
        name: document.data['name'],
        photoUrl: document.data['photoUrl']);
  }
}
