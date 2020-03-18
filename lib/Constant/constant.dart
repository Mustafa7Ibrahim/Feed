import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference userCollection =
    Firestore.instance.collection('users');

// this is the post collection
final CollectionReference postCollection =
    Firestore.instance.collection('posts');

