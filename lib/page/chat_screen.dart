import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_app/helper/utility.dart';
import 'package:flutter_chat_app/model/chat_message.dart';
import 'package:flutter_chat_app/model/user.dart';
import 'package:flutter_chat_app/state/chat_state.dart';
import 'package:flutter_chat_app/theme/styles.dart';
import 'package:flutter_chat_app/widgets/customWidgets.dart';
import 'package:flutter_chat_app/theme/extentions.dart';
import 'package:provider/provider.dart';
import 'package:flutter_chat_app/theme/extentions.dart';

class ChatScreenPage extends StatelessWidget {
  ChatScreenPage({Key key}) : super(key: key);
  Widget _appBar(BuildContext context) {
    return Row(
      children: <Widget>[
        userAvatar(null, radius: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Michel', style: TextStyles.titleMedium.white),
            Text('online', style: TextStyles.bodySm.dimWhite),
          ],
        ).hP16,
        Spacer(),
      ],
    );
  }

  final messageController = new TextEditingController();
  String senderId = "abcd";
  String userImage;
  ScrollController _controller;
  GlobalKey<ScaffoldState> _scaffoldKey;

  Widget _chatScreenBody(
    BuildContext context,
  ) {
    final state = Provider.of<ChatState>(context);
    if (state.messageList == null || state.messageList.length == 0) {
      return Center(
        child: Text(
          'No message found',
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
      );
    }
    return ListView.builder(
      controller: _controller,
      shrinkWrap: true,
      reverse: true,
      physics: BouncingScrollPhysics(),
      itemCount: state.messageList.length,
      itemBuilder: (context, index) =>
          chatMessage(context, state.messageList[index]),
    );
  }

  Widget chatMessage(BuildContext context, ChatMessage message) {
    if (senderId == null) {
      return Container();
    }
    if (message.senderId == senderId)
      return _message(context, message, true);
    else
      return _message(context, message, false);
  }

  Widget _message(BuildContext context, ChatMessage chat, bool myMessage) {
    return Column(
      crossAxisAlignment:
          myMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      mainAxisAlignment:
          myMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(width: 15),
            Expanded(
              child: Container(
                alignment:
                    myMessage ? Alignment.centerRight : Alignment.centerLeft,
                margin: EdgeInsets.only(
                  right: myMessage ? 10 : (fullWidth(context) / 4),
                  top: 20,
                  left: myMessage ? (fullWidth(context) / 4) : 0,
                ),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: getBorder(myMessage),
                    color: myMessage
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).secondaryHeaderColor,
                  ),
                  child: Text(
                    chat.message,
                    style: TextStyle(
                      fontSize: 16,
                    ).white,
                  ),
                ).ripple(
                  () {
                    var text = ClipboardData(text: chat.message);
                    Clipboard.setData(text);
                    Scaffold.of(context).hideCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Theme.of(context).selectedRowColor,
                        content: Text(
                          'Message copied',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    );
                  },
                  borderRadius: getBorder(myMessage),
                ),
              ),
            ),
          ],
        ),
        Text(
          getChatTime(chat.createdAt),
          style:
              Theme.of(context).textTheme.caption.copyWith(fontSize: 12).white,
        ).hP16
      ],
    );
  }

  BorderRadius getBorder(bool myMessage) {
    return BorderRadius.only(
      topLeft: myMessage ? Radius.circular(10) : Radius.circular(0),
      topRight: Radius.circular(10),
      bottomRight: myMessage ? Radius.circular(0) : Radius.circular(10),
      bottomLeft: Radius.circular(10),
    );
  }

  Widget _bottomEntryField(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          TextField(
            onSubmitted: (val) async {
              // submitMessage();
            },
            style: TextStyles.titleMedium.white,
            controller: messageController,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 16, right: 16, top: 10),
                alignLabelWithHint: true,
                hintText: 'Write something',
                suffixIcon: Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.centerRight,
                  child: CircleAvatar(
                      maxRadius: 50,
                      backgroundColor: Theme.of(context).secondaryHeaderColor,
                      child: Transform.rotate(
                        angle: 1.9 * pi * 2,
                        child: IconButton(
                          color: Theme.of(context).primaryColor,
                          padding: EdgeInsets.all(0),
                          icon: Icon(
                            Icons.send,
                            size: 20,
                          ),
                          onPressed: submitMessage,
                        ),
                      )).p(8),
                ),
                hintStyle: TextStyles.title.dimWhite,
                border: InputBorder.none,
                fillColor: Colors.black12,
                filled: true),
          ).circular,
        ],
      ),
    ).p(16);
  }

  Future<bool> _onWillPop() async {
    // final chatState = Provider.of<ChatState>(context);
    // chatState.setIsChatScreenOpen = false;
    // chatState.dispose();
    return true;
  }

  void submitMessage() {}
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<ChatState>(context, listen: false);
    userImage = state.chatUser.profilePic;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.keyboard_arrow_left,
                  size: 40, color: Theme.of(context).iconTheme.color),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          title: _appBar(context),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: () {})
          ],
        ),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 50),
                  child: _chatScreenBody(context),
                ),
              ),
              _bottomEntryField(context)
            ],
          ),
        ),
      ),
    );
  }
}
