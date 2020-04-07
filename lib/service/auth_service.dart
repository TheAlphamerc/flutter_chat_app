import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_chat_app/helper/enum.dart';
import 'package:flutter_chat_app/model/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final DatabaseReference kDatabase = FirebaseDatabase.instance.reference();

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
      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  /// Create user profile from google login
  createUserFromGoogleSignIn(FirebaseUser user) {
    var diff = DateTime.now().difference(user.metadata.creationTime);
    // Check if user is new or old
    // If user is new then add new user to firebase realtime kDatabase
    // if (diff < Duration(seconds: 15)) {
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
      createUser(model, newUser: true);
    // } else {
    //   print('Last login at: ${user.metadata.lastSignInTime}');
    // }
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
  }

  String getUserName({String name, String id}) {
    String userName = '';
    name = name.split(' ')[0];
    id = id.substring(0, 4).toLowerCase();
    userName = '@$name$id';
    return userName;
  }
}
