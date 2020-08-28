import 'dart:async';

import 'package:audio_recorder/audio_recorder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:news_feed/Constant/constant.dart';
import 'package:news_feed/Screens/chatting/list_chat.dart';
import 'package:news_feed/models/User.dart';
import 'package:news_feed/models/message.dart';
import 'package:news_feed/services/permission.dart';
import 'package:news_feed/services/record_services.dart';
import 'package:provider/provider.dart';

class Chatting extends StatefulWidget {
  final User freind;
  final String chatId;

  Chatting({this.freind, this.chatId});

  @override
  _ChattingState createState() => _ChattingState();
}

class _ChattingState extends State<Chatting> {
  RecordServices _recordServices = RecordServices();
  Message message = Message();

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  bool recording = false;
  bool sending = false;

  String _timeString;
  Timer t;

  @override
  void initState() {
    _timeString = DateFormat('yyyy-MM-dd  HH:mm:ss').format(DateTime.now());
    t = Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  void _getTime() {
    final String formattedDateTime = DateFormat().add_yMd().add_jms().format(DateTime.now());
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  @override
  void dispose() {
    t.cancel();
    super.dispose();
  }

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
                    Expanded(
                      child: SpinKitFoldingCube(
                        color: Theme.of(context).primaryColor,
                        size: 18.0,
                      ),
                    ),
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
                    sending == true
                        ? Text(
                            'Sending..',
                            style: TextStyle(color: Colors.red),
                          )
                        : Container(),
                    messageSendBar(),
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
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                Icons.mic,
                color: recording == true ? Colors.greenAccent : Theme.of(context).iconTheme.color,
              ),
            ),
            onLongPress: () async {
              if (await AudioRecorder.hasPermissions) {
                _recordServices
                    .startRecording(_timeString)
                    .whenComplete(() => setState(() => recording = true));
              } else {
                await Permissions().askForAppPermissions();
              }
            },
            onLongPressEnd: (details) async {
              if (await AudioRecorder.hasPermissions) {
                setState(
                  () => setState(() {
                    recording = false;
                    sending = true;
                  }),
                );
                _recordServices.stopRecording().then(
                      (record) => _recordServices
                          .uploadRecord(
                            chatId: widget.chatId,
                            recordingFile: record,
                            time: _timeString,
                          )
                          .then(
                            (url) => message.sendMessage(
                              chatId: widget.chatId,
                              userId: currentUser.userId,
                              friendImg: currentUser.photoUrl,
                              message: url,
                              type: 'record',
                              time: _timeString,
                            ),
                          )
                          .whenComplete(
                            () => setState(() {
                              recording = false;
                              sending = false;
                            }),
                          ),
                    );
              }
            },
          ),
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
                  type: 'message',
                  time: _timeString,
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
