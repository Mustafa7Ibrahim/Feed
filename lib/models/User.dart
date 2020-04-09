import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_feed/Constant/constant.dart';

class User {
  final String userId;
  final String name;
  final String email;
  final String photoUrl;

  final FirebaseAuth _auth = FirebaseAuth.instance;

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
      userId: document.data['id'] ?? '',
      email: document.data['email'] ?? '',
      name: document.data['name'] ?? '',
      photoUrl: document.data['photoUrl'] ?? null,
    );
  }

  Stream<User> get userData{
    return userCollection.document().snapshots().map(getUserData);
  }

  User getCurrentUser(FirebaseUser user) {
    return user != null
        ? User(
            userId: user.uid ?? '',
            name: user.displayName ?? '',
            photoUrl: user.photoUrl ?? '',
            email: user.email ?? '',
          )
        : null;
  }

  Stream<User> get currentUser {
    return _auth.onAuthStateChanged.map(getCurrentUser);
  }

  List<User> getListOfUsers(QuerySnapshot snapshot) {
    return snapshot.documents.map((user) {
      return User(
        userId: user.data['id'],
        name: user.data['name'],
        email: user.data['email'],
        photoUrl: user.data['photoUrl'],
      );
    }).toList();
  }

  Stream<List<User>> get listOfUsers {
    return userCollection.snapshots().map(getListOfUsers);
  }
}
