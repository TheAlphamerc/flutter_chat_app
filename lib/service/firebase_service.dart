import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/helper/logger.dart';
import 'package:flutter_chat_app/helper/utility.dart';
import 'package:flutter_chat_app/model/chat_message.dart';
import 'package:flutter_chat_app/model/user.dart';

enum AuthProblems { UserNotFound, PasswordNotValid, NetworkError }

class FirebaseService {
  var _fireStoreInstance = Firestore.instance;
  final logger = getLogger("FirebaseService");

  Stream<List<User>> getAllUsers() async* {
    await for (QuerySnapshot data
        in _fireStoreInstance.collection("users").snapshots()) {
      final list = data.documents.map((d) => User.fromJson(d.data)).toList();
      logger.i("Fetch user list: ${list.length}");
      yield list;
    }
  }

  Stream<List<User>> getchatUsers(String myId) async* {
    print(myId);
    var data = await _fireStoreInstance
        .collection("Messenger")
        .document("chatUsers")
        .collection(myId)
        .getDocuments();
    final list = data.documents.map((d) {
      var user = User.fromJson(d.data);
      return user;
    }).toList();
    logger.i("Fetch chat user list: ${list.length}");
    yield list;
  }

  Future<User> getUserProfile(FirebaseUser user) async {
    final doc =
        await _fireStoreInstance.collection("users").document(user.uid).get();
    return User.fromJson(doc.data);
  }

  sendMessage(ChatMessage message,
      {@required User myUser,
      @required User chatUser,
      @required bool isNewChat}) {
    final chanelName = getChannelName(myUser.userId, chatUser.userId);
    if (isNewChat) {
      _fireStoreInstance
          .collection("Messenger")
          .document("chatUsers")
          .collection(myUser.userId)
          .document(chatUser.userId)
          .setData(chatUser.toJson());
      _fireStoreInstance
          .collection("Messenger")
          .document("chatUsers")
          .collection(chatUser.userId)
          .document(myUser.userId)
          .setData(myUser.toJson());
    }
    _fireStoreInstance
        .collection("Messenger")
        .document("chats")
        .collection(chanelName)
        .document()
        .setData(message.toJson());
  }

  Stream<ChatResponse> getChatMessage(String channelName) async* {
    await for (QuerySnapshot data in _fireStoreInstance
        .collection("Messenger")
        .document("chats")
        .collection(channelName)
        .orderBy("created_at")
        .snapshots()) {
      final list = data.documents.map((d) {
        var dd = ChatMessage.fromJson(d.data);
        return dd;
      }).toList();
      logger.i("Fetch chat message list: ${list.length}");
      yield list != null && list.length > 0
          ? ChatResponse(data: list.reversed.toList())
          : null;
    }
  }
}
