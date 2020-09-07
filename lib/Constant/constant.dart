import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

final CollectionReference postCollection = FirebaseFirestore.instance.collection('posts');

final CollectionReference commentsCollection = FirebaseFirestore.instance.collection('comments');

final CollectionReference chatCollection = FirebaseFirestore.instance.collection('Chat');
