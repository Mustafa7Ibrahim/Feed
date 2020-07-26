import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_feed/Constant/constant.dart';
import 'package:news_feed/Screens/chatting/list_chat.dart';
import 'package:news_feed/models/User.dart';
import 'package:news_feed/models/message.dart';
import 'package:provider/provider.dart';

class Chatting extends StatefulWidget {
  final User freind;
  final String chatId;

  Chatting({this.freind, this.chatId});

  @override
  _ChattingState createState() => _ChattingState();
}

class _ChattingState extends State<Chatting> {
  Message message = Message();

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.freind.name),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Message>>(
        stream: chatCollection
            .document(widget.chatId)
            .collection('messages')
            .orderBy('timestamp', descending: true)
            .limit(50)
            .snapshots()
            .map(message.messageList),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Column(
                  children: <Widget>[
                    Expanded(child: Container()),
                    messageSendBar(),
                  ],
                )
              : Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return ListChat(
                            message: snapshot.data[index],
                            friend: widget.freind,
                          );
                        },
                        reverse: true,
                        itemCount: snapshot.data.length,
                        controller: scrollController,
                      ),
                    ),
                    messageSendBar(),
                    // messageSendBar(),
                  ],
                );
        },
      ),
    );
  }

  messageSendBar() {
    final currentUser = Provider.of<User>(context);
    return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            offset: Offset(0, 8),
            color: Theme.of(context).iconTheme.color.withOpacity(0.1),
          ),
        ],
        color: Theme.of(context).appBarTheme.color,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Row(
        children: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.add_photo_alternate),
          //   onPressed: () {
          //     //send photo
          //   },
          // ),
          Expanded(
            child: TextFormField(
              scrollPadding: EdgeInsets.symmetric(horizontal: 12.0),
              controller: textEditingController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                hintText: 'Type Your Message ..',
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              if (textEditingController.text.trim().isNotEmpty) {
                message.sendMessage(
                  chatId: widget.chatId,
                  userId: currentUser.userId,
                  friendImg: currentUser.photoUrl,
                  message: textEditingController.text,
                );

                textEditingController.clear();

                scrollController.animateTo(
                  0.0,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              } else {
                Fluttertoast.showToast(msg: 'Please Type Your Message !');
              }
            },
          ),
        ],
      ),
    );
  }
}
