import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_feed/Constant/constant.dart';

class UserModel {
  final String userId;
  final String name;
  final String email;
  final String photoUrl;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel({
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
    return await userCollection.doc(id).set({
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
    });
  }

  UserModel getUserData(DocumentSnapshot document) {
    return UserModel(
      userId: document.data()['id'] ?? '',
      email: document.data()['email'] ?? '',
      name: document.data()['name'] ?? '',
      photoUrl: document.data()['photoUrl'] ?? null,
    );
  }

  Stream<UserModel> get userData {
    return userCollection.doc().snapshots().map(getUserData);
  }

  UserModel getCurrentUser(User user) {
    return user != null
        ? UserModel(
            userId: user.uid ?? '',
            name: user.displayName ?? '',
            photoUrl: user.photoURL ?? '',
            email: user.email ?? '',
          )
        : null;
  }

  Stream<UserModel> get currentUser {
    return _auth.authStateChanges().map(getCurrentUser);
  }

  List<UserModel> getListOfUsers(QuerySnapshot snapshot) {
    return snapshot.docs.map((user) {
      return UserModel(
        userId: user.data()['id'],
        name: user.data()['name'],
        email: user.data()['email'],
        photoUrl: user.data()['photoUrl'],
      );
    }).toList();
  }

  Stream<List<UserModel>> get listOfUsers {
    return userCollection.snapshots().map(getListOfUsers);
  }
}
