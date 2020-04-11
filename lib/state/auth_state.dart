import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/helper/enum.dart';
import 'package:flutter_chat_app/helper/logger.dart';
import 'package:flutter_chat_app/helper/utility.dart';
import 'package:flutter_chat_app/locator.dart';
import 'package:flutter_chat_app/model/user.dart';
import 'package:flutter_chat_app/service/auth_service.dart';
import 'package:rxdart/rxdart.dart';

class AuthState extends ChangeNotifier {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  BehaviorSubject<AuthStatus> loginStatus = BehaviorSubject()
    ..add(AuthStatus.NOT_DETERMINED);
  bool isSignInWithGoogle = false;
  FirebaseUser user;

  String userId;
  User _userModel;

  final getit = getIt<AuthService>();
  User get userModel => _userModel;

  /// Asynchronously signs in to Firebase with the google email
  /// If successful, it also signs the user in into the app and updates the [onAuthStateChanged] stream.
  /// If the user doesn't have an account already, one will be created automatically.
  loginViaGoogle() {
    getit.handleGoogleSignIn().then((user) {
      this.user = user;
      loginStatus.add(AuthStatus.LOGGED_IN);
      return user;
    }).then((user) {
      _userModel = getit.createUserFromGoogleSignIn(user);
    }).catchError((error) {
      cprint(error, errorIn: "loginViaGoogle");
      loginStatus.add(AuthStatus.NOT_LOGGED_IN);
    });
  }

  /// Asynchronously logout from firebase
  logout() {
    getit.logout();
    loginStatus.add(AuthStatus.NOT_LOGGED_IN);
  }

  @override
  void dispose() {
    loginStatus.close();
    super.dispose();
  }
}
