import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/helper/enum.dart';
import 'package:flutter_chat_app/locator.dart';
import 'package:flutter_chat_app/model/user.dart';
import 'package:flutter_chat_app/service/auth_service.dart';

class AuthState extends ChangeNotifier {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  bool isSignInWithGoogle = false;
  FirebaseUser user;
  String userId;
  User _userModel;
  final getit = getIt<AuthService>();
  User get userModel => _userModel;

  Future<void> loginViaGoogle() {
    getit.handleGoogleSignIn().then((user) {
      print(user.displayName);
      return user;
    }).then((user){
      getit.createUserFromGoogleSignIn(user);
    }).catchError((error) {
      print(error);
    });
    return null;
  }
}
