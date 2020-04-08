import 'package:flutter_chat_app/helper/logger.dart';
import 'package:flutter_chat_app/locator.dart';
import 'package:flutter_chat_app/model/user.dart';
import 'package:flutter_chat_app/service/auth_service.dart';
import 'package:flutter_chat_app/service/firebase_service.dart';
import 'package:rxdart/subjects.dart';

class UsersRepository {
  BehaviorSubject<List<User>> users = BehaviorSubject();
  final logger = getLogger("UserRepository");

  UsersRepository() {
    _init();
  }

  _init() {
    getIt<FirebaseService>().getUsers().listen((data) {
      users.add(data);
      logger.i("${data.length} User fetched");
    });
  }
}
