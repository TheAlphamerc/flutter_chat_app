import 'package:flutter/material.dart';
import 'package:flutter_chat_app/locator.dart';
import 'package:flutter_chat_app/model/chat_message.dart';
import 'package:flutter_chat_app/model/user.dart';
import 'package:flutter_chat_app/service/repository.dart';
import 'package:rxdart/rxdart.dart';

class AppState extends ChangeNotifier {
  bool _isBusy;
  bool get isbusy => _isBusy;

  BehaviorSubject<int> pageIndex = BehaviorSubject()..add(0);
  set setpageIndex(int index) {
    pageIndex.value = index;
  }

  final repo = getIt<Repository>();
  Stream<List<User>> getAllUSerList(String myId) => repo.getAllUsersList();
  Stream<List<User>> getChatUsersList(String myId) => repo.getChatUsersList(myId);

  @override
  void dispose() {
    pageIndex.close();
    super.dispose();
  }
}
