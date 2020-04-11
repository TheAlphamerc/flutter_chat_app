import 'package:flutter/material.dart';
import 'package:flutter_chat_app/helper/utility.dart';
import 'package:flutter_chat_app/locator.dart';
import 'package:flutter_chat_app/model/chat_message.dart';
import 'package:flutter_chat_app/model/user.dart';
import 'package:flutter_chat_app/service/firebase_service.dart';
import 'package:flutter_chat_app/service/repository.dart';
import 'package:rxdart/rxdart.dart';

class ChatState extends ChangeNotifier {
  BehaviorSubject<User> chatUser = BehaviorSubject();
  // BehaviorSubject<ChatMessage> chat = BehaviorSubject();
  // BehaviorSubject<ChatResponse> chatMessageList = BehaviorSubject();
  // final getit = getIt<FirebaseService>();
  final repo = getIt<Repository>();
  List<ChatMessage> messageList = [];

  void selectUserToChat(User model, String myId) {
    chatUser.add(model);
    channelName = getChannelName(model.userId, myId);
  }

  static String channelName;
  Stream<ChatResponse> get getMessageList => repo.getMessageList(channelName);
  sendMessage(ChatMessage message, User myUser) {
    repo.sendMessage(message,
        myUser: myUser, chatUser: chatUser.value, isNewChat: true);
  }
}