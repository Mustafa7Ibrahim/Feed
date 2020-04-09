import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference userCollection =
    Firestore.instance.collection('users');

// this is the post collection
final CollectionReference postCollection =
    Firestore.instance.collection('posts');

final CollectionReference commentsCollection =
    Firestore.instance.collection('comments');

final CollectionReference chatCollection =
    Firestore.instance.collection('Chat');

// Color forgroungColor = Colors.white;
// Color backgroundColor = Color.fromRGBO(240, 240, 240, 1);

// Color grayColor = Colors.white;
// Color whiteColor = Colors.white;
// Color blackColor = Color.fromRGBO(105,105,105 ,1);

// Color homeColor = Color.fromRGBO(55, 105, 150, 1);
// Color chatColor = Color.fromRGBO(99, 105, 209, 1);
// Color addPostColor = Color.fromRGBO(29, 52, 97, 1);
// Color profileColor = Color.fromRGBO(31, 72, 126, 1);
// Color settingsColor = Color.fromRGBO(70, 181, 209, 1);
