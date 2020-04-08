import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_app/helper/logger.dart';
import 'package:flutter_chat_app/model/user.dart';

enum AuthProblems { UserNotFound, PasswordNotValid, NetworkError }

class FirebaseService {
  var _fireStoreInstance = Firestore.instance;
  final logger = getLogger("FirebaseService");

  Stream<List<User>> getUsers() async* {
    await for (QuerySnapshot data
        in _fireStoreInstance.collection("users").snapshots()) {
      final list = data.documents.map((d) => User.fromJson(d.data)).toList();
      yield list;
    }
  }

  saveUser(User user) async {
    _fireStoreInstance
        .collection("users")
        .document(user.userId)
        .setData(user.toJson());
  }

  Future<User> getUser(FirebaseUser user) async {
    final doc =
        await _fireStoreInstance.collection("users").document(user.uid).get();
    return User.fromJson(doc.data);
  }
}
