import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_chat_app/helper/enum.dart';
import 'package:flutter_chat_app/helper/logger.dart';
import 'package:flutter_chat_app/helper/utility.dart';
import 'package:flutter_chat_app/model/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _fireStoreInstance = Firestore.instance;
  final DatabaseReference kDatabase = FirebaseDatabase.instance.reference();
  final log = getLogger("AuthService");
  Future<FirebaseUser> handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw Exception('Google login cancelled by user');
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      var user = (await _firebaseAuth.signInWithCredential(credential)).user;
      log.log(Level.info, "Google login success");
      return user;
    } catch (error) {
      log.e(error);
      return null;
    }
  }

  /// Create user profile from google login
  User createUserFromGoogleSignIn(FirebaseUser user) {
    var diff = DateTime.now().difference(user.metadata.creationTime);
    User model = User(
      bio: 'Edit profile to update bio',
      dob: DateTime(1950, DateTime.now().month, DateTime.now().day + 3)
          .toString(),
      location: 'Somewhere in universe',
      profilePic: user.photoUrl,
      displayName: user.displayName,
      email: user.email,
      key: user.uid,
      userId: user.uid,
      contact: user.phoneNumber,
      isVerified: user.isEmailVerified,
    );
    // Check if user is new or old
    // If user is new then add new user to firebase realtime kDatabase
    if (diff < Duration(seconds: 25)) {
      createUser(model, newUser: true);
      log.w("User created");
    }
    return model;
  }

  /// `Create` and `Update` user
  /// IF `newUser` is true new user is created
  /// Else existing user will update with new values
  createUser(User user, {bool newUser = false}) {
    if (newUser) {
      // Create username by the combination of name and id
      user.userName = getUserName(id: user.userId, name: user.displayName);

      // Time at which user is created
      user.createdAt = DateTime.now().toUtc().toString();
    }
    kDatabase.child('profile').child(user.userId).set(user.toJson());
    _fireStoreInstance
        .collection("users")
        .document(user.userId)
        .setData(user.toJson());

    log.log(Level.info, "User created");
  }

  void logout() {
    _firebaseAuth.signOut();
    _googleSignIn.signOut();
    log.wtf("Logout Sucess");
  }
}
