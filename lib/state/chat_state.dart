import 'package:flutter/material.dart';
import 'package:flutter_chat_app/model/chat_message.dart';
import 'package:flutter_chat_app/model/user.dart';

class ChatState extends ChangeNotifier {
  List<ChatMessage> messageList = [
    ChatMessage(
      createdAt: DateTime.now().add(Duration(minutes: -4)).toUtc().toString(),
      key: "asdf",
      message: "Hello",
      receiverId: "1234",
      seen: false,
      senderId: "abcd",
      senderName: "Shubham",
    ),
    ChatMessage(
      createdAt: DateTime.now().add(Duration(minutes: -5)).toUtc().toString(),
      key: "asdf",
      message: "Hey",
      receiverId: "1234",
      seen: false,
      senderId: "asdf",
      senderName: "Shubham",
    ),
    ChatMessage(
      createdAt: DateTime.now().add(Duration(days: -4)).toUtc().toString(),
      key: "asdf",
      message: "How are you? :)",
      receiverId: "1234",
      seen: false,
      senderId: "asdf",
      senderName: "Shubham",
    ),
    
  ];

  var chatUser = User(
    displayName: "Sonu Sharma",
    userName: "@TheALphamerc",
    userId: "asdf"
  );
  
}