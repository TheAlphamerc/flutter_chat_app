import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_app/helper/utility.dart';
import 'package:flutter_chat_app/locator.dart';
import 'package:flutter_chat_app/model/chat_message.dart';
import 'package:flutter_chat_app/model/user.dart';
import 'package:flutter_chat_app/service/repository.dart';
import 'package:flutter_chat_app/state/auth_state.dart';
import 'package:flutter_chat_app/state/chat_state.dart';
import 'package:flutter_chat_app/theme/styles.dart';
import 'package:flutter_chat_app/widgets/customWidgets.dart';
import 'package:flutter_chat_app/theme/extentions.dart';
import 'package:provider/provider.dart';
import 'package:flutter_chat_app/theme/extentions.dart';

class ChatScreenPage extends StatelessWidget {
  ChatScreenPage({Key key}) : super(key: key);
  Widget _appBar(BuildContext context) {
    var state = Provider.of<ChatState>(context, listen: false);
    return StreamBuilder(
        stream: state.chatUser,
        builder: (context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            return Row(
              children: <Widget>[
                userAvatar(snapshot.data, radius: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(snapshot.data.displayName,
                        style: TextStyles.titleMedium.white),
                    Text('online', style: TextStyles.bodySm.dimWhite),
                  ],
                ).hP16,
                Spacer(),
              ],
            );
          } else {
            return LinearProgressIndicator();
          }
        });
  }

  final messageController = new TextEditingController();
  String senderId = "abcd";
  String userImage;
  String message;
  ScrollController _controller;

  Widget _messageList(BuildContext context) {
    final state = Provider.of<ChatState>(context);
    return StreamBuilder(
      stream: state.getMessageList,
      builder: (context, AsyncSnapshot<ChatResponse> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            controller: _controller,
            shrinkWrap: true,
            reverse: true,
            physics: BouncingScrollPhysics(),
            itemCount: snapshot.data?.data?.length ?? 0,
            itemBuilder: (context, index) => chatMessage(
                context, snapshot.data.data[index],
                isLastMessage: index == 0, index: index),
          );
        }
        if (snapshot.connectionState == ConnectionState.done ||
            snapshot.connectionState == ConnectionState.active) {
          return Center(
            child: Text("No message available"),
          );
        }
        return loader();
      },
    );
  }

  Widget chatMessage(BuildContext context, ChatMessage message,
      {bool isLastMessage, int index}) {
    if (senderId == null) {
      return Container();
    }
    if (message.senderId == senderId)
      return _message(context, message, true, isLastMessage: isLastMessage);
    else
      return _message(
        context,
        message,
        false,
        isLastMessage: isLastMessage,
      );
  }

  Widget _message(
    BuildContext context,
    ChatMessage chat,
    bool myMessage, {
    bool isLastMessage,
  }) {
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
        ).hP16,
        SizedBox(height: isLastMessage ? 70 : 0)
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
              submitMessage(context, val);
            },
            onChanged: (val) {
              message = val;
            },
            style: TextStyles.titleMedium.white,
            controller: messageController,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 16, right: 0, top: 10),
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
                          onPressed: () {
                            submitMessage(context, message);
                          },
                        ),
                      )).p(8),
                ),
                hintStyle: TextStyles.title.dimWhite,
                border: InputBorder.none,
                fillColor: Colors.black54,
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

  void submitMessage(BuildContext context, String text) {
    if (text == null || text.isEmpty) {
      return;
    }
    final state = Provider.of<ChatState>(context, listen: false);
    final authState = Provider.of<AuthState>(context, listen: false);
    final messageModel = ChatMessage(
      createdAt: DateTime.now().toUtc().toString(),
      message: text,
      receiverId: state.chatUser.value.userId,
      senderId: authState.user.uid,
      senderName: authState.user.displayName,
      seen: false,
    );

    state.sendMessage(messageModel, authState.userModel);
    message = "";
    WidgetsBinding.instance
        .addPostFrameCallback((_) => messageController.clear());
  }

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthState>(context, listen: false);
    senderId = authState.user.uid;
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
            },
          ),
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
                child: _messageList(context),
              ),
              _bottomEntryField(context)
            ],
          ),
        ),
      ),
    );
  }
}
