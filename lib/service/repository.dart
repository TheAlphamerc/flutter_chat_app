import 'package:flutter_chat_app/helper/logger.dart';
import 'package:flutter_chat_app/locator.dart';
import 'package:flutter_chat_app/model/chat_message.dart';
import 'package:flutter_chat_app/model/user.dart';
import 'package:flutter_chat_app/service/firebase_service.dart';
import 'package:rxdart/subjects.dart';

class Repository {
  final logger = getLogger("UserRepository");
  final getit = getIt<FirebaseService>();

  Stream<ChatResponse>  getMessageList(String channelName) => getit.getChatMessage(channelName);
  Stream<List<User>>  getAllUsersList() => getit.getAllUsers();
  Stream<List<User>>  getChatUsersList(String myId) => getit.getchatUsers(myId);
  sendMessage(ChatMessage message,{ User myUser,  User chatUser, bool isNewChat}){
        getit.sendMessage(message, myUser: myUser, chatUser: chatUser, isNewChat: true);
  }
 
}
