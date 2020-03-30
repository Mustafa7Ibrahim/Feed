import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final CollectionReference userCollection =
    Firestore.instance.collection('users');

// this is the post collection
final CollectionReference postCollection =
    Firestore.instance.collection('posts');

final CollectionReference commentsCollection =
    Firestore.instance.collection('comments');

Color forgroungColor = Color.fromRGBO(30, 30, 30, 1);
// Color forgroungColor = Color.fromRGBO(30, 30, 30, 1.0);
Color backgroundColor = Colors.black;

Color grayColor = Colors.grey;
Color textColor = Colors.white;

Color homeColor = Color.fromRGBO(24, 41, 82, 1);
Color chatColor = Color.fromRGBO(43, 53, 149, 1);
Color addPostColor = Color.fromRGBO(112, 69, 175, 1);
Color profileColor = Color.fromRGBO(225, 69, 148, 1);
Color settingsColor = Color.fromRGBO(70, 181, 209, 1);
