import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_feed/Constant/constant.dart';
import 'package:news_feed/Screens/chatting/list_chat.dart';
import 'package:news_feed/models/User.dart';
import 'package:news_feed/models/message.dart';
import 'package:provider/provider.dart';

class Chatting extends StatefulWidget {
  final User user;

  Chatting({this.user});

  @override
  _ChattingState createState() => _ChattingState();
}

class _ChattingState extends State<Chatting> {
  Message message = Message();
  String theMessage;
  String chatId;

  @override
  void initState() {
    super.initState();
    chatIdGen();
  }

  chatIdGen() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String currentUser = user.uid;
    String friend = widget.user.userId;

    if (int.parse(currentUser) > int.parse(friend))
      return setState(() => chatId = '$user+$friend');
    else
      return setState(() => chatId = '$friend+$user');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: chatCollection
          .document(chatId)
          .collection('messages')
          .snapshots()
          .map(message.messageList),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.user.name),
            centerTitle: true,
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: snapshot?.data?.leanth ?? 0,
                  itemBuilder: (context, index) {
                    return ListChat(
                      message: snapshot.data[index],
                      friend: widget.user,
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(24.0),
                ),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.add_photo_alternate),
                      onPressed: () {
                        //send photo
                      },
                    ),
                    Expanded(
                      child: TextFormField(
                        initialValue: null,
                        onChanged: (input) =>
                            setState(() => theMessage = input),
                        decoration: InputDecoration(
                          hintText: 'Type Your Message Here',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.0),
                            borderSide: BorderSide(
                              width: 1,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.0),
                            borderSide: BorderSide(
                              width: 1,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () async {
                        message.sendMessage(
                          chatId: chatId,
                          userId: widget.user.userId,
                          friendImg: widget.user.photoUrl,
                          message: theMessage,
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
