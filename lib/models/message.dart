import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_feed/Constant/constant.dart';

class Message {
  final String id;
  final String userId;
  final String friendId;
  final String message;
  final String timestamp;
  final String friendImg;

  String _dateTime = formatDate(
    DateTime.now(),
    [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn],
  );

  Message({
    this.id,
    this.userId,
    this.friendId,
    this.message,
    this.timestamp,
    this.friendImg,
  });

  Future sendMessage({
    String message,
    String userId,
    String friendImg,
    String chatId,
  }) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return await chatCollection
        .document(chatId)
        .collection('messages')
        .document()
        .setData({
      'userId': user.uid,
      'friendId': userId,
      'message': message,
      'timestamp': _dateTime.toString(),
      'friendImg': friendImg,
    });
  }

  List<Message> messageList(QuerySnapshot snapshot) {
    return snapshot.documents.map((mess) {
      return Message(
        id: mess.documentID,
        userId: mess.data['userId'],
        friendId: mess.data['friendId'],
        message: mess.data['message'],
        friendImg: mess.data['friendImg'],
        timestamp: mess.data['timestamp'],
      );
    }).toList();
  }
}
